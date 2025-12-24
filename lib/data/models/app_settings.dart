class AppSettings {
  const AppSettings({
    required this.apiBaseUrl,
    required this.apiKey,
    required this.reminderDays,
  });

  final String apiBaseUrl;
  final String apiKey;
  final int reminderDays;

  factory AppSettings.defaults() => const AppSettings(
        apiBaseUrl: '',
        apiKey: '',
        reminderDays: 3,
      );

  bool get isAiConfigured =>
      apiBaseUrl.trim().isNotEmpty && apiKey.trim().isNotEmpty;

  AppSettings copyWith({
    String? apiBaseUrl,
    String? apiKey,
    int? reminderDays,
  }) {
    return AppSettings(
      apiBaseUrl: apiBaseUrl ?? this.apiBaseUrl,
      apiKey: apiKey ?? this.apiKey,
      reminderDays: reminderDays ?? this.reminderDays,
    );
  }

  Map<String, dynamic> toJson() => {
        'apiBaseUrl': apiBaseUrl,
        'apiKey': apiKey,
        'reminderDays': reminderDays,
      };

  factory AppSettings.fromJson(Map<String, dynamic> json) => AppSettings(
        apiBaseUrl: (json['apiBaseUrl'] as String?) ?? '',
        apiKey: (json['apiKey'] as String?) ?? '',
        reminderDays: (json['reminderDays'] as int?) ?? 3,
      );
}
