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
  const ReminderCard({super.key, required this.counts});

  final ReminderCounts counts;

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
      child: Row(
        children: [
          Container(
            height: 52,
            width: 52,
            decoration: BoxDecoration(
              color: AppColors.secondary.withValues(alpha: 0.35),
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Icon(Icons.notifications_active_rounded),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  l10n.reminderTitle,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 4),
                Text(
                  l10n.reminderSummary(
                    counts.expired,
                    counts.dueSoon,
                  ),
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppColors.ink.withValues(alpha: 0.7),
                      ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: AppColors.sunshine.withValues(alpha: 0.35),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Text(
              l10n.reminderTotal(counts.total),
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
            ),
          ),
        ],
      ),
    );
  }
}
