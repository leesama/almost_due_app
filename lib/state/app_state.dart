import 'package:flutter/foundation.dart';

import '../data/models/app_settings.dart';
import '../data/models/expiry_item.dart';

@immutable
class AppStateData {
  AppStateData({
    required List<ExpiryItem> items,
    required this.settings,
  }) : _items = List.unmodifiable(items);

  final List<ExpiryItem> _items;
  final AppSettings settings;

  factory AppStateData.initial() {
    return AppStateData(
      items: const [],
      settings: AppSettings.defaults(),
    );
  }

  List<ExpiryItem> get items => _items;

  List<ExpiryItem> get sortedItems {
    final copy = [..._items];
    copy.sort((a, b) => a.expiryDate.compareTo(b.expiryDate));
    return copy;
  }

  AppStateData copyWith({
    List<ExpiryItem>? items,
    AppSettings? settings,
  }) {
    return AppStateData(
      items: items ?? _items,
      settings: settings ?? this.settings,
    );
  }
}
