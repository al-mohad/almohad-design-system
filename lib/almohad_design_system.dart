import 'package:almohad_design_system/src/utils/dialogs.dart';
import 'package:almohad_design_system/src/utils/map_luancher.dart';
import 'package:almohad_design_system/src/widgets/audio_message/audio_message.dart';
import 'package:almohad_design_system/src/widgets/layouts/loading_overlay.dart';
import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart' show DateFormat;
import 'package:map_launcher/map_launcher.dart';

import 'src/src.dart';
import 'src/utils/copy_to_clipboard.dart';
import 'src/widgets/container/custom_container.dart';
import 'src/widgets/others/parallax_image.dart';
import 'src/widgets/texts/text_form_field.dart';

export 'src/src.dart';

/// **DesignSystem** - A centralized class for reusable UI components
class DesignSystem {
  DesignSystem._(); // Prevent instantiation

  /// A chat bubble widget with different styles
  static Widget chatBubble({
    required ChatMessage message,
    required bool isSender,
    bool showAvatar = true,
    Function(String)? onHashtagTapped,
    Function(String)? onTagTapped,
    Function(String)? onUrlTapped,
    Color? bubbleColor,
    TextStyle? messageTextStyle,
    TextStyle? timeTextStyle,
    ChatWidgetType? type,
    Function(List<String>, int)? onImagePreview,
  }) {
    return ChatWidget(
      message: message,
      isSender: isSender,
      showAvatar: showAvatar,
      chatWidgetType: type,
      onHashtagTapped: onHashtagTapped,
      onTagTapped: onTagTapped,
      onUrlTapped: onUrlTapped,
      bubbleColor: bubbleColor,
      messageTextStyle: messageTextStyle,
      timeTextStyle: timeTextStyle,
      onImagePreview: onImagePreview,
    );
  }

  /// A chat bubble widget with different styles
  static Widget audioPlayer({
    required String audioUrl,
    bool isSender = false,
    required String audioTitle,
    bool showUserAvatar = true,
    dynamic userAvatar,
    required Color backgroundColor,
    required Color doneColor,
    required DateTime time,
    required ChatStatus status,
    TextStyle? timeTextStyle,
    TextStyle? titleStyle,
    Color? accentColor,
  }) {
    return AudioMessage(
      audioUrl: audioUrl,
      audioTitle: audioTitle,
      status: status,
      accentColor: accentColor,
      timeTextStyle: timeTextStyle,
      titleStyle: titleStyle,
      backgroundColor: backgroundColor,
      doneColor: doneColor,
      isSender: isSender,
      showUserAvatar: showUserAvatar,
      userAvatar: userAvatar, // Network Image
      time: time,
    );
  }

  /// A text field widget with different styles
  static Widget textField({
    required String label,
    required String hintText,
    TextEditingController? controller,
    TextInputType keyboardType = TextInputType.text,
    bool obscureText = false,
    String obscuringCharacter = '●', // Default: Big dot
    IconData? prefixIcon,
    IconData? suffixIcon,
    VoidCallback? onSuffixIconTap,
    String? Function(String?)? validator,
    void Function(String)? onChanged,
    TextStyle? textStyle,
    Color? borderColor,
    Color? focusedBorderColor,
    double borderRadius = 12,
    EdgeInsets padding = const EdgeInsets.symmetric(
      horizontal: 16,
      vertical: 8,
    ),
  }) {
    return CustomTextField(
      label: label,
      hintText: hintText,
      controller: controller,
      keyboardType: keyboardType,
      obscureText: obscureText,
      obscuringCharacter: obscuringCharacter,
      prefixIcon: prefixIcon,
      suffixIcon: suffixIcon,
      onSuffixIconTap: onSuffixIconTap,
      validator: validator,
      onChanged: onChanged,
      textStyle: textStyle,
      borderColor: borderColor,
      focusedBorderColor: focusedBorderColor,
      borderRadius: borderRadius,
      padding: padding,
    );
  }

  /// A container widget with different styles
  static Widget container({
    required Widget child,
    ContainerStyle style = ContainerStyle.flat,
    double borderRadius = 12,
    Color? color,
    EdgeInsets padding = const EdgeInsets.all(16),
    EdgeInsets margin = const EdgeInsets.all(8),
    double elevation = 10,
    bool isDarkMode = false,
    double? height,
    double? width,
  }) {
    return CustomContainer(
      style: style,
      borderRadius: borderRadius,
      color: color,
      height: height,
      width: width,
      padding: padding,
      margin: margin,
      elevation: elevation,
      isDarkMode: isDarkMode,
      child: child,
    );
  }

  /// A nil widget that does nothing
  static Widget nil = const Nil();

  /// **Live Date-Time Provider**
  ///
  /// Wraps a child widget inside `LiveDateTimeProvider` to provide real-time updates.
  static Widget liveTime({required Widget child}) {
    return LiveDateTimeProvider(child: child);
  }

