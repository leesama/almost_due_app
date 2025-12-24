DateTime dateOnly(DateTime date) => DateTime(date.year, date.month, date.day);

int daysUntil(DateTime expiryDate) {
  final today = dateOnly(DateTime.now());
  return dateOnly(expiryDate).difference(today).inDays;
}
