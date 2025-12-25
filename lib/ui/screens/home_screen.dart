import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:almost_due_app/l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';

import '../../app/theme.dart';
import '../../app/router.dart';
import '../../data/models/expiry_item.dart';
import '../../state/providers.dart';
import '../../utils/date_utils.dart';
import '../widgets/cute_background.dart';
import '../widgets/home_header.dart';
import '../widgets/items_list.dart';
import '../widgets/quick_actions_row.dart';
import 'add_item_types.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  int _tabIndex = 2;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final appState = ref.watch(appStateProvider);
    final items = appState.sortedItems;
    final settings = appState.settings;
    final filteredItems = _filteredItems(items, settings.reminderDays, _tabIndex);
    final listTitle = _tabTitle(l10n, _tabIndex);

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
                      listTitle,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ),
                ),
                Expanded(
                  child: ItemsList(
                    items: filteredItems,
                    reminderDays: settings.reminderDays,
                    onRemove: (item) =>
                        ref.read(appStateProvider.notifier).removeItem(item.id),
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
        label: Text(l10n.addItemFab),
        onPressed: () => _openAddItem(context, AddMode.manual),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _tabIndex,
        onTap: (index) => setState(() => _tabIndex = index),
        items: [
          BottomNavigationBarItem(
            icon: const Icon(Icons.event_busy_rounded),
            label: l10n.homeTabExpired,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.event_available_rounded),
            label: l10n.homeTabDueSoon,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.list_alt_rounded),
            label: l10n.homeTabAll,
          ),
        ],
      ),
    );
  }

  Future<void> _openAddItem(BuildContext context, AddMode mode) async {
    await context.push(
      AppRoutes.addItem,
      extra: AddItemArgs(mode: mode),
    );
  }

  List<ExpiryItem> _filteredItems(
    List<ExpiryItem> items,
    int reminderDays,
    int tabIndex,
  ) {
    if (tabIndex == 2) {
      return items;
    }
    final today = dateOnly(DateTime.now());
    return items.where((item) {
      final days = dateOnly(item.expiryDate).difference(today).inDays;
      if (tabIndex == 0) {
        return days < 0;
      }
      return days >= 0 && days <= reminderDays;
    }).toList();
  }

  String _tabTitle(AppLocalizations l10n, int tabIndex) {
    switch (tabIndex) {
      case 0:
        return l10n.homeTabExpired;
      case 1:
        return l10n.homeTabDueSoon;
      case 2:
      default:
        return l10n.homeTabAll;
    }
  }
}
