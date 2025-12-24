import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

import '../models/expiry_item.dart';

class NotificationService {
  static final NotificationService _instance = NotificationService._internal();
  factory NotificationService() => _instance;
  NotificationService._internal();

  final FlutterLocalNotificationsPlugin _plugin =
      FlutterLocalNotificationsPlugin();

  bool _initialized = false;

  /// 初始化通知服务
  Future<void> init() async {
    if (_initialized) return;

    // 初始化时区数据
    tz.initializeTimeZones();
    tz.setLocalLocation(tz.getLocation('Asia/Shanghai'));

    // Android 配置
    const androidSettings = AndroidInitializationSettings(
      '@mipmap/ic_launcher',
    );

    // iOS 配置
    const darwinSettings = DarwinInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
    );

    const initSettings = InitializationSettings(
      android: androidSettings,
      iOS: darwinSettings,
    );

    await _plugin.initialize(initSettings);
    _initialized = true;
  }

  /// 请求通知权限
  Future<bool> requestPermissions() async {
    // Android 13+ 需要请求运行时权限
    final androidPlugin = _plugin
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >();
    if (androidPlugin != null) {
      final granted = await androidPlugin.requestNotificationsPermission();
      return granted ?? false;
    }

    // iOS 请求权限
    final iosPlugin = _plugin
        .resolvePlatformSpecificImplementation<
          IOSFlutterLocalNotificationsPlugin
        >();
    if (iosPlugin != null) {
      final granted = await iosPlugin.requestPermissions(
        alert: true,
        badge: true,
        sound: true,
      );
      return granted ?? false;
    }

    return true;
  }

  /// 为单个物品调度到期提醒通知
  /// [item] 要提醒的物品
  /// [reminderDays] 提前多少天提醒
  Future<void> scheduleExpiryNotification(
    ExpiryItem item,
    int reminderDays,
  ) async {
    // 计算通知时间：到期日前 N 天的早上 9:00
    final notifyDate = item.expiryDate.subtract(Duration(days: reminderDays));
    final scheduledTime = tz.TZDateTime(
      tz.local,
      notifyDate.year,
      notifyDate.month,
      notifyDate.day,
      9, // 早上 9 点
      0,
    );

    // 如果通知时间已过，不调度
    if (scheduledTime.isBefore(tz.TZDateTime.now(tz.local))) {
      return;
    }

    final notificationId = _generateNotificationId(item.id);

    const androidDetails = AndroidNotificationDetails(
      'expiry_reminder',
      '到期提醒',
      channelDescription: '物品即将到期的提醒通知',
      importance: Importance.high,
      priority: Priority.high,
    );

    const darwinDetails = DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );

    const details = NotificationDetails(
      android: androidDetails,
      iOS: darwinDetails,
    );

    await _plugin.zonedSchedule(
      notificationId,
      '物品即将到期',
      '「${item.name}」将在 $reminderDays 天后到期，请及时处理！',
      scheduledTime,
      details,
      androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
    );
  }

  /// 取消指定物品的通知
  Future<void> cancelNotification(String itemId) async {
    final notificationId = _generateNotificationId(itemId);
    await _plugin.cancel(notificationId);
  }

  /// 取消所有通知
  Future<void> cancelAll() async {
    await _plugin.cancelAll();
  }

  /// 重新调度所有物品的通知
  Future<void> rescheduleAll(List<ExpiryItem> items, int reminderDays) async {
    // 先取消所有现有通知
    await cancelAll();

    // 为每个物品重新调度
    for (final item in items) {
      await scheduleExpiryNotification(item, reminderDays);
    }
  }

  /// 根据物品 ID 生成通知 ID（整数）
  int _generateNotificationId(String itemId) {
    return itemId.hashCode.abs() % 2147483647;
  }
}
