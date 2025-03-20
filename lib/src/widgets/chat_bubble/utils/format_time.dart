import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

String formatChatTime({
  required DateTime datetime,
  required BuildContext context,
}) {
  bool is24HourFormat = MediaQuery.of(context).alwaysUse24HourFormat;

  String formattedTime =
      is24HourFormat
          ? DateFormat.Hm().format(datetime)
          : DateFormat.jm().format(datetime);
  return formattedTime;
}
