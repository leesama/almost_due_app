class ExpiryItem {
  const ExpiryItem({
    required this.id,
    required this.name,
    required this.expiryDate,
    this.notes = '',
  });

  final String id;
  final String name;
  final DateTime expiryDate;
  final String notes;

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'expiryDate': expiryDate.toIso8601String(),
        'notes': notes,
      };

  factory ExpiryItem.fromJson(Map<String, dynamic> json) => ExpiryItem(
        id: json['id'] as String,
        name: json['name'] as String,
        expiryDate: DateTime.parse(json['expiryDate'] as String),
        notes: (json['notes'] as String?) ?? '',
      );
}
