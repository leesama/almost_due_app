import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../data/models/app_settings.dart';
import '../data/models/expiry_item.dart';
import '../data/services/notification_service.dart';
import '../data/services/storage_service.dart';
import 'app_state.dart';

part 'providers.g.dart';

@riverpod
StorageService storageService(Ref ref) {
  return StorageService();
}

@riverpod
NotificationService notificationService(Ref ref) {
  return NotificationService();
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

    // 加载完成后，重新调度所有通知
    final notification = ref.read(notificationServiceProvider);
    await notification.rescheduleAll(items, settings);
  }

  Future<void> addItem(ExpiryItem item) async {
    final storage = ref.read(storageServiceProvider);
    final notification = ref.read(notificationServiceProvider);

    final updated = [...state.items, item];
    state = state.copyWith(items: updated);
    await storage.saveItems(updated);

    // 为新物品调度通知
    await notification.scheduleExpiryNotification(item, state.settings);
  }

  Future<void> removeItem(String id) async {
    final storage = ref.read(storageServiceProvider);
    final notification = ref.read(notificationServiceProvider);

    final updated = state.items.where((item) => item.id != id).toList();
    state = state.copyWith(items: updated);
    await storage.saveItems(updated);

    // 取消该物品的通知
    await notification.cancelNotification(id);
  }

  Future<void> updateSettings(AppSettings settings) async {
    final storage = ref.read(storageServiceProvider);

    state = state.copyWith(settings: settings);
    await storage.saveSettings(settings);

    // 保存设置后，确保所有已有物品的提醒时间同步更新
    final notification = ref.read(notificationServiceProvider);
    await notification.rescheduleAll(state.items, settings);
  }
}
