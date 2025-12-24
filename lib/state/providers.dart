import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../data/models/app_settings.dart';
import '../data/models/expiry_item.dart';
import '../data/services/storage_service.dart';
import 'app_state.dart';

part 'providers.g.dart';

@riverpod
StorageService storageService(Ref ref) {
  return StorageService();
}

@Riverpod(keepAlive: true)
class AppState extends _$AppState {
  @override
  AppStateData build() {
    _load();
    return AppStateData.initial();
  }

  Future<void> _load() async {
    final storage = ref.read(storageServiceProvider);
    final items = await storage.loadItems();
    final settings = await storage.loadSettings();
    state = state.copyWith(items: items, settings: settings);
  }

  Future<void> addItem(ExpiryItem item) async {
    final storage = ref.read(storageServiceProvider);
    final updated = [...state.items, item];
    state = state.copyWith(items: updated);
    await storage.saveItems(updated);
  }

  Future<void> removeItem(String id) async {
    final storage = ref.read(storageServiceProvider);
    final updated = state.items.where((item) => item.id != id).toList();
    state = state.copyWith(items: updated);
    await storage.saveItems(updated);
  }

  Future<void> updateSettings(AppSettings settings) async {
    final storage = ref.read(storageServiceProvider);
    state = state.copyWith(settings: settings);
    await storage.saveSettings(settings);
  }
}
