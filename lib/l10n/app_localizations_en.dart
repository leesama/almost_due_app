// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Almost Due';

  @override
  String totalItems(Object count) {
    return '$count items registered';
  }

  @override
  String get itemsListTitle => 'Items List';

  @override
  String get homeTabExpired => 'Expired Items';

  @override
  String get homeTabDueSoon => 'Due Soon Items';

  @override
  String get homeTabAll => 'All Items';

  @override
  String get addItemFab => 'Add Item';

  @override
  String get itemSavedSnack => 'Item saved';

  @override
  String get notificationChannelName => 'Expiry Reminder';

  @override
  String get notificationChannelDescription =>
      'Notifications for items expiring soon';

  @override
  String get notificationTitle => 'Item Expiring Soon';

  @override
  String notificationBody(Object days, Object itemName) {
    return '\"$itemName\" will expire in $days days!';
  }

  @override
  String get notificationTestTitle => 'Notification Test';

  @override
  String get notificationTestBody => '🎉 Hooray! Notifications are working!';

  @override
  String get statusSafeLabel => 'Safe';

  @override
  String statusDueInDays(int days) {
    return 'Due in $days days';
  }

  @override
  String get statusExpiredLabel => 'Expired';

  @override
  String statusExpiredDetail(int days) {
    return 'Expired by $days days';
  }

  @override
  String get statusTodayLabel => 'Today';

  @override
  String get statusTodayDetail => 'Expires today!';

  @override
  String get statusDueSoonLabel => 'Due Soon';

  @override
  String expiryDateWithValue(String date) {
    return 'Expires: $date';
  }

  @override
  String notesWithValue(String notes) {
    return 'Notes: $notes';
  }

  @override
  String get deleteItemSnack => 'Item deleted';

  @override
  String get emptyTitle => 'No Items Yet';

  @override
  String get emptySubtitle => 'Add some items to track their expiry dates!';

  @override
  String get manualEntry => 'Manual Entry';

  @override
  String get quickManualSubtitle => 'Enter details manually';

  @override
  String get aiScan => 'AI Scan';

  @override
  String get quickAiSubtitle => 'Scan receipt or item';

  @override
  String get reminderTitle => 'Reminders';

  @override
  String reminderSummary(int expired, int dueSoon) {
    return '$expired expired, $dueSoon due soon';
  }

  @override
  String reminderTotal(int count) {
    return 'Total: $count';
  }

  @override
  String get reminderExpiredTitle => 'Expired Reminders';

  @override
  String reminderExpiredCount(int count) {
    return '$count expired';
  }

  @override
  String get reminderDueSoonTitle => 'Due Soon Reminders';

  @override
  String reminderDueSoonCount(int count) {
    return '$count due soon';
  }

  @override
  String get settingsTitle => 'Settings';

  @override
  String get settingsAiSectionTitle => 'AI Configuration';

  @override
  String get settingsApiUrlLabel => 'API URL';

  @override
  String get settingsApiUrlHint => 'https://api.openai.com/v1...';

  @override
  String get settingsApiKeyLabel => 'API Key';

  @override
  String get settingsApiKeyHint => 'sk-...';

  @override
  String get settingsConfigured => 'Configured';

  @override
  String get settingsNotConfigured => 'Not configured';

  @override
  String get settingsReminderTitle => 'Reminder Settings';

  @override
  String settingsReminderDays(int days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other: 'Remind $days days before',
      zero: 'Remind on the day',
    );
    return '$_temp0';
  }

  @override
  String get settingsReminderTimeTitle => 'Reminder Time';

  @override
  String get settingsReminderHourLabel => 'Hour';

  @override
  String get settingsReminderMinuteLabel => 'Minute';

  @override
  String get settingsReminderSecondLabel => 'Second';

  @override
  String get settingsSaveButton => 'Save Settings';

  @override
  String get settingsSavedSnack => 'Settings saved';

  @override
  String get settingsLanguageTitle => 'Language';

  @override
  String get settingsLanguageSystem => 'System Default';

  @override
  String get settingsLanguageEn => 'English';

  @override
  String get settingsLanguageZh => 'Chinese';

  @override
  String get aiPanelTitle => 'AI Assistant';

  @override
  String get aiConfiguredMessage => 'AI is ready to help you scan items.';

  @override
  String get aiNotConfiguredMessage =>
      'Configure AI in settings to use this feature.';

  @override
  String get aiTextFieldLabel => 'Describe item';

  @override
  String get aiTextFieldHint => 'e.g., Milk expiring next Friday';

  @override
  String get aiStartButton => 'Identify';

  @override
  String get addItemTitle => 'Add New Item';

  @override
  String get addItemManualSectionTitle => 'Item Details';

  @override
  String get addItemNameLabel => 'Item Name';

  @override
  String get addItemNameHint => 'e.g., Milk';

  @override
  String get addItemExpiryLabel => 'Expiry Date';

  @override
  String get selectExpiryDate => 'Select Expiry Date';

  @override
  String get addItemNotesLabel => 'Notes (Optional)';

  @override
  String get addItemNotesHint => 'Any extra details';

  @override
  String get addItemSaveButton => 'Save Item';

  @override
  String get addItemNameRequired => 'Please enter an item name';

  @override
  String get addItemDateRequired => 'Please select an expiry date';

  @override
  String get aiResultEmptyInput => 'Please describe the item';

  @override
  String get aiResultNoDateFound => 'No expiry date found in text';

  @override
  String get aiResultDateDetected => 'Date detected!';
}
