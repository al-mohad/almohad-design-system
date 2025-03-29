import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

/// Global navigator key to access context globally
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

/// Enum representing different types of toasts
enum ToastType { info, success, warning, danger }

class CustomToasts {
  static BuildContext? get _context => navigatorKey.currentContext;

  /// Displays a toast based on the provided [type] with optional customization
  static void show({
    required ToastType type,
    String? title,
    Color? titleColor,
    double? titleSize,
    String? message,
    Color? messageColor,
    double? messageSize,
    Widget? titleText,
    Widget? messageText,
    IconData? icon,
    bool shouldIconPulse = true,
    double? maxWidth,
    EdgeInsetsGeometry margin = EdgeInsets.zero,
    EdgeInsetsGeometry padding = EdgeInsets.zero,
    double? borderRadius,
    TextDirection textDirection = TextDirection.ltr,
    Color? borderColor,
    double borderWidth = 1.0,
    Color backgroundColor = const Color(0xFF303030),
    Color? leftBarIndicatorColor,
    List<BoxShadow>? boxShadows,
    Gradient? backgroundGradient,
    Widget? mainButton,
    VoidCallback? onTap,
    Duration? duration = const Duration(seconds: 5),
    bool isDismissible = true,
    FlushbarDismissDirection dismissDirection =
        FlushbarDismissDirection.VERTICAL,
    bool showProgressIndicator = false,
    AnimationController? progressIndicatorController,
    Color? progressIndicatorBackgroundColor,
    Animation<Color?>? progressIndicatorValueColor,
    FlushbarPosition flushbarPosition = FlushbarPosition.BOTTOM,
    double positionOffset = 0.0,
    FlushbarStyle flushbarStyle = FlushbarStyle.FLOATING,
    Curve forwardAnimationCurve = Curves.easeOutCirc,
    Curve reverseAnimationCurve = Curves.easeOutCirc,
    Duration animationDuration = const Duration(seconds: 1),
    FlushbarStatusCallback? onStatusChanged,
    double barBlur = 0.0,
    bool blockBackgroundInteraction = false,
    double? routeBlur,
    Color? routeColor,
    Form? userInputForm,
    Offset? endOffset,
  }) {
    if (_context == null) return;

    final Map<ToastType, Map<String, dynamic>> toastProperties = {
      ToastType.info: {
        "defaultMessage": "This is an info message",
        "icon": Iconsax.info_circle,
        "color": Colors.blue[300],
      },
      ToastType.success: {
        "defaultMessage": "Operation completed successfully",
        "icon": Iconsax.tick_circle,
        "color": Colors.green[300],
      },
      ToastType.warning: {
        "defaultMessage": "This is a warning. Please check carefully!",
        "icon": Iconsax.warning_2,
        "color": Colors.orange[300],
      },
      ToastType.danger: {
        "defaultMessage": "Something went wrong! Please try again.",
        "icon": Iconsax.close_circle,
        "color": Colors.red[300],
      },
    };

    final properties = toastProperties[type];

    Flushbar(
      title: title,
      titleColor: titleColor,
      titleSize: titleSize,
      message: message ?? properties?["defaultMessage"],
      messageColor: messageColor,
      messageSize: messageSize,
      titleText: titleText,
      messageText: messageText,
      icon:
          icon != null
              ? Icon(icon, size: 28.0, color: properties?["color"])
              : null,
      shouldIconPulse: shouldIconPulse,
      maxWidth: maxWidth,
      margin: margin as EdgeInsets,
      padding: padding as EdgeInsets,
      borderRadius:
          borderRadius != null ? BorderRadius.circular(borderRadius) : null,
      textDirection: textDirection,
      borderColor: borderColor,
      borderWidth: borderWidth,
      backgroundColor: backgroundColor,
      leftBarIndicatorColor: leftBarIndicatorColor ?? properties?["color"],
      boxShadows: boxShadows,
      backgroundGradient: backgroundGradient,
      mainButton: mainButton,
      onTap: onTap != null ? (_) => onTap() : null,
      duration: duration,
      isDismissible: isDismissible,
      dismissDirection: dismissDirection,
      showProgressIndicator: showProgressIndicator,
      progressIndicatorController: progressIndicatorController,
      progressIndicatorBackgroundColor: progressIndicatorBackgroundColor,
      progressIndicatorValueColor:
          progressIndicatorValueColor as Animation<Color>?,
      flushbarPosition: flushbarPosition,
      positionOffset: positionOffset,
      flushbarStyle: flushbarStyle,
      forwardAnimationCurve: forwardAnimationCurve,
      reverseAnimationCurve: reverseAnimationCurve,
      animationDuration: animationDuration,
      onStatusChanged: onStatusChanged,
      barBlur: barBlur,
      blockBackgroundInteraction: blockBackgroundInteraction,
      routeBlur: routeBlur,
      routeColor: routeColor,
      userInputForm: userInputForm,
      endOffset: endOffset,
    ).show(_context!);
  }
}
