import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../app/theme.dart';
import '../../data/models/expiry_item.dart';
import '../../data/services/ai_service.dart';
import '../../state/providers.dart';
import '../widgets/ai_panel.dart';
import '../widgets/cute_background.dart';
import '../widgets/mode_selector.dart';
import '../widgets/section_card.dart';
import 'add_item_types.dart';

class AddItemScreen extends ConsumerStatefulWidget {
  const AddItemScreen({super.key, required this.initialMode});

  final AddMode initialMode;

  @override
  ConsumerState<AddItemScreen> createState() => _AddItemScreenState();
}

class _AddItemScreenState extends ConsumerState<AddItemScreen> {
  final _nameController = TextEditingController();
  final _notesController = TextEditingController();
  final _aiTextController = TextEditingController();
  final _aiService = AiService();
  DateTime? _selectedDate;
  AddMode _mode = AddMode.manual;
  bool _aiLoading = false;

  @override
  void initState() {
    super.initState();
    _mode = widget.initialMode;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _notesController.dispose();
    _aiTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final appState = ref.watch(appStateProvider);
    final settings = appState.settings;
    final formattedDate = _selectedDate == null
        ? '选择到期日期'
        : DateFormat('yyyy/MM/dd').format(_selectedDate!);

    return Scaffold(
      appBar: AppBar(title: const Text('录入物品')),
      body: Stack(
        fit: StackFit.expand,
        children: [
          const CuteBackground(),
          SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ModeSelector(
                  mode: _mode,
                  onChanged: (mode) => setState(() => _mode = mode),
                ),
                const SizedBox(height: 16),
                if (_mode == AddMode.ai)
                  AiPanel(
                    controller: _aiTextController,
                    isConfigured: settings.isAiConfigured,
                    isLoading: _aiLoading,
                    onAnalyze: _runAiAnalyze,
                  ),
                const SizedBox(height: 16),
                SectionCard(
                  title: '手动录入',
                  child: Column(
                    children: [
                      TextField(
                        controller: _nameController,
                        decoration: const InputDecoration(
                          labelText: '物品名称',
                          hintText: '例如：牛奶、面包、面膜',
                        ),
                      ),
                      const SizedBox(height: 12),
                      InkWell(
                        onTap: _pickDate,
                        borderRadius: BorderRadius.circular(16),
                        child: InputDecorator(
                          decoration: const InputDecoration(
                            labelText: '到期日期',
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  formattedDate,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium
                                      ?.copyWith(
                                        color: _selectedDate == null
                                            ? AppColors.ink.withOpacity(0.5)
                                            : AppColors.ink,
                                      ),
                                ),
                              ),
                              const Icon(Icons.calendar_month_rounded),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      TextField(
                        controller: _notesController,
                        maxLines: 2,
                        decoration: const InputDecoration(
                          labelText: '备注（可选）',
                          hintText: '例如：冷藏保存、开封后7天',
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: _saveItem,
                    icon: const Icon(Icons.check_rounded),
                    label: const Text('保存物品'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _pickDate() async {
    final now = DateTime.now();
    final selected = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? now,
      firstDate: DateTime(now.year - 3),
      lastDate: DateTime(now.year + 10),
      helpText: '选择到期日期',
    );
    if (!mounted) {
      return;
    }
    if (selected == null) {
      return;
    }
    setState(() {
      _selectedDate = selected;
    });
  }

  Future<void> _runAiAnalyze() async {
    final settings = ref.read(appStateProvider).settings;
    if (!settings.isAiConfigured) {
      _showSnack('请先在设置中配置AI API');
      return;
    }

    setState(() {
      _aiLoading = true;
    });

    final result = await _aiService.analyze(
      _aiTextController.text,
      settings,
    );

    if (!mounted) {
      return;
    }

    setState(() {
      _aiLoading = false;
      if (result.expiryDate != null) {
        _selectedDate = result.expiryDate;
      }
      if (result.nameGuess != null && _nameController.text.trim().isEmpty) {
        _nameController.text = result.nameGuess!;
      }
    });

    if (result.message != null) {
      _showSnack(result.message!);
    }
  }

  Future<void> _saveItem() async {
    final name = _nameController.text.trim();
    if (name.isEmpty) {
      _showSnack('请输入物品名称');
      return;
    }
    if (_selectedDate == null) {
      _showSnack('请选择到期日期');
      return;
    }

    final item = ExpiryItem(
      id: DateTime.now().microsecondsSinceEpoch.toString(),
      name: name,
      expiryDate: _selectedDate!,
      notes: _notesController.text.trim(),
    );

    await ref.read(appStateProvider.notifier).addItem(item);

    if (!mounted) {
      return;
    }

    context.pop(true);
  }

  void _showSnack(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }
}
