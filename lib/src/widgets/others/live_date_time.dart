import 'package:flutter/scheduler.dart';
import 'package:flutter/widgets.dart';

/// return the current time in seconds
class LiveDateTimeProvider extends StatefulWidget {
  final Widget child;

  const LiveDateTimeProvider({super.key, required this.child});

  static DateTime of(BuildContext context, [bool listen = true]) {
    final liveDateTime =
        listen
            ? context.dependOnInheritedWidgetOfExactType<_LiveDateTime>()
            : context.findAncestorWidgetOfExactType<_LiveDateTime>();
    if (liveDateTime == null) {
      throw Exception(
        "LiveDateTimeProvider not found, make sure LiveDateTimeProvider is"
        " set in the widget tree",
      );
    }
    return liveDateTime.dateTime;
  }

  @override
  State<LiveDateTimeProvider> createState() => _LiveDateTimeProviderState();
}

class _LiveDateTimeProviderState extends State<LiveDateTimeProvider>
    with SingleTickerProviderStateMixin {
  late DateTime currentDateTime;
  late Ticker ticker;

  @override
  void initState() {
    super.initState();
    currentDateTime = _startOfSecond();
    ticker = createTicker((_) {
      _updateTime();
    });
  }

  /// only trigger set state when at least the seconds has changed
  void _updateTime() {
    var startOfSecond = _startOfSecond();
    if (startOfSecond == currentDateTime) return;
    setState(() => currentDateTime = startOfSecond);
  }

  DateTime _startOfSecond() {
    return DateTime.now().copyWith(millisecond: 0, microsecond: 0);
  }

  @override
  void dispose() {
    ticker.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _LiveDateTime(dateTime: currentDateTime, child: widget.child);
  }
}

class _LiveDateTime extends InheritedWidget {
  final DateTime dateTime;

  const _LiveDateTime({required this.dateTime, required super.child});

  @override
  bool updateShouldNotify(covariant _LiveDateTime oldWidget) {
    return dateTime != oldWidget.dateTime;
  }
}
