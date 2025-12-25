import 'package:flutter/material.dart';
import 'package:almost_due_app/l10n/app_localizations.dart';

import '../../app/theme.dart';
import 'section_card.dart';

class AiPanel extends StatelessWidget {
  const AiPanel({
    super.key,
    required this.controller,
    required this.isConfigured,
    required this.isLoading,
    required this.onAnalyze,
  });

  final TextEditingController controller;
  final bool isConfigured;
  final bool isLoading;
  final VoidCallback onAnalyze;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return SectionCard(
      title: l10n.aiPanelTitle,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            isConfigured
                ? l10n.aiConfiguredMessage
                : l10n.aiNotConfiguredMessage,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppColors.ink.withValues(alpha: 0.7),
                ),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: controller,
            maxLines: 4,
            decoration: InputDecoration(
              labelText: l10n.aiTextFieldLabel,
              hintText: l10n.aiTextFieldHint,
            ),
          ),
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: isLoading || !isConfigured ? null : onAnalyze,
              icon: const Icon(Icons.auto_awesome_rounded),
              label: AnimatedSwitcher(
                duration: const Duration(milliseconds: 250),
                child: isLoading
                    ? const SizedBox(
                        key: ValueKey('loading'),
                        height: 18,
                        width: 18,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : Text(
                        l10n.aiStartButton,
                        key: const ValueKey('ready'),
                      ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
