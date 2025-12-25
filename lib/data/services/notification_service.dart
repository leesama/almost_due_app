import 'package:flutter/widgets.dart';
import 'package:almost_due_app/l10n/app_localizations.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

import '../models/app_settings.dart';
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
      await androidPlugin.requestExactAlarmsPermission();
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
  /// [settings] 提前多少天提醒以及提醒时间
  Future<void> scheduleExpiryNotification(
    ExpiryItem item,
    AppSettings settings,
  ) async {
    final l10n = await _resolveLocalizations();
    // 计算通知时间：到期日前 N 天的指定时间
    final notifyDate = item.expiryDate.subtract(
      Duration(days: settings.reminderDays),
    );
    final scheduledTime = tz.TZDateTime(
      tz.local,
      notifyDate.year,
      notifyDate.month,
      notifyDate.day,
      settings.reminderHour,
      settings.reminderMinute,
      settings.reminderSecond,
    );

    final now = tz.TZDateTime.now(tz.local);
    debugPrint('[NotificationService] 物品: ${item.name}');
    debugPrint('[NotificationService] 到期日: ${item.expiryDate}');
    debugPrint('[NotificationService] 提前天数: ${settings.reminderDays}');
    debugPrint('[NotificationService] 计划通知时间: $scheduledTime');
    debugPrint('[NotificationService] 当前时间: $now');

    // 如果通知时间已过，不调度
    if (scheduledTime.isBefore(now)) {
      debugPrint('[NotificationService] ❌ 通知时间已过，跳过调度');
      return;
    }

    debugPrint('[NotificationService] ✅ 将调度通知');

    final notificationId = _generateNotificationId(item.id);

    final androidDetails = AndroidNotificationDetails(
      'expiry_reminder',
      l10n.notificationChannelName,
      channelDescription: l10n.notificationChannelDescription,
      importance: Importance.high,
      priority: Priority.high,
    );

    const darwinDetails = DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );

    final details = NotificationDetails(
      android: androidDetails,
      iOS: darwinDetails,
    );

    await _plugin.zonedSchedule(
      notificationId,
      l10n.notificationTitle,
      l10n.notificationBody(item.name, settings.reminderDays),
      scheduledTime,
      details,
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
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
  Future<void> rescheduleAll(
    List<ExpiryItem> items,
    AppSettings settings,
  ) async {
    debugPrint('[NotificationService] ===== 开始重新调度所有通知 =====');
    debugPrint('[NotificationService] 物品数量: ${items.length}');
    debugPrint(
      '[NotificationService] 设置 - 提前天数: ${settings.reminderDays}, 时间: ${settings.reminderHour}:${settings.reminderMinute}:${settings.reminderSecond}',
    );

    // 先取消所有现有通知
    await cancelAll();
    debugPrint('[NotificationService] 已取消所有现有通知');

    // 为每个物品重新调度
    for (final item in items) {
      await scheduleExpiryNotification(item, settings);
    }
    debugPrint('[NotificationService] ===== 重新调度完成 =====');
  }

  /// 发送测试通知（用于验证通知功能是否正常）
  Future<void> showTestNotification() async {
    final l10n = await _resolveLocalizations();
    final androidDetails = AndroidNotificationDetails(
      'expiry_reminder',
      l10n.notificationChannelName,
      channelDescription: l10n.notificationChannelDescription,
      importance: Importance.high,
      priority: Priority.high,
    );

    const darwinDetails = DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );

    final details = NotificationDetails(
      android: androidDetails,
      iOS: darwinDetails,
    );

    await _plugin.show(
      0, // 测试通知使用固定 ID
      l10n.notificationTestTitle,
      l10n.notificationTestBody,
      details,
    );
  }

  /// 根据物品 ID 生成通知 ID（整数）
  int _generateNotificationId(String itemId) {
    return itemId.hashCode.abs() % 2147483647;
  }

  Future<AppLocalizations> _resolveLocalizations() async {
    final locale = WidgetsBinding.instance.platformDispatcher.locale;
    final resolvedLocale = AppLocalizations.supportedLocales.firstWhere(
      (supportedLocale) => supportedLocale.languageCode == locale.languageCode,
      orElse: () => AppLocalizations.supportedLocales.first,
    );
    return AppLocalizations.delegate.load(resolvedLocale);
  }
}
