import '../models/app_settings.dart';

class AiResult {
  const AiResult({this.expiryDate, this.nameGuess, this.message});

  final DateTime? expiryDate;
  final String? nameGuess;
  final String? message;
}

class AiService {
  Future<AiResult> analyze(String text, AppSettings settings) async {
    final trimmed = text.trim();
    if (!settings.isAiConfigured) {
      return const AiResult(message: '请先在设置中配置AI API');
    }
    if (trimmed.isEmpty) {
      return const AiResult(message: '请先输入包装上的文字或拍照识别内容');
    }

    await Future<void>.delayed(const Duration(milliseconds: 500));

    final dates = _extractDates(trimmed);
    if (dates.isEmpty) {
      return const AiResult(message: '没有识别到日期，可以手动选择到期日');
    }

    dates.sort();
    final pickedDate = dates.last;
    final nameGuess = _guessName(trimmed);

    return AiResult(
      expiryDate: pickedDate,
      nameGuess: nameGuess,
      message: '已识别到可能的到期日',
    );
  }

  List<DateTime> _extractDates(String text) {
    final results = <DateTime>[];

    final fullPattern = RegExp(r'(\d{4})[年./-](\d{1,2})[月./-](\d{1,2})');
    for (final match in fullPattern.allMatches(text)) {
      final year = int.parse(match.group(1)!);
      final month = int.parse(match.group(2)!);
      final day = int.parse(match.group(3)!);
      final date = _safeDate(year, month, day);
      if (date != null) {
        results.add(date);
      }
    }

    final shortPattern = RegExp(r'(\d{2})[./-](\d{1,2})[./-](\d{1,2})');
    for (final match in shortPattern.allMatches(text)) {
      final year = 2000 + int.parse(match.group(1)!);
      final month = int.parse(match.group(2)!);
      final day = int.parse(match.group(3)!);
      final date = _safeDate(year, month, day);
      if (date != null) {
        results.add(date);
      }
    }

    final digitsPattern = RegExp(r'\b(\d{8})\b');
    for (final match in digitsPattern.allMatches(text)) {
      final raw = match.group(1)!;
      final year = int.parse(raw.substring(0, 4));
      final month = int.parse(raw.substring(4, 6));
      final day = int.parse(raw.substring(6, 8));
      final date = _safeDate(year, month, day);
      if (date != null) {
        results.add(date);
      }
    }

    return results;
  }

  String? _guessName(String text) {
    final lines = text
        .split(RegExp(r'[\n\r]'))
        .map((line) => line.trim())
        .where((line) => line.isNotEmpty)
        .toList();
    if (lines.isEmpty) {
      return null;
    }
    final firstLine = lines.first;
    if (firstLine.length > 16) {
      return firstLine.substring(0, 16);
    }
    return firstLine;
  }

  DateTime? _safeDate(int year, int month, int day) {
    if (month < 1 || month > 12 || day < 1 || day > 31) {
      return null;
    }
    final date = DateTime(year, month, day);
    if (date.year != year || date.month != month || date.day != day) {
      return null;
    }
    return date;
  }
}
