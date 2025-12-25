import 'package:almost_due_app/state/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:almost_due_app/l10n/app_localizations.dart';

import '../../app/theme.dart';

class HomeHeader extends ConsumerWidget {
  const HomeHeader({
    super.key,
    required this.totalItems,
    required this.onSettings,
  });

  final int totalItems;
  final VoidCallback onSettings;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                l10n.appTitle,
                style: Theme.of(
                  context,
                ).textTheme.titleLarge?.copyWith(fontSize: 26),
              ),

              const SizedBox(height: 6),
              Text(
                l10n.totalItems(totalItems),
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppColors.ink.withValues(alpha: 0.7),
                ),
              ),
            ],
          ),
        ),
        IconButton(
          onPressed: () async {
            await ref.read(notificationServiceProvider).showTestNotification();
          },
          icon: const Icon(Icons.notifications_active_rounded),
          style: IconButton.styleFrom(
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
          ),
        ),
        const SizedBox(width: 8),
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
