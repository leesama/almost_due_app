import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../app/router.dart';
import '../../app/theme.dart';
import '../../state/providers.dart';
import '../widgets/cute_background.dart';
import '../widgets/home_header.dart';
import '../widgets/items_list.dart';
import '../widgets/quick_actions_row.dart';
import '../widgets/reminder_card.dart';
import 'add_item_types.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appState = ref.watch(appStateProvider);
    final items = appState.sortedItems;
    final settings = appState.settings;
    final counts = ReminderCounts.fromItems(items, settings.reminderDays);

    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        fit: StackFit.expand,
        children: [
          const CuteBackground(),
          SafeArea(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
                  child: HomeHeader(
                    totalItems: items.length,
                    onSettings: () => context.push(AppRoutes.settings),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
                  child: ReminderCard(counts: counts),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
                  child: QuickActionsRow(
                    onManual: () => _openAddItem(context, AddMode.manual),
                    onAi: () => _openAddItem(context, AddMode.ai),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 18, 20, 8),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      '物品列表',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ),
                ),
                Expanded(
                  child: ItemsList(
                    items: items,
                    reminderDays: settings.reminderDays,
                    onRemove: (item) => ref
                        .read(appStateProvider.notifier)
                        .removeItem(item.id),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.ink,
        icon: const Icon(Icons.add_rounded),
        label: const Text('添加物品'),
        onPressed: () => _openAddItem(context, AddMode.manual),
      ),
    );
  }

  Future<void> _openAddItem(BuildContext context, AddMode mode) async {
    final saved = await context.push<bool>(
      AppRoutes.addItem,
      extra: AddItemArgs(mode: mode),
    );
    if (!context.mounted) {
      return;
    }
    if (saved == true) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('已保存物品')),
      );
    }
  }
}
