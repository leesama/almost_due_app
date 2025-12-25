// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Chinese (`zh`).
class AppLocalizationsZh extends AppLocalizations {
  AppLocalizationsZh([String locale = 'zh']) : super(locale);

  @override
  String get appTitle => '快到期啦';

  @override
  String totalItems(Object count) {
    return '当前已登记 $count 件';
  }

  @override
  String get itemsListTitle => '物品列表';

  @override
  String get homeTabExpired => '已到期商品';

  @override
  String get homeTabDueSoon => '快到期商品';

  @override
  String get homeTabAll => '所有商品';

  @override
  String get addItemFab => '添加物品';

  @override
  String get itemSavedSnack => '已保存物品';

  @override
  String get notificationChannelName => '到期提醒';

  @override
  String get notificationChannelDescription => '物品即将到期的提醒通知';

  @override
  String get notificationTitle => '物品即将到期';

  @override
  String notificationBody(Object days, Object itemName) {
    return '「$itemName」将在 $days 天后到期，请及时处理！';
  }

  @override
  String get notificationTestTitle => '通知测试';

  @override
  String get notificationTestBody => '🎉 恭喜！通知功能正常工作！';

  @override
  String get statusSafeLabel => '安全';

  @override
  String statusDueInDays(int days) {
    return '$days 天后到期';
  }

  @override
  String get statusExpiredLabel => '已过期';

  @override
  String statusExpiredDetail(int days) {
    return '已过期 $days 天';
  }

  @override
  String get statusTodayLabel => '今天';

  @override
  String get statusTodayDetail => '今天到期！';

  @override
  String get statusDueSoonLabel => '即将到期';

  @override
  String expiryDateWithValue(String date) {
    return '到期日：$date';
  }

  @override
  String notesWithValue(String notes) {
    return '备注：$notes';
  }

  @override
  String get deleteItemSnack => '已删除物品';

  @override
  String get emptyTitle => '暂无物品';

  @override
  String get emptySubtitle => '快添加一些物品来追踪保质期吧！';

  @override
  String get manualEntry => '手动录入';

  @override
  String get quickManualSubtitle => '手动输入物品详情';

  @override
  String get aiScan => 'AI 扫描';

  @override
  String get quickAiSubtitle => '扫描收据或商品';

  @override
  String get reminderTitle => '到期提醒';

  @override
  String reminderSummary(int expired, int dueSoon) {
    return '$expired 个已过期，$dueSoon 个即将到期';
  }

  @override
  String reminderTotal(int count) {
    return '共 $count 件';
  }

  @override
  String get reminderExpiredTitle => '已到期提醒';

  @override
  String reminderExpiredCount(int count) {
    return '已到期 $count 件';
  }

  @override
  String get reminderDueSoonTitle => '快到期提醒';

  @override
  String reminderDueSoonCount(int count) {
    return '快到期 $count 件';
  }

  @override
  String get settingsTitle => '设置';

  @override
  String get settingsAiSectionTitle => 'AI 配置';

  @override
  String get settingsApiUrlLabel => 'API 地址';

  @override
  String get settingsApiUrlHint => 'https://api.openai.com/v1...';

  @override
  String get settingsApiKeyLabel => 'API 密钥';

  @override
  String get settingsApiKeyHint => 'sk-...';

  @override
  String get settingsConfigured => '已配置';

  @override
  String get settingsNotConfigured => '未配置';

  @override
  String get settingsReminderTitle => '提醒设置';

  @override
  String settingsReminderDays(int days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other: '提前 $days 天提醒',
      zero: '当天提醒',
    );
    return '$_temp0';
  }

  @override
  String get settingsReminderTimeTitle => '提醒时间';

  @override
  String get settingsReminderHourLabel => '时';

  @override
  String get settingsReminderMinuteLabel => '分';

  @override
  String get settingsReminderSecondLabel => '秒';

  @override
  String get settingsSaveButton => '保存设置';

  @override
  String get settingsSavedSnack => '设置已保存';

  @override
  String get settingsLanguageTitle => '语言';

  @override
  String get settingsLanguageSystem => '跟随系统';

  @override
  String get settingsLanguageEn => 'English';

  @override
  String get settingsLanguageZh => '中文';

  @override
  String get aiPanelTitle => 'AI 助手';

  @override
  String get aiConfiguredMessage => 'AI 准备就绪，可以帮您识别物品。';

  @override
  String get aiNotConfiguredMessage => '请在设置中配置 AI 以使用此功能。';

  @override
  String get aiTextFieldLabel => '描述物品';

  @override
  String get aiTextFieldHint => '例如：下周五过期的牛奶';

  @override
  String get aiStartButton => '识别';

  @override
  String get addItemTitle => '添加新物品';

  @override
  String get addItemManualSectionTitle => '物品详情';

  @override
  String get addItemNameLabel => '物品名称';

  @override
  String get addItemNameHint => '例如：牛奶';

  @override
  String get addItemExpiryLabel => '到期日期';

  @override
  String get selectExpiryDate => '选择到期日期';

  @override
  String get addItemNotesLabel => '备注（可选）';

  @override
  String get addItemNotesHint => '任何额外细节';

  @override
  String get addItemSaveButton => '保存物品';

  @override
  String get addItemNameRequired => '请输入物品名称';

  @override
  String get addItemDateRequired => '请选择到期日期';

  @override
  String get aiResultEmptyInput => '请描述物品';

  @override
  String get aiResultNoDateFound => '未找到到期日期';

  @override
  String get aiResultDateDetected => '已识别日期！';
}
