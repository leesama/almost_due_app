import 'package:flutter/material.dart';
import 'package:almost_due_app/l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';

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
    final l10n = AppLocalizations.of(context)!;
    final appState = ref.watch(appStateProvider);
    final settings = appState.settings;
    final formattedDate = _selectedDate == null
        ? l10n.selectExpiryDate
        : DateFormat.yMMMd(l10n.localeName).format(_selectedDate!);

    return Scaffold(
      appBar: AppBar(title: Text(l10n.addItemTitle)),
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
                  title: l10n.addItemManualSectionTitle,
                  child: Column(
                    children: [
                      TextField(
                        controller: _nameController,
                        decoration: InputDecoration(
                          labelText: l10n.addItemNameLabel,
                          hintText: l10n.addItemNameHint,
                        ),
                      ),
                      const SizedBox(height: 12),
                      InkWell(
                        onTap: _pickDate,
                        borderRadius: BorderRadius.circular(16),
                        child: InputDecorator(
                          decoration: InputDecoration(
                            labelText: l10n.addItemExpiryLabel,
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
                                            ? AppColors.ink.withValues(alpha: 0.5)
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
                        decoration: InputDecoration(
                          labelText: l10n.addItemNotesLabel,
                          hintText: l10n.addItemNotesHint,
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
                    label: Text(l10n.addItemSaveButton),
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
    final l10n = AppLocalizations.of(context)!;
    final now = DateTime.now();
    final selected = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? now,
      firstDate: DateTime(now.year - 3),
      lastDate: DateTime(now.year + 10),
      helpText: l10n.selectExpiryDate,
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
    final l10n = AppLocalizations.of(context)!;
    final settings = ref.read(appStateProvider).settings;
    if (!settings.isAiConfigured) {
      _showToast(l10n.aiNotConfiguredMessage);
      return;
    }

    setState(() {
      _aiLoading = true;
    });

    final result = await _aiService.analyze(
      _aiTextController.text,
      settings,
      messages: AiMessages(
        notConfigured: l10n.aiNotConfiguredMessage,
        emptyInput: l10n.aiResultEmptyInput,
        noDateFound: l10n.aiResultNoDateFound,
        dateDetected: l10n.aiResultDateDetected,
      ),
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
      _showToast(result.message!);
    }
  }

  Future<void> _saveItem() async {
    final l10n = AppLocalizations.of(context)!;
    final name = _nameController.text.trim();
    if (name.isEmpty) {
      _showToast(l10n.addItemNameRequired);
      return;
    }
    if (_selectedDate == null) {
      _showToast(l10n.addItemDateRequired);
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

    _showToast(l10n.itemSavedSnack);
    setState(() {
      _nameController.clear();
      _notesController.clear();
      _aiTextController.clear();
      _selectedDate = null;
    });
  }

  void _showToast(String message) {
    SmartDialog.showToast(message);
  }
}
