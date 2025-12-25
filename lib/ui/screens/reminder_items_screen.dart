import 'package:flutter/material.dart';
import 'package:almost_due_app/l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../app/theme.dart';
import '../../data/models/expiry_item.dart';
import '../../state/providers.dart';
import '../../utils/date_utils.dart';
import '../widgets/cute_background.dart';
import '../widgets/items_list.dart';
import 'reminder_items_types.dart';

class ReminderItemsScreen extends ConsumerWidget {
  const ReminderItemsScreen({super.key, required this.filter});

  final ReminderFilter filter;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final appState = ref.watch(appStateProvider);
    final reminderDays = appState.settings.reminderDays;
    final items = _filteredItems(
      appState.sortedItems,
      reminderDays,
      filter,
    );

    final title = filter == ReminderFilter.expired
        ? l10n.reminderExpiredTitle
        : l10n.reminderDueSoonTitle;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(title: Text(title)),
      body: Stack(
        fit: StackFit.expand,
        children: [
          const CuteBackground(),
          ItemsList(
            items: items,
            reminderDays: reminderDays,
            onRemove: (item) =>
                ref.read(appStateProvider.notifier).removeItem(item.id),
          ),
        ],
      ),
    );
  }
}

List<ExpiryItem> _filteredItems(
  List<ExpiryItem> items,
  int reminderDays,
  ReminderFilter filter,
) {
  final today = dateOnly(DateTime.now());
  return items.where((item) {
    final days = dateOnly(item.expiryDate).difference(today).inDays;
    if (filter == ReminderFilter.expired) {
      return days < 0;
    }
    return days >= 0 && days <= reminderDays;
  }).toList();
}