  static Widget expandedContent({
    required List<Widget> expandedChildren,
    required Widget collapsedContent,
    BoxDecoration? expandedDecoration,
    BoxDecoration? collapsedDecoration,
  }) {
    return ExpandableWidget(
      expandedDecoration: expandedDecoration,
      collapsedDecoration: collapsedDecoration,
      expandedChildren: expandedChildren,
      collapsedContent: collapsedContent,
    );
  }

  static parallaxImage({
    required String imageUrl,
    double height = 300,
    double parallaxFactor = 0.3,
    bool isAsset = false,
  }) => ImageParallax(
    imageUrl: imageUrl,
    isAsset: isAsset,
    height: height,
    parallaxFactor: parallaxFactor,
  );

  /// A glass morphic widget
  static Widget glass({required Widget child}) => Glassmorphism(child: child);

  /// A glass claymorphic widget
  static Widget clay({required Widget child}) => Claymorphism(child: child);

  /// A glass neumorphic widget
  static Widget neu({required Widget child}) => Neumorphism(child: child);

  static Widget imageIcon({
    required String assetPath,
    required double size,
    required Color? color,
    required bool isSvg,
  }) => CustomImageIcon(
    assetPath: assetPath,
    size: size,
    color: color,
    isSvg: isSvg,
  );

  static Widget button({
    required String text,
    required VoidCallback onPressed,
    ButtonType type = ButtonType.primary,
    Color? textColor,
    Color? buttonColor,
    Color? borderColor,
    double? fontSize,
    TextStyle? textStyle,
    FontWeight? fontWeight,
    double? height,
    double? width,
    double? radius,
    EdgeInsetsGeometry? margin,
    EdgeInsetsGeometry? padding,
    Widget? icon,
    IconAffinity iconAffinity = IconAffinity.start,
    ButtonAnimationType? animationType,
  }) => CustomButton(
    text: text,
    onPressed: onPressed,
    type: type,
    textColor: textColor,
    buttonColor: buttonColor,
    borderColor: borderColor,
    fontSize: fontSize,
    textStyle: textStyle,
    fontWeight: fontWeight,
    height: height,
    width: width,
    radius: radius,
    margin: margin,
    padding: padding,
    icon: icon,
    iconAffinity: iconAffinity,
    buttonAnimationType: animationType,
  );

  static Widget avatar({
    required String imagePath,
    required String? errorImagePath,
    required double? size,
    required AvatarType? type,
  }) => CustomAvatar(
    imageUrl: imagePath,
    size: size,
    avatarType: type,
    errorImage: errorImagePath,
  );

  static Widget loader(BuildContext context, {required String? lottiePath}) =>
      customLoader(context, lottie: lottiePath);

  static void toast({
    required BuildContext context,
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
    EdgeInsets margin = const EdgeInsets.all(0.0),
    EdgeInsets padding = const EdgeInsets.all(16),
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
    Animation<Color>? progressIndicatorValueColor,
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
    Route? flushbarRoute,
  }) => CustomToasts.show(
    context: context,
    type: type,
    title: title,
    titleColor: titleColor,
    titleSize: titleSize,
    message: message,
    messageColor: messageColor,
    messageSize: messageSize,
    titleText: titleText,
    messageText: messageText,
    icon: icon,
    shouldIconPulse: shouldIconPulse,
    maxWidth: maxWidth,
    margin: margin,
    padding: padding,
    borderRadius: borderRadius,
    textDirection: textDirection,
    borderColor: borderColor,
    borderWidth: borderWidth,
    backgroundColor: backgroundColor,
    leftBarIndicatorColor: leftBarIndicatorColor,
    boxShadows: boxShadows,
    backgroundGradient: backgroundGradient,
    mainButton: mainButton,
    onTap: onTap,
    duration: duration,
    isDismissible: isDismissible,
    dismissDirection: dismissDirection,
    showProgressIndicator: showProgressIndicator,
    progressIndicatorController: progressIndicatorController,
    progressIndicatorBackgroundColor: progressIndicatorBackgroundColor,
    progressIndicatorValueColor: progressIndicatorValueColor,
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
    flushbarRoute: flushbarRoute,
  );

  static void toastCustom({
    required BuildContext context,
    required String message,
    required IconData iconData,
    required Color iconColor,
    required Color leftBarColor,
    String? title,
    Color? titleColor,
    double? titleSize,
    Color? messageColor,
    double? messageSize,
    Widget? titleText,
    Widget? messageText,
    bool shouldIconPulse = true,
    double? maxWidth,
    EdgeInsets margin = const EdgeInsets.all(0.0),
    EdgeInsets padding = const EdgeInsets.all(16),
    double? borderRadius,
    TextDirection textDirection = TextDirection.ltr,
    Color? borderColor,
    double borderWidth = 1.0,
    Color backgroundColor = const Color(0xFF303030),
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
    Animation<Color>? progressIndicatorValueColor,
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
    Route? flushbarRoute,
  }) => CustomToasts.custom(
    context: context,
    message: message,
    iconData: iconData,
    iconColor: iconColor,
    leftBarColor: leftBarColor,
    title: title,
    titleColor: titleColor,
    titleSize: titleSize,
    messageColor: messageColor,
    messageSize: messageSize,
    titleText: titleText,
    messageText: messageText,
    shouldIconPulse: shouldIconPulse,
    maxWidth: maxWidth,
    margin: margin,
    padding: padding,
    borderRadius: borderRadius,
    textDirection: textDirection,
    borderColor: borderColor,
    borderWidth: borderWidth,
    backgroundColor: backgroundColor,
    boxShadows: boxShadows,
    backgroundGradient: backgroundGradient,
    mainButton: mainButton,
    onTap: onTap,
    duration: duration,
    isDismissible: isDismissible,
    dismissDirection: dismissDirection,
    showProgressIndicator: showProgressIndicator,
    progressIndicatorController: progressIndicatorController,
    progressIndicatorBackgroundColor: progressIndicatorBackgroundColor,
    progressIndicatorValueColor: progressIndicatorValueColor,
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
    flushbarRoute: flushbarRoute,
  );

