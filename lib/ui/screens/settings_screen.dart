import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../app/theme.dart';
import '../../state/providers.dart';
import '../widgets/cute_background.dart';
import '../widgets/section_card.dart';

class SettingsScreen extends ConsumerStatefulWidget {
  const SettingsScreen({super.key});

  @override
  ConsumerState<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends ConsumerState<SettingsScreen> {
  final _apiBaseController = TextEditingController();
  final _apiKeyController = TextEditingController();
  double _reminderDays = 3;

  @override
  void initState() {
    super.initState();
    final settings = ref.read(appStateProvider).settings;
    _apiBaseController.text = settings.apiBaseUrl;
    _apiKeyController.text = settings.apiKey;
    _reminderDays = settings.reminderDays.toDouble();
  }

  @override
  void dispose() {
    _apiBaseController.dispose();
    _apiKeyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final appState = ref.watch(appStateProvider);
    final isConfigured = appState.settings.isAiConfigured;

    return Scaffold(
      appBar: AppBar(title: const Text('设置')),
      body: Stack(
        fit: StackFit.expand,
        children: [
          const CuteBackground(),
          SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SectionCard(
                  title: 'AI API 配置',
                  child: Column(
                    children: [
                      TextField(
                        controller: _apiBaseController,
                        decoration: const InputDecoration(
                          labelText: 'API 地址',
                          hintText: '例如：https://api.example.com',
                        ),
                      ),
                      const SizedBox(height: 12),
                      TextField(
                        controller: _apiKeyController,
                        obscureText: true,
                        decoration: const InputDecoration(
                          labelText: 'API Key',
                          hintText: '请输入你的密钥',
                        ),
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          Container(
                            height: 10,
                            width: 10,
                            decoration: BoxDecoration(
                              color: isConfigured
                                  ? AppColors.success
                                  : AppColors.warning,
                              shape: BoxShape.circle,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            isConfigured ? '已配置，可使用AI识别' : '未配置，AI识别不可用',
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                  color: AppColors.ink.withOpacity(0.7),
                                ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                SectionCard(
                  title: '提醒设置',
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '提前 ${_reminderDays.toInt()} 天提醒',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      Slider(
                        value: _reminderDays,
                        min: 1,
                        max: 14,
                        divisions: 13,
                        activeColor: AppColors.primary,
                        onChanged: (value) {
                          setState(() => _reminderDays = value);
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: _saveSettings,
                    icon: const Icon(Icons.save_rounded),
                    label: const Text('保存设置'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _saveSettings() async {
    final appState = ref.read(appStateProvider);
    final newSettings = appState.settings.copyWith(
      apiBaseUrl: _apiBaseController.text.trim(),
      apiKey: _apiKeyController.text.trim(),
      reminderDays: _reminderDays.toInt(),
    );

    await ref.read(appStateProvider.notifier).updateSettings(newSettings);

    if (!mounted) {
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('设置已保存')),
    );
  }
}
