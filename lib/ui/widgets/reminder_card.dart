import 'package:flutter/material.dart';
import 'package:almost_due_app/l10n/app_localizations.dart';

import '../../app/theme.dart';
import '../../data/models/expiry_item.dart';
import '../../utils/date_utils.dart';

class ReminderCounts {
  const ReminderCounts({
    required this.expired,
    required this.dueSoon,
    required this.total,
  });

  final int expired;
  final int dueSoon;
  final int total;

  static ReminderCounts fromItems(List<ExpiryItem> items, int reminderDays) {
    final today = dateOnly(DateTime.now());
    int expired = 0;
    int dueSoon = 0;

    for (final item in items) {
      final days = dateOnly(item.expiryDate).difference(today).inDays;
      if (days < 0) {
        expired++;
      } else if (days <= reminderDays) {
        dueSoon++;
      }
    }

    return ReminderCounts(expired: expired, dueSoon: dueSoon, total: items.length);
  }
}

class ReminderCard extends StatelessWidget {
  const ReminderCard({
    super.key,
    required this.counts,
    required this.onExpiredTap,
    required this.onDueSoonTap,
  });

  final ReminderCounts counts;
  final VoidCallback onExpiredTap;
  final VoidCallback onDueSoonTap;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(22),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        children: [
          _ReminderActionTile(
            title: l10n.reminderExpiredTitle,
            subtitle: l10n.reminderExpiredCount(counts.expired),
            accentColor: AppColors.danger,
            icon: Icons.error_outline_rounded,
            onTap: onExpiredTap,
          ),
          const SizedBox(height: 10),
          _ReminderActionTile(
            title: l10n.reminderDueSoonTitle,
            subtitle: l10n.reminderDueSoonCount(counts.dueSoon),
            accentColor: AppColors.warning,
            icon: Icons.schedule_rounded,
            onTap: onDueSoonTap,
          ),
        ],
      ),
    );
  }
}

class _ReminderActionTile extends StatelessWidget {
  const _ReminderActionTile({
    required this.title,
    required this.subtitle,
    required this.accentColor,
    required this.icon,
    required this.onTap,
  });

  final String title;
  final String subtitle;
  final Color accentColor;
  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(18),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
          decoration: BoxDecoration(
            color: accentColor.withValues(alpha: 0.16),
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: accentColor.withValues(alpha: 0.4)),
          ),
          child: Row(
            children: [
              Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                  color: accentColor.withValues(alpha: 0.18),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Icon(icon, color: accentColor),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.w700,
                          ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: AppColors.ink.withValues(alpha: 0.7),
                          ),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.chevron_right_rounded,
                color: AppColors.ink.withValues(alpha: 0.5),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
