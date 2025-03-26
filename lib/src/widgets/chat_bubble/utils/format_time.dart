import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

class CustomDateHelper {
  /// Formats time based on the device's 12-hour or 24-hour setting.
  static String formatTime({
    required DateTime datetime,
    required BuildContext context,
  }) {
    bool is24HourFormat = MediaQuery.of(context).alwaysUse24HourFormat;

    return is24HourFormat
        ? DateFormat.Hm().format(datetime) // 24-hour format (e.g., 14:30)
        : DateFormat.jm().format(datetime); // 12-hour format (e.g., 2:30 PM)
  }

  /// Formats a DateTime to a full date string (e.g., Mar 25, 2025).
  static String formatDate(DateTime dateTime) {
    return DateFormat('MMM dd, yyyy').format(dateTime);
  }

  /// Formats a DateTime to include date and time (e.g., 2025-03-25 14:30).
  static String formatDateTime(DateTime dateTime) {
    return DateFormat('yyyy-MM-dd HH:mm').format(dateTime);
  }
}
