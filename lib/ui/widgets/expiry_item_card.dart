import 'package:flutter/material.dart';
import 'package:almost_due_app/l10n/app_localizations.dart';
import 'package:intl/intl.dart';

import '../../app/theme.dart';
import '../../data/models/expiry_item.dart';
import '../../utils/date_utils.dart';

class ExpiryItemCard extends StatelessWidget {
  const ExpiryItemCard({
    super.key,
    required this.item,
    required this.reminderDays,
  });

  final ExpiryItem item;
  final int reminderDays;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final status = _itemStatus(item, reminderDays, l10n);
    final dateText = DateFormat.yMMMd(l10n.localeName).format(item.expiryDate);

    return TweenAnimationBuilder<double>(
      duration: const Duration(milliseconds: 450),
      tween: Tween(begin: 0, end: 1),
      builder: (context, value, child) {
        return Opacity(
          opacity: value,
          child: Transform.translate(
            offset: Offset(0, (1 - value) * 12),
            child: child,
          ),
        );
      },
      child: Container(
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
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                color: status.color.withValues(alpha: 0.18),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Icon(status.icon, color: status.color),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.name,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    l10n.expiryDateWithValue(dateText),
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: AppColors.ink.withValues(alpha: 0.65),
                        ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    status.detail,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: status.color,
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                  if (item.notes.isNotEmpty) ...[
                    const SizedBox(height: 4),
                    Text(
                      l10n.notesWithValue(item.notes),
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: AppColors.ink.withValues(alpha: 0.6),
                          ),
                    ),
                  ],
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: status.color.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Text(
                status.label,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: status.color,
                      fontWeight: FontWeight.w700,
                    ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  ItemStatus _itemStatus(
    ExpiryItem item,
    int reminderDays,
    AppLocalizations l10n,
  ) {
    final days = daysUntil(item.expiryDate);
    if (days < 0) {
      return ItemStatus(
        label: l10n.statusExpiredLabel,
        detail: l10n.statusExpiredDetail(days.abs()),
        color: AppColors.danger,
        icon: Icons.warning_amber_rounded,
      );
    }
    if (days == 0) {
      return ItemStatus(
        label: l10n.statusTodayLabel,
        detail: l10n.statusTodayDetail,
        color: AppColors.warning,
        icon: Icons.access_time_rounded,
      );
    }
    if (days <= reminderDays) {
      return ItemStatus(
        label: l10n.statusDueSoonLabel,
        detail: l10n.statusDueInDays(days),
        color: AppColors.warning,
        icon: Icons.notifications_active_rounded,
      );
    }
    return ItemStatus(
      label: l10n.statusSafeLabel,
      detail: l10n.statusDueInDays(days),
      color: AppColors.success,
      icon: Icons.check_circle_rounded,
    );
  }
}

class ItemStatus {
  const ItemStatus({
    required this.label,
    required this.detail,
    required this.color,
    required this.icon,
  });

  final String label;
  final String detail;
  final Color color;
  final IconData icon;
}
