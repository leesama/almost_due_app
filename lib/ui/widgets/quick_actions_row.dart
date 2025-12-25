import 'package:flutter/material.dart';
import 'package:almost_due_app/l10n/app_localizations.dart';

import '../../app/theme.dart';

class QuickActionsRow extends StatelessWidget {
  const QuickActionsRow({super.key, required this.onManual, required this.onAi});

  final VoidCallback onManual;
  final VoidCallback onAi;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Row(
      children: [
        Expanded(
          child: QuickActionCard(
            title: l10n.manualEntry,
            subtitle: l10n.quickManualSubtitle,
            icon: Icons.edit_note_rounded,
            color: AppColors.mint,
            onTap: onManual,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: QuickActionCard(
            title: l10n.aiScan,
            subtitle: l10n.quickAiSubtitle,
            icon: Icons.auto_awesome_rounded,
            color: AppColors.primary,
            onTap: onAi,
          ),
        ),
      ],
    );
  }
}

class QuickActionCard extends StatelessWidget {
  const QuickActionCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.color,
    required this.onTap,
  });

  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 12,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 44,
              width: 44,
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.25),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Icon(icon, color: color),
            ),
            const SizedBox(height: 12),
            Text(
              title,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 4),
            Text(
              subtitle,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppColors.ink.withValues(alpha: 0.6),
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
