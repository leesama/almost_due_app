import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../ui/screens/add_item_screen.dart';
import '../ui/screens/add_item_types.dart';
import '../ui/screens/home_screen.dart';
import '../ui/screens/settings_screen.dart';

class AppRoutes {
  static const home = '/';
  static const addItem = '/add';
  static const settings = '/settings';
}

final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: AppRoutes.home,
    routes: [
      GoRoute(
        path: AppRoutes.home,
        builder: (context, state) => const HomeScreen(),
      ),
      GoRoute(
        path: AppRoutes.addItem,
        pageBuilder: (context, state) {
          final args = state.extra as AddItemArgs?;
          return MaterialPage<void>(
            child: AddItemScreen(
              initialMode: args?.mode ?? AddMode.manual,
            ),
          );
        },
      ),
      GoRoute(
        path: AppRoutes.settings,
        builder: (context, state) => const SettingsScreen(),
      ),
    ],
  );
});
