import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_zh.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('zh'),
  ];

  /// No description provided for @appTitle.
  ///
  /// In zh, this message translates to:
  /// **'快到期啦'**
  String get appTitle;

  /// No description provided for @totalItems.
  ///
  /// In zh, this message translates to:
  /// **'当前已登记 {count} 件'**
  String totalItems(Object count);

  /// No description provided for @itemsListTitle.
  ///
  /// In zh, this message translates to:
  /// **'物品列表'**
  String get itemsListTitle;

  /// No description provided for @homeTabExpired.
  ///
  /// In zh, this message translates to:
  /// **'已到期商品'**
  String get homeTabExpired;

  /// No description provided for @homeTabDueSoon.
  ///
  /// In zh, this message translates to:
  /// **'快到期商品'**
  String get homeTabDueSoon;

  /// No description provided for @homeTabAll.
  ///
  /// In zh, this message translates to:
  /// **'所有商品'**
  String get homeTabAll;

  /// No description provided for @addItemFab.
  ///
  /// In zh, this message translates to:
  /// **'添加物品'**
  String get addItemFab;

  /// No description provided for @itemSavedSnack.
  ///
  /// In zh, this message translates to:
  /// **'已保存物品'**
  String get itemSavedSnack;

  /// No description provided for @notificationChannelName.
  ///
  /// In zh, this message translates to:
  /// **'到期提醒'**
  String get notificationChannelName;

  /// No description provided for @notificationChannelDescription.
  ///
  /// In zh, this message translates to:
  /// **'物品即将到期的提醒通知'**
  String get notificationChannelDescription;

  /// No description provided for @notificationTitle.
  ///
  /// In zh, this message translates to:
  /// **'物品即将到期'**
  String get notificationTitle;

  /// No description provided for @notificationBody.
  ///
  /// In zh, this message translates to:
  /// **'「{itemName}」将在 {days} 天后到期，请及时处理！'**
  String notificationBody(Object days, Object itemName);

  /// No description provided for @notificationTestTitle.
  ///
  /// In zh, this message translates to:
  /// **'通知测试'**
  String get notificationTestTitle;

  /// No description provided for @notificationTestBody.
  ///
  /// In zh, this message translates to:
  /// **'🎉 恭喜！通知功能正常工作！'**
  String get notificationTestBody;

  /// No description provided for @statusSafeLabel.
  ///
  /// In zh, this message translates to:
  /// **'安全'**
  String get statusSafeLabel;

  /// No description provided for @statusDueInDays.
  ///
  /// In zh, this message translates to:
  /// **'{days} 天后到期'**
  String statusDueInDays(int days);

  /// No description provided for @statusExpiredLabel.
  ///
  /// In zh, this message translates to:
  /// **'已过期'**
  String get statusExpiredLabel;

  /// No description provided for @statusExpiredDetail.
  ///
  /// In zh, this message translates to:
  /// **'已过期 {days} 天'**
  String statusExpiredDetail(int days);

  /// No description provided for @statusTodayLabel.
  ///
  /// In zh, this message translates to:
  /// **'今天'**
  String get statusTodayLabel;

  /// No description provided for @statusTodayDetail.
  ///
  /// In zh, this message translates to:
  /// **'今天到期！'**
  String get statusTodayDetail;

  /// No description provided for @statusDueSoonLabel.
  ///
  /// In zh, this message translates to:
  /// **'即将到期'**
  String get statusDueSoonLabel;

  /// No description provided for @expiryDateWithValue.
  ///
  /// In zh, this message translates to:
  /// **'到期日：{date}'**
  String expiryDateWithValue(String date);

  /// No description provided for @notesWithValue.
  ///
  /// In zh, this message translates to:
  /// **'备注：{notes}'**
  String notesWithValue(String notes);

  /// No description provided for @deleteItemSnack.
  ///
  /// In zh, this message translates to:
  /// **'已删除物品'**
  String get deleteItemSnack;

  /// No description provided for @emptyTitle.
  ///
  /// In zh, this message translates to:
  /// **'暂无物品'**
  String get emptyTitle;

  /// No description provided for @emptySubtitle.
  ///
  /// In zh, this message translates to:
  /// **'快添加一些物品来追踪保质期吧！'**
  String get emptySubtitle;

  /// No description provided for @manualEntry.
  ///
  /// In zh, this message translates to:
  /// **'手动录入'**
  String get manualEntry;

  /// No description provided for @quickManualSubtitle.
  ///
  /// In zh, this message translates to:
  /// **'手动输入物品详情'**
  String get quickManualSubtitle;

  /// No description provided for @aiScan.
  ///
  /// In zh, this message translates to:
  /// **'AI 扫描'**
  String get aiScan;

  /// No description provided for @quickAiSubtitle.
  ///
  /// In zh, this message translates to:
  /// **'扫描收据或商品'**
  String get quickAiSubtitle;

  /// No description provided for @reminderTitle.
  ///
  /// In zh, this message translates to:
  /// **'到期提醒'**
  String get reminderTitle;

  /// No description provided for @reminderSummary.
  ///
  /// In zh, this message translates to:
  /// **'{expired} 个已过期，{dueSoon} 个即将到期'**
  String reminderSummary(int expired, int dueSoon);

  /// No description provided for @reminderTotal.
  ///
  /// In zh, this message translates to:
  /// **'共 {count} 件'**
  String reminderTotal(int count);

  /// No description provided for @reminderExpiredTitle.
  ///
  /// In zh, this message translates to:
  /// **'已到期提醒'**
  String get reminderExpiredTitle;

  /// No description provided for @reminderExpiredCount.
  ///
  /// In zh, this message translates to:
  /// **'已到期 {count} 件'**
  String reminderExpiredCount(int count);

  /// No description provided for @reminderDueSoonTitle.
  ///
  /// In zh, this message translates to:
  /// **'快到期提醒'**
  String get reminderDueSoonTitle;

  /// No description provided for @reminderDueSoonCount.
  ///
  /// In zh, this message translates to:
  /// **'快到期 {count} 件'**
  String reminderDueSoonCount(int count);

  /// No description provided for @settingsTitle.
  ///
  /// In zh, this message translates to:
  /// **'设置'**
  String get settingsTitle;

  /// No description provided for @settingsAiSectionTitle.
  ///
  /// In zh, this message translates to:
  /// **'AI 配置'**
  String get settingsAiSectionTitle;

  /// No description provided for @settingsApiUrlLabel.
  ///
  /// In zh, this message translates to:
  /// **'API 地址'**
  String get settingsApiUrlLabel;

  /// No description provided for @settingsApiUrlHint.
  ///
  /// In zh, this message translates to:
  /// **'https://api.openai.com/v1...'**
  String get settingsApiUrlHint;

  /// No description provided for @settingsApiKeyLabel.
  ///
  /// In zh, this message translates to:
  /// **'API 密钥'**
  String get settingsApiKeyLabel;

  /// No description provided for @settingsApiKeyHint.
  ///
  /// In zh, this message translates to:
  /// **'sk-...'**
  String get settingsApiKeyHint;

  /// No description provided for @settingsConfigured.
  ///
  /// In zh, this message translates to:
  /// **'已配置'**
  String get settingsConfigured;

  /// No description provided for @settingsNotConfigured.
  ///
  /// In zh, this message translates to:
  /// **'未配置'**
  String get settingsNotConfigured;

  /// No description provided for @settingsReminderTitle.
  ///
  /// In zh, this message translates to:
  /// **'提醒设置'**
  String get settingsReminderTitle;

  /// No description provided for @settingsReminderDays.
  ///
  /// In zh, this message translates to:
  /// **'{days, plural, =0{当天提醒} other{提前 {days} 天提醒}}'**
  String settingsReminderDays(int days);

  /// No description provided for @settingsReminderTimeTitle.
  ///
  /// In zh, this message translates to:
  /// **'提醒时间'**
  String get settingsReminderTimeTitle;

  /// No description provided for @settingsReminderHourLabel.
  ///
  /// In zh, this message translates to:
  /// **'时'**
  String get settingsReminderHourLabel;

  /// No description provided for @settingsReminderMinuteLabel.
  ///
  /// In zh, this message translates to:
  /// **'分'**
  String get settingsReminderMinuteLabel;

  /// No description provided for @settingsReminderSecondLabel.
  ///
  /// In zh, this message translates to:
  /// **'秒'**
  String get settingsReminderSecondLabel;

  /// No description provided for @settingsSaveButton.
  ///
  /// In zh, this message translates to:
  /// **'保存设置'**
  String get settingsSaveButton;

  /// No description provided for @settingsSavedSnack.
  ///
  /// In zh, this message translates to:
  /// **'设置已保存'**
  String get settingsSavedSnack;

  /// No description provided for @settingsLanguageTitle.
  ///
  /// In zh, this message translates to:
  /// **'语言'**
  String get settingsLanguageTitle;

  /// No description provided for @settingsLanguageSystem.
  ///
  /// In zh, this message translates to:
  /// **'跟随系统'**
  String get settingsLanguageSystem;

  /// No description provided for @settingsLanguageEn.
  ///
  /// In zh, this message translates to:
  /// **'English'**
  String get settingsLanguageEn;

  /// No description provided for @settingsLanguageZh.
  ///
  /// In zh, this message translates to:
  /// **'中文'**
  String get settingsLanguageZh;

  /// No description provided for @aiPanelTitle.
  ///
  /// In zh, this message translates to:
  /// **'AI 助手'**
  String get aiPanelTitle;

  /// No description provided for @aiConfiguredMessage.
  ///
  /// In zh, this message translates to:
  /// **'AI 准备就绪，可以帮您识别物品。'**
  String get aiConfiguredMessage;

  /// No description provided for @aiNotConfiguredMessage.
  ///
  /// In zh, this message translates to:
  /// **'请在设置中配置 AI 以使用此功能。'**
  String get aiNotConfiguredMessage;

  /// No description provided for @aiTextFieldLabel.
  ///
  /// In zh, this message translates to:
  /// **'描述物品'**
  String get aiTextFieldLabel;

  /// No description provided for @aiTextFieldHint.
  ///
  /// In zh, this message translates to:
  /// **'例如：下周五过期的牛奶'**
  String get aiTextFieldHint;

  /// No description provided for @aiStartButton.
  ///
  /// In zh, this message translates to:
  /// **'识别'**
  String get aiStartButton;

  /// No description provided for @addItemTitle.
  ///
  /// In zh, this message translates to:
  /// **'添加新物品'**
  String get addItemTitle;

  /// No description provided for @addItemManualSectionTitle.
  ///
  /// In zh, this message translates to:
  /// **'物品详情'**
  String get addItemManualSectionTitle;

  /// No description provided for @addItemNameLabel.
  ///
  /// In zh, this message translates to:
  /// **'物品名称'**
  String get addItemNameLabel;

  /// No description provided for @addItemNameHint.
  ///
  /// In zh, this message translates to:
  /// **'例如：牛奶'**
  String get addItemNameHint;

  /// No description provided for @addItemExpiryLabel.
  ///
  /// In zh, this message translates to:
  /// **'到期日期'**
  String get addItemExpiryLabel;

  /// No description provided for @selectExpiryDate.
  ///
  /// In zh, this message translates to:
  /// **'选择到期日期'**
  String get selectExpiryDate;

  /// No description provided for @addItemNotesLabel.
  ///
  /// In zh, this message translates to:
  /// **'备注（可选）'**
  String get addItemNotesLabel;

  /// No description provided for @addItemNotesHint.
  ///
  /// In zh, this message translates to:
  /// **'任何额外细节'**
  String get addItemNotesHint;

  /// No description provided for @addItemSaveButton.
  ///
  /// In zh, this message translates to:
  /// **'保存物品'**
  String get addItemSaveButton;

  /// No description provided for @addItemNameRequired.
  ///
  /// In zh, this message translates to:
  /// **'请输入物品名称'**
  String get addItemNameRequired;

  /// No description provided for @addItemDateRequired.
  ///
  /// In zh, this message translates to:
  /// **'请选择到期日期'**
  String get addItemDateRequired;

  /// No description provided for @aiResultEmptyInput.
  ///
  /// In zh, this message translates to:
  /// **'请描述物品'**
  String get aiResultEmptyInput;

  /// No description provided for @aiResultNoDateFound.
  ///
  /// In zh, this message translates to:
  /// **'未找到到期日期'**
  String get aiResultNoDateFound;

  /// No description provided for @aiResultDateDetected.
  ///
  /// In zh, this message translates to:
  /// **'已识别日期！'**
  String get aiResultDateDetected;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'zh'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'zh':
      return AppLocalizationsZh();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
