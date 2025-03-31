import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

/// Enum for different toast types
enum ToastType { info, success, warning, danger }

class ToastProvider extends StatefulWidget {
  final Widget child;
  static final GlobalKey<_ToastProviderState> _key =
      GlobalKey<_ToastProviderState>();

  const ToastProvider({super.key, required this.child});

  static _ToastProviderState of(BuildContext context) {
    final _ToastProviderState? result =
        _key.currentState ??
        context.findAncestorStateOfType<_ToastProviderState>();

    if (result == null) {
      throw FlutterError(
        '❌ Error: Toast context is null! Ensure ToastProvider is wrapped around the app.',
      );
    }
    return result;
  }

  @override
  State<ToastProvider> createState() => _ToastProviderState();
}

class _ToastProviderState extends State<ToastProvider> {
  final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
      GlobalKey<ScaffoldMessengerState>();

  @override
  Widget build(BuildContext context) {
    return ScaffoldMessenger(key: scaffoldMessengerKey, child: widget.child);
  }

  void showToast({
    required ToastType type,
    String? title,
    String? message,
    IconData? icon,
    Duration duration = const Duration(seconds: 3),
  }) {
    final toastStyles = {
      ToastType.info: {"icon": Iconsax.info_circle, "color": Colors.blue},
      ToastType.success: {"icon": Iconsax.tick_circle, "color": Colors.green},
      ToastType.warning: {"icon": Iconsax.warning_2, "color": Colors.orange},
      ToastType.danger: {"icon": Iconsax.close_circle, "color": Colors.red},
    };

    final style = toastStyles[type]!;
    Flushbar(
      title: title ?? type.toString().split('.').last.toUpperCase(),
      message: message ?? "This is a ${type.name} toast!",
      icon: Icon(
        icon ?? style["icon"] as IconData,
        size: 28.0,
        color: style["color"] as Color,
      ),
      duration: duration,
      flushbarPosition: FlushbarPosition.BOTTOM,
      backgroundColor: Colors.black87,
    ).show(context);
  }
}
