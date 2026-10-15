/// Lightweight formatting helpers (no `intl` dependency).
abstract final class Formatters {
  static const List<String> _months = <String>[
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December',
  ];

  static const List<String> _monthsShort = <String>[
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'Jun',
    'Jul',
    'Aug',
    'Sep',
    'Oct',
    'Nov',
    'Dec',
  ];

  static const List<String> _weekdays = <String>[
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
    'Sunday',
  ];

  static const List<String> _weekdaysShort = <String>[
    'Mon',
    'Tue',
    'Wed',
    'Thu',
    'Fri',
    'Sat',
    'Sun',
  ];

  /// `$1,234.50`, or a compact `$1.2k` when [compact] is true.
  static String currency(
    double amount, {
    bool compact = false,
    bool withCents = true,
  }) {
    final String sign = amount < 0 ? '-' : '';
    final double abs = amount.abs();

    if (compact && abs >= 1000) {
      final double value = abs / 1000;
      final String text = value >= 100
          ? value.toStringAsFixed(0)
          : value.toStringAsFixed(1);
      return '$sign\$$text' 'k';
    }

    final int whole = abs.truncate();
    final int cents = ((abs - whole) * 100).round();
    final String grouped = _group(whole);
    if (!withCents || cents == 0) return '$sign\$$grouped';
    return '$sign\$$grouped.${cents.toString().padLeft(2, '0')}';
  }

  static String _group(int value) {
    final String digits = value.toString();
    final StringBuffer buffer = StringBuffer();
    for (int i = 0; i < digits.length; i++) {
      if (i > 0 && (digits.length - i) % 3 == 0) buffer.write(',');
      buffer.write(digits[i]);
    }
    return buffer.toString();
  }

  static String monthShort(DateTime date) => _monthsShort[date.month - 1];

  static String month(DateTime date) => _months[date.month - 1];

  static String dayOfWeekShort(DateTime date) =>
      _weekdaysShort[date.weekday - 1];

  /// e.g. `Wednesday, January 12`.
  static String fullDate(DateTime date) =>
      '${_weekdays[date.weekday - 1]}, ${_months[date.month - 1]} ${date.day}';

  /// e.g. `Jan 12 - Jan 19`.
  static String dateRange(DateTime start, DateTime end) =>
      '${monthShort(start)} ${start.day} - ${monthShort(end)} ${end.day}';

  /// e.g. `10:30 AM`.
  static String time(DateTime date) {
    final int hour12 = date.hour % 12 == 0 ? 12 : date.hour % 12;
    final String minute = date.minute.toString().padLeft(2, '0');
    final String period = date.hour < 12 ? 'AM' : 'PM';
    return '$hour12:$minute $period';
  }
}
