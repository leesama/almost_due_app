class AppSettings {
  static const Object _unset = Object();

  const AppSettings({
    required this.apiBaseUrl,
    required this.apiKey,
    required this.reminderDays,
    this.languageCode,
  });

  final String apiBaseUrl;
  final String apiKey;
  final int reminderDays;
  final String? languageCode;

  factory AppSettings.defaults() => const AppSettings(
    apiBaseUrl: '',
    apiKey: '',
    reminderDays: 3,
    languageCode: null,
  );

  bool get isAiConfigured =>
      apiBaseUrl.trim().isNotEmpty && apiKey.trim().isNotEmpty;

  AppSettings copyWith({
    String? apiBaseUrl,
    String? apiKey,
    int? reminderDays,
    Object? languageCode = _unset,
  }) {
    return AppSettings(
      apiBaseUrl: apiBaseUrl ?? this.apiBaseUrl,
      apiKey: apiKey ?? this.apiKey,
      reminderDays: reminderDays ?? this.reminderDays,
      languageCode: languageCode == _unset
          ? this.languageCode
          : languageCode as String?,
    );
  }

  Map<String, dynamic> toJson() => {
    'apiBaseUrl': apiBaseUrl,
    'apiKey': apiKey,
    'reminderDays': reminderDays,
    'languageCode': languageCode,
  };

  factory AppSettings.fromJson(Map<String, dynamic> json) => AppSettings(
    apiBaseUrl: (json['apiBaseUrl'] as String?) ?? '',
    apiKey: (json['apiKey'] as String?) ?? '',
    reminderDays: (json['reminderDays'] as int?) ?? 3,
    languageCode: json['languageCode'] as String?,
  );
}
