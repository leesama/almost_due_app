import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../models/app_settings.dart';
import '../models/expiry_item.dart';

class StorageService {
  static const _itemsKey = 'expiry_items';
  static const _settingsKey = 'app_settings';

  Future<List<ExpiryItem>> loadItems() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(_itemsKey);
    if (raw == null || raw.isEmpty) {
      return [];
    }
    final data = jsonDecode(raw);
    if (data is! List) {
      return [];
    }
    return data
        .map(
          (entry) => ExpiryItem.fromJson(
            Map<String, dynamic>.from(entry as Map),
          ),
        )
        .toList();
  }

  Future<void> saveItems(List<ExpiryItem> items) async {
    final prefs = await SharedPreferences.getInstance();
    final data = items.map((item) => item.toJson()).toList();
    await prefs.setString(_itemsKey, jsonEncode(data));
  }

  Future<AppSettings> loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(_settingsKey);
    if (raw == null || raw.isEmpty) {
      return AppSettings.defaults();
    }
    final data = jsonDecode(raw);
    if (data is! Map) {
      return AppSettings.defaults();
    }
    return AppSettings.fromJson(Map<String, dynamic>.from(data));
  }

  Future<void> saveSettings(AppSettings settings) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_settingsKey, jsonEncode(settings.toJson()));
  }
}
