import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:almost_due_app/l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';

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
  int _reminderHour = 9;
  int _reminderMinute = 0;
  int _reminderSecond = 0;
  String? _languageCode;

  @override
  void initState() {
    super.initState();
    final settings = ref.read(appStateProvider).settings;
    _apiBaseController.text = settings.apiBaseUrl;
    _apiKeyController.text = settings.apiKey;
    _reminderDays = settings.reminderDays.toDouble();
    _reminderHour = settings.reminderHour;
    _reminderMinute = settings.reminderMinute;
    _reminderSecond = settings.reminderSecond;
    _languageCode = settings.languageCode;
  }

  @override
  void dispose() {
    _apiBaseController.dispose();
    _apiKeyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final appState = ref.watch(appStateProvider);
    final isConfigured = appState.settings.isAiConfigured;

    return Scaffold(
      appBar: AppBar(title: Text(l10n.settingsTitle)),
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
                  title: l10n.settingsAiSectionTitle,
                  child: Column(
                    children: [
                      TextField(
                        controller: _apiBaseController,
                        decoration: InputDecoration(
                          labelText: l10n.settingsApiUrlLabel,
                          hintText: l10n.settingsApiUrlHint,
                        ),
                      ),
                      const SizedBox(height: 12),
                      TextField(
                        controller: _apiKeyController,
                        obscureText: true,
                        decoration: InputDecoration(
                          labelText: l10n.settingsApiKeyLabel,
                          hintText: l10n.settingsApiKeyHint,
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
                            isConfigured
                                ? l10n.settingsConfigured
                                : l10n.settingsNotConfigured,
                            style: Theme.of(context).textTheme.bodyMedium
                                ?.copyWith(
                                  color: AppColors.ink.withValues(alpha: 0.7),
                                ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                SectionCard(
                  title: l10n.settingsLanguageTitle,
                  child: Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children: [
                      _LanguageOption(
                        label: l10n.settingsLanguageSystem,
                        selected: _languageCode == null,
                        onTap: () => setState(() => _languageCode = null),
                      ),
                      _LanguageOption(
                        label: l10n.settingsLanguageEn,
                        selected: _languageCode == 'en',
                        onTap: () => setState(() => _languageCode = 'en'),
                      ),
                      _LanguageOption(
                        label: l10n.settingsLanguageZh,
                        selected: _languageCode == 'zh',
                        onTap: () => setState(() => _languageCode = 'zh'),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                SectionCard(
                  title: l10n.settingsReminderTitle,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        l10n.settingsReminderDays(_reminderDays.toInt()),
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      Slider(
                        value: _reminderDays,
                        min: 0,
                        max: 14,
                        divisions: 14,
                        activeColor: AppColors.primary,
                        onChanged: (value) {
                          setState(() => _reminderDays = value);
                        },
                      ),
                      const SizedBox(height: 12),
                      _buildReminderTimePicker(l10n),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: _saveSettings,
                    icon: const Icon(Icons.save_rounded),
                    label: Text(l10n.settingsSaveButton),
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
    final l10n = AppLocalizations.of(context)!;
    final appState = ref.read(appStateProvider);
    final newSettings = appState.settings.copyWith(
      apiBaseUrl: _apiBaseController.text.trim(),
      apiKey: _apiKeyController.text.trim(),
      reminderDays: _reminderDays.toInt(),
      reminderHour: _reminderHour,
      reminderMinute: _reminderMinute,
      reminderSecond: _reminderSecond,
      languageCode: _languageCode,
    );

    await ref.read(appStateProvider.notifier).updateSettings(newSettings);

    if (!mounted) {
      return;
    }

    SmartDialog.showToast(l10n.settingsSavedSnack);
  }

  Widget _buildReminderTimePicker(AppLocalizations l10n) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: _pickReminderTime,
        borderRadius: BorderRadius.circular(16),
        child: InputDecorator(
          isEmpty: false,
          decoration: InputDecoration(
            labelText: l10n.settingsReminderTimeTitle,
          ),
          child: Row(
            children: [
              Text(
                _formatTime(_reminderHour, _reminderMinute, _reminderSecond),
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
              ),
              const Spacer(),
              Icon(
                Icons.schedule_rounded,
                color: AppColors.ink.withValues(alpha: 0.6),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _pickReminderTime() async {
    final l10n = AppLocalizations.of(context)!;
    final materialL10n = MaterialLocalizations.of(context);
    final initial = Duration(
      hours: _reminderHour,
      minutes: _reminderMinute,
      seconds: _reminderSecond,
    );
    Duration selected = initial;

    final result = await showModalBottomSheet<Duration>(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
          decoration: const BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
          ),
          child: SafeArea(
            top: false,
            child: StatefulBuilder(
              builder: (context, setSheetState) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 16, 20, 8),
                      child: Row(
                        children: [
                          Text(
                            l10n.settingsReminderTimeTitle,
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          const Spacer(),
                          Text(
                            _formatDuration(selected),
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(fontWeight: FontWeight.w700),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 200,
                      child: CupertinoTimerPicker(
                        mode: CupertinoTimerPickerMode.hms,
                        initialTimerDuration: selected,
                        onTimerDurationChanged: (value) {
                          final normalized = _normalizeDuration(value);
                          setSheetState(() => selected = normalized);
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 8, 20, 16),
                      child: Row(
                        children: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: Text(materialL10n.cancelButtonLabel),
                          ),
                          const Spacer(),
                          ElevatedButton(
                            onPressed: () => Navigator.pop(context, selected),
                            child: Text(materialL10n.okButtonLabel),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        );
      },
    );

    if (!mounted || result == null) {
      return;
    }

    final normalized = _normalizeDuration(result);
    setState(() {
      _reminderHour = _hoursPart(normalized);
      _reminderMinute = _minutesPart(normalized);
      _reminderSecond = _secondsPart(normalized);
    });
  }

  Duration _normalizeDuration(Duration value) {
    return Duration(
      hours: _hoursPart(value),
      minutes: _minutesPart(value),
      seconds: _secondsPart(value),
    );
  }

  int _hoursPart(Duration value) => value.inHours.remainder(24);

  int _minutesPart(Duration value) => value.inMinutes.remainder(60);

  int _secondsPart(Duration value) => value.inSeconds.remainder(60);

  String _formatDuration(Duration value) {
    return _formatTime(
      _hoursPart(value),
      _minutesPart(value),
      _secondsPart(value),
    );
  }

  String _formatTime(int hour, int minute, int second) {
    return '${_twoDigits(hour)}:${_twoDigits(minute)}:${_twoDigits(second)}';
  }

  String _twoDigits(int value) => value.toString().padLeft(2, '0');
}

class _LanguageOption extends StatelessWidget {
  const _LanguageOption({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final borderColor = selected
        ? AppColors.primary.withValues(alpha: 0.65)
        : AppColors.ink.withValues(alpha: 0.08);
    final backgroundColor = selected
        ? AppColors.primary.withValues(alpha: 0.25)
        : AppColors.surface;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(18),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: borderColor),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 180),
                height: 8,
                width: 8,
                decoration: BoxDecoration(
                  color: selected
                      ? AppColors.primary
                      : AppColors.ink.withValues(alpha: 0.2),
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 8),
              Text(
                label,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
