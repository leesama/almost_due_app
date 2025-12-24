import 'package:flutter/material.dart';

import '../../app/theme.dart';
import '../../data/models/expiry_item.dart';
import 'expiry_item_card.dart';

class ItemsList extends StatelessWidget {
  const ItemsList({
    super.key,
    required this.items,
    required this.reminderDays,
    required this.onRemove,
  });

  final List<ExpiryItem> items;
  final int reminderDays;
  final ValueChanged<ExpiryItem> onRemove;

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) {
      return const EmptyState();
    }

    return ListView.separated(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 120),
      itemCount: items.length,
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        final item = items[index];
        return Dismissible(
          key: ValueKey(item.id),
          direction: DismissDirection.endToStart,
          background: Container(
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.only(right: 24),
            decoration: BoxDecoration(
              color: AppColors.danger.withOpacity(0.15),
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Icon(Icons.delete_rounded, color: AppColors.danger),
          ),
          onDismissed: (_) {
            onRemove(item);
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('已删除物品记录')),
            );
          },
          child: ExpiryItemCard(
            item: item,
            reminderDays: reminderDays,
          ),
        );
      },
    );
  }
}

class EmptyState extends StatelessWidget {
  const EmptyState({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 12,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: 56,
              width: 56,
              decoration: BoxDecoration(
                color: AppColors.sunshine.withOpacity(0.35),
                borderRadius: BorderRadius.circular(18),
              ),
              child: const Icon(Icons.inbox_rounded, size: 30),
            ),
            const SizedBox(height: 12),
            Text(
              '还没有物品哦',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 6),
            Text(
              '点击上方按钮开始记录到期日吧',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppColors.ink.withOpacity(0.7),
                  ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
