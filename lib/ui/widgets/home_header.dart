import 'package:flutter/material.dart';

import '../../app/theme.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({
    super.key,
    required this.totalItems,
    required this.onSettings,
  });

  final int totalItems;
  final VoidCallback onSettings;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '快到期啦',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontSize: 26,
                    ),
              ),
              const SizedBox(height: 6),
              Text(
                '可爱提醒你的物品到期',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppColors.ink.withOpacity(0.6),
                    ),
              ),
              const SizedBox(height: 6),
              Text(
                '当前已登记 $totalItems 件',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppColors.ink.withOpacity(0.7),
                    ),
              ),
            ],
          ),
        ),
        IconButton(
          onPressed: onSettings,
          icon: const Icon(Icons.settings_rounded),
          style: IconButton.styleFrom(
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
          ),
        ),
      ],
    );
  }
}