  /// A simple copy-to-clipboard widget with text and an icon.
  static Widget copyToClipboard({
    required String text,
    String? successMessage,
    String? prefixText,
  }) {
    return CopyToClipboardWidget(
      text: text,
      successMessage: successMessage ?? "Copied to clipboard!",
      prefixText: prefixText,
    );
  }

  /// A copy-to-clipboard component with a label and an icon button.
  static Widget copyToClipboardWithLabel({
    required String text,
    required IconData icon,
    required String label,
  }) {
    return CopyToClipboardComponent(text: text, icon: icon, label: label);
  }

  /// **Custom Dialogs** - Reusable modal dialog with flexible options
  static Future<void> showDialog({
    required BuildContext context,
    required DialogType type,
    required String message,
    String title = "Information",
    VoidCallback? onProceed,
    VoidCallback? onCancel,
    bool barrierDismissible = true,
    TextStyle? titleStyle,
    TextStyle? messageStyle,
    TextStyle? buttonTextStyle,
  }) async => CustomDialogs.show(
    context: context,
    type: type,
    message: message,
    title: title,
    onProceed: onProceed,
    onCancel: onCancel,
    barrierDismissible: barrierDismissible,
    titleStyle: titleStyle,
    messageStyle: messageStyle,
    buttonTextStyle: buttonTextStyle,
  );

  static Future<void> launchMaps(
    BuildContext context, {
    required void Function(AvailableMap map) onMapTap,
  }) => MapsSheet.show(context: context, onMapTap: onMapTap);

  // loadingoverlay
  static Widget overlayLoading({required bool isBusy, required Widget child}) =>
      LoadingOverlay(isBusy: isBusy, child: child);

  /// **Formats a `DateTime` object to a time string based on the user's 12/24-hour format setting.**
  ///
  /// - **Example (12-hour format)**: `"2:30 PM"`
  /// - **Example (24-hour format)**: `"14:30"`
  ///
  /// ### **Usage**
  /// ```dart
  /// String time = DesignSystem.formatTime(DateTime.now(), context);
  /// print(time); // Output: "3:45 PM" (or "15:45" in 24-hour format)
  /// ```
  ///
  /// **Parameters:**
  /// - `datetime`: The `DateTime` object to format.
  /// - `context`: The `BuildContext` to determine if 24-hour format is used.
  ///
  /// **Returns:** A formatted time string.
  static String formatTime(DateTime datetime, BuildContext context) {
    bool is24HourFormat = MediaQuery.of(context).alwaysUse24HourFormat;
    return is24HourFormat
        ? DateFormat.Hm().format(datetime) // 24-hour format: "14:30"
        : DateFormat.jm().format(datetime); // 12-hour format: "2:30 PM"
  }

  /// **Formats a `DateTime` object to a human-readable date string.**
  ///
  /// - **Example Output**: `"Mar 25, 2025"`
  ///
  /// ### **Usage**
  /// ```dart
  /// String date = DesignSystem.formatDate(DateTime.now());
  /// print(date); // Output: "Mar 25, 2025"
  /// ```
  ///
  /// **Parameters:**
  /// - `dateTime`: The `DateTime` object to format.
  ///
  /// **Returns:** A formatted date string.
  static String formatDate(DateTime dateTime) {
    return DateFormat(
      'MMM dd, yyyy',
    ).format(dateTime); // Example: "Mar 25, 2025"
  }

  /// **Formats a `DateTime` object to a full date-time string (YYYY-MM-DD HH:mm).**
  ///
  /// - **Example Output**: `"2025-03-25 14:30"`
  ///
  /// ### **Usage**
  /// ```dart
  /// String dateTime = DesignSystem.formatDateTime(DateTime.now());
  /// print(dateTime); // Output: "2025-03-25 14:30"
  /// ```
  ///
  /// **Parameters:**
  /// - `dateTime`: The `DateTime` object to format.
  ///
  /// **Returns:** A formatted date-time string.
  static String formatDateTime(DateTime dateTime) {
    return DateFormat(
      'yyyy-MM-dd HH:mm',
    ).format(dateTime); // Example: "2025-03-25 14:30"
  }
}
