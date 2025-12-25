class AppSettings {
  static const Object _unset = Object();

  const AppSettings({
    required this.apiBaseUrl,
    required this.apiKey,
    required this.reminderDays,
    required this.reminderHour,
    required this.reminderMinute,
    required this.reminderSecond,
    this.languageCode,
  });

  final String apiBaseUrl;
  final String apiKey;
  final int reminderDays;
  final int reminderHour;
  final int reminderMinute;
  final int reminderSecond;
  final String? languageCode;

  factory AppSettings.defaults() => const AppSettings(
    apiBaseUrl: '',
    apiKey: '',
    reminderDays: 3,
    reminderHour: 9,
    reminderMinute: 0,
    reminderSecond: 0,
    languageCode: null,
  );

  bool get isAiConfigured =>
      apiBaseUrl.trim().isNotEmpty && apiKey.trim().isNotEmpty;

  AppSettings copyWith({
    String? apiBaseUrl,
    String? apiKey,
    int? reminderDays,
    int? reminderHour,
    int? reminderMinute,
    int? reminderSecond,
    Object? languageCode = _unset,
  }) {
    return AppSettings(
      apiBaseUrl: apiBaseUrl ?? this.apiBaseUrl,
      apiKey: apiKey ?? this.apiKey,
      reminderDays: reminderDays ?? this.reminderDays,
      reminderHour: reminderHour ?? this.reminderHour,
      reminderMinute: reminderMinute ?? this.reminderMinute,
      reminderSecond: reminderSecond ?? this.reminderSecond,
      languageCode: languageCode == _unset
          ? this.languageCode
          : languageCode as String?,
    );
  }

  Map<String, dynamic> toJson() => {
    'apiBaseUrl': apiBaseUrl,
    'apiKey': apiKey,
    'reminderDays': reminderDays,
    'reminderHour': reminderHour,
    'reminderMinute': reminderMinute,
    'reminderSecond': reminderSecond,
    'languageCode': languageCode,
  };

  factory AppSettings.fromJson(Map<String, dynamic> json) => AppSettings(
    apiBaseUrl: (json['apiBaseUrl'] as String?) ?? '',
    apiKey: (json['apiKey'] as String?) ?? '',
    reminderDays: (json['reminderDays'] as int?) ?? 3,
    reminderHour: (json['reminderHour'] as int?) ?? 9,
    reminderMinute: (json['reminderMinute'] as int?) ?? 0,
    reminderSecond: (json['reminderSecond'] as int?) ?? 0,
    languageCode: json['languageCode'] as String?,
  );
}
