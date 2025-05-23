import 'package:almohad_design_system/src/utils/dialogs.dart';
import 'package:almohad_design_system/src/utils/logger.dart';
import 'package:almohad_design_system/src/utils/map_luancher.dart';
import 'package:almohad_design_system/src/utils/regex.dart';
import 'package:almohad_design_system/src/utils/toast/toast_provider.dart'
    as tp;
import 'package:almohad_design_system/src/widgets/animations/animated_switcher.dart';
import 'package:almohad_design_system/src/widgets/audio_message/audio_message.dart';
import 'package:almohad_design_system/src/widgets/effects/fading_scroll.dart';
import 'package:almohad_design_system/src/widgets/inputs/tag_input.dart';
import 'package:almohad_design_system/src/widgets/layouts/loading_overlay.dart';
import 'package:almohad_design_system/src/widgets/morphisms/cyber_punk.dart';
import 'package:almohad_design_system/src/widgets/morphisms/depth.dart';
import 'package:almohad_design_system/src/widgets/morphisms/isometric.dart';
import 'package:almohad_design_system/src/widgets/morphisms/retro_futurism.dart';
import 'package:almohad_design_system/src/widgets/morphisms/skeuomorphism.dart';
import 'package:almohad_design_system/src/widgets/others/label_divider.dart';
import 'package:almohad_design_system/src/widgets/sliders/animated_slider.dart';
import 'package:almohad_design_system/src/widgets/sliders/smooth_slider.dart';
import 'package:almohad_design_system/src/widgets/texts/transformative_text.dart';
import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart' show DateFormat;
import 'package:lottie/lottie.dart';
import 'package:map_launcher/map_launcher.dart';

import 'src/src.dart';
import 'src/utils/color_strength.dart';
import 'src/utils/copy_to_clipboard.dart';
import 'src/widgets/container/custom_container.dart';
import 'src/widgets/lottie/lottie_viewer.dart';
import 'src/widgets/others/parallax_image.dart';
import 'src/widgets/texts/rich_text_widget.dart';

export 'src/src.dart';

/// **DesignSystem** - A centralized class for reusable UI components
class DesignSystem {
  DesignSystem._(); // Prevent instantiation
  /// A chat bubble widget with different styles.
  ///
  /// **Parameters:**
  /// - `message`: The chat message object.
  /// - `isSender`: True if the current user sent the message.
  /// - `showAvatar`: Whether to display the avatar (default true).
  /// - `onHashtagTapped`, `onTagTapped`, `onUrlTapped`: Callbacks for interactive text.
  /// - `bubbleColor`, `textColor`, `timestampColor`: Custom colors.
  /// - `avatarBackgroundColor`, `avatarRadius`: Avatar customization.
  /// - `bubblePadding`, `chatPadding`: Padding around the bubble and overall widget.
  /// - `bubbleRadius`: Custom border radius for the bubble.
  /// - `messageTextStyle`, `timeTextStyle`, `usernameTextStyle`: Custom text styles.
  /// - `type`: The chat widget type (text, image, or audio).
  /// - `onImagePreview`: Callback when an image thumbnail is tapped.
  /// - `viewType`: How to display image messages (grid or list).
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
    // ImageViewType? viewType,
    Color? textColor,
    Color? timestampColor,
    Color? avatarBackgroundColor,
    double? avatarRadius,
    EdgeInsets? bubblePadding,
    EdgeInsets? chatPadding,
    BorderRadius? bubbleRadius,
    TextStyle? usernameTextStyle,
    double? listImageHeight,
    double? imageThumbnailHeight,
  }) {
    return ChatWidget(
      message: message,
      isSender: isSender,
      showAvatar: showAvatar,
      onHashtagTapped: onHashtagTapped,
      onTagTapped: onTagTapped,
      onUrlTapped: onUrlTapped,
      bubbleColor: bubbleColor,
      messageTextStyle: messageTextStyle,
      timeTextStyle: timeTextStyle,
      chatWidgetType: type,
      onImagePreview: onImagePreview,
      // listImageHeight: listImageHeight,
      // imageThumbnailHeight: imageThumbnailHeight,
      // imageViewType: viewType,
      textColor: textColor,
      timestampColor: timestampColor,
      avatarBackgroundColor: avatarBackgroundColor,
      avatarRadius: avatarRadius,
      bubblePadding: bubblePadding,
      chatPadding: chatPadding,
      bubbleRadius: bubbleRadius,
      usernameTextStyle: usernameTextStyle,
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

  static Widget chatInput({required TextEditingController textController}) {
    return CustomChatInput(textEditingController: textController);
  }

  /// A customizable text field widget supporting multiple input types.
  ///
  /// This widget adapts based on the `fieldType` to provide tailored input behavior.
  /// It supports various input types, including standard text input, passwords with toggle visibility,
  /// multi-line text, numbers, email, URLs, search, and even date/time pickers.
  ///
  /// The `CustomTextFieldType` enum determines the input type:
  /// - `text`: Standard single-line text input.
  /// - `multiText`: Multi-line text field.
  /// - `password`: Secure password input with toggle visibility.
  /// - `email`: Email input with an appropriate keyboard type.
  /// - `phone`: Numeric phone input.
  /// - `number`: Integer-only input.
  /// - `decimal`: Decimal number input.
  /// - `url`: URL input with the correct keyboard type.
  /// - `search`: Text input with a search icon and submission action.
  /// - `date`: Opens a date picker when tapped.
  /// - `time`: Opens a time picker when tapped.
  ///
  /// ### Example Usage:
  /// #### Standard Email Field:
  /// ```dart
  /// textField(
  ///   label: "Email",
  ///   fieldType: CustomTextFieldType.email,
  ///   prefixIcon: Icons.email,
  /// )
  /// ```
  ///
  /// #### Password Field with Toggle Visibility:
  /// ```dart
  /// textField(
  ///   label: "Password",
  ///   fieldType: CustomTextFieldType.password,
  ///   prefixIcon: Icons.lock,
  ///   suffixIcon: Icons.visibility,
  ///   onSuffixIconTap: () {
  ///     // Toggle password visibility logic
  ///   },
  /// )
  /// ```
  ///
  static Widget textField({
    /// The label displayed above the text field.
    required String label,

    /// The hint text displayed inside the text field.
    String? hintText,

    /// The controller used to manage the text field’s value.
    TextEditingController? controller,

    /// The type of the text field, which determines its behavior.
    ///
    /// Defaults to `CustomTextFieldType.text`.
    CustomTextFieldType fieldType = CustomTextFieldType.text,

    /// Whether the text should be obscured (typically used for passwords).
    ///
    /// Defaults to `false`. If `fieldType` is `CustomTextFieldType.password`,
    /// this will automatically be `true`.
    bool obscureText = false,

    /// The character used to obscure text in password fields.
    ///
    /// Defaults to '●'.
    String obscuringCharacter = '●',

    /// The icon displayed at the start of the text field.
    Widget? prefixIcon,

    /// The icon displayed at the end of the text field.
    ///
    /// Typically used for password visibility toggles or search actions.
    Widget? suffixIcon,

    /// Callback function triggered when the suffix icon is tapped.
    ///
    /// Useful for toggling password visibility or clearing search input.
    VoidCallback? onSuffixIconTap,

    /// Function for validating the text field’s input.
    ///
    /// It returns an error message string if validation fails, otherwise `null`.
    String? Function(String?)? validator,

    /// Callback function triggered when the text changes.
    ///
    /// It provides the current input value as a parameter.
    void Function(String)? onChanged,

    /// The text style for the input text.
    ///
    /// Defaults to the theme's body text style if not provided.
    TextStyle? textStyle,

    /// The border color of the text field when it is not focused.
    ///
    /// If not provided, it defaults to the primary color from the theme.
    Color? borderColor,

    /// The border color when the text field is focused.
    ///
    /// If not provided, it defaults to the secondary color from the theme.
    Color? focusedBorderColor,

    /// The border radius of the text field.
    ///
    /// Defaults to `12.0` for rounded corners.
    double borderRadius = 12,

    /// Padding around the text field.
    ///
    /// Defaults to `EdgeInsets.symmetric(horizontal: 16, vertical: 8)`.
    EdgeInsets padding = const EdgeInsets.symmetric(
      horizontal: 16,
      vertical: 8,
    ),

    /// The maximum number of characters allowed in the text field.
    ///
    /// If `null`, there is no limit.
    int? maxLength,

    /// The maximum number of lines allowed in the text field.
    ///
    /// If `fieldType` is `CustomTextFieldType.multiText`, this will default to unlimited lines.
    int? maxLines,
    bool? enableVibration,
    bool? enableShake,
  }) {
    return CustomTextField(
      label: label,
      hintText: hintText,
      controller: controller,
      fieldType: fieldType,
      maxLength: maxLength,
      maxLines: maxLines,
      obscureText: fieldType == CustomTextFieldType.password || obscureText,
      obscuringCharacter: obscuringCharacter,
      prefixIcon: prefixIcon,
      suffixIcon: suffixIcon,
      onSuffixIconTap: onSuffixIconTap,
      validator: validator,
      onChanged: onChanged,
      textStyle: textStyle ?? const TextStyle(),
      borderColor: borderColor,
      focusedBorderColor: focusedBorderColor,
      borderRadius: borderRadius,
      padding: padding,
      enableShake: enableShake ?? false,
      enableVibration: enableVibration ?? false,
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
    double? strokeWidth,
    double? blurRadius,
    double? spreadRadius,
    List<double>? dashPattern,
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
      strokeWidth: strokeWidth,
      blurRadius: blurRadius,
      spreadRadius: spreadRadius,
      dashPattern: dashPattern,
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
  static Widget glass({
    required Widget child,
    double? blur,
    double? opacity,
    Color? borderColor,
    double? borderRadius,
    double? borderWidth,
  }) => Glassmorphism(
    blur: blur,
    opacity: opacity,
    borderColor: borderColor,
    borderRadius: borderRadius,
    borderWidth: borderWidth,
    child: child,
  );

  /// A glass claymorphic widget
  static Widget claymorphism({
    required Widget child,
    double depth = 10.0,
    Color color = Colors.grey,
    double borderRadius = 20.0,
    double blurRadius = 10.0,
    double offsetX = 5.0,
    double offsetY = 5.0,
    Color? shadowColor,
    Gradient? gradient,
  }) {
    return Claymorphism(
      depth: depth,
      color: color,
      borderRadius: borderRadius,
      blurRadius: blurRadius,
      offsetX: offsetX,
      offsetY: offsetY,
      shadowColor: shadowColor,
      gradient: gradient,
      child: child,
    );
  }

  /// A glass neumorphic widget
  static Widget neumorphism({
    required Widget child,
    double depth = 10.0,
    Color color = Colors.grey,
    double borderRadius = 20.0,
    Color shadowColor = Colors.black,
    Color highlightColor = Colors.white,
    double blurRadius = 10.0,
    double offsetX = 5.0,
    double offsetY = 5.0,
    Gradient? gradient,
  }) {
    return Neumorphism(
      depth: depth,
      color: color,
      borderRadius: borderRadius,
      shadowColor: shadowColor,
      highlightColor: highlightColor,
      blurRadius: blurRadius,
      offsetX: offsetX,
      offsetY: offsetY,
      gradient: gradient,
      child: child,
    );
  }

  /// A static method to easily create a Cyberpunk-style widget
  ///
  /// The `cyberpunk` method provides a simplified way to wrap any child widget with
  /// a cyberpunk-themed container, with customizable gradient, shadows, and more.
  ///
  /// [borderRadius] controls the border radius of the container.
  /// [gradientColors] defines the start and end colors of the gradient.
  /// [boxShadow] adds a shadow effect to the widget.
  /// [gradientBegin] and [gradientEnd] set the direction of the gradient.
  static Widget cyberpunk({
    required Widget child,
    double borderRadius = 15.0,
    List<Color> gradientColors = const [Colors.pinkAccent, Colors.blueAccent],
    BoxShadow boxShadow = const BoxShadow(
      color: Colors.blueAccent,
      offset: Offset(0, 4),
      blurRadius: 10,
    ),
    AlignmentGeometry gradientBegin = Alignment.topLeft,
    AlignmentGeometry gradientEnd = Alignment.bottomRight,
  }) => Cyberpunk(
    borderRadius: borderRadius,
    gradientColors: gradientColors,
    boxShadow: boxShadow,
    gradientBegin: gradientBegin,
    gradientEnd: gradientEnd,
    child: child,
  );

  static Widget depth({
    required Widget child,
    double depth = 15.0,
    Color color = Colors.white,
    double borderRadius = 25.0,
    Color shadowColor = const Color(0x33000000),
    Color highlightColor = const Color(0x99FFFFFF),
    double offsetX = 5.0,
    double offsetY = 5.0,
    double blurRadius = 15.0,
  }) {
    return Depth(
      depth: depth,
      color: color,
      borderRadius: borderRadius,
      shadowColor: shadowColor,
      highlightColor: highlightColor,
      offsetX: offsetX,
      offsetY: offsetY,
      blurRadius: blurRadius,
      child: child,
    );
  }

  static Widget isometric({
    required Widget child,
    double rotationX = 0.2,
    double rotationY = 0.2,
    Color color = Colors.blue,
    double borderRadius = 15.0,
    List<BoxShadow> boxShadow = const [
      BoxShadow(color: Colors.black26, offset: Offset(5, 5), blurRadius: 10),
    ],
  }) {
    return Isometric(
      rotationX: rotationX,
      rotationY: rotationY,
      color: color,
      borderRadius: borderRadius,
      boxShadow: boxShadow,
      child: child,
    );
  }

  static Widget retroFuturism({
    required Widget child,
    double borderRadius = 20.0,
    List<Color> gradientColors = const [Colors.yellowAccent, Colors.purple],
    BoxShadow boxShadow = const BoxShadow(
      color: Colors.pinkAccent,
      offset: Offset(5, 5),
      blurRadius: 15,
    ),
    AlignmentGeometry gradientBegin = Alignment.topLeft,
    AlignmentGeometry gradientEnd = Alignment.bottomRight,
    double blurRadius = 15.0,
    double offsetX = 5.0,
    double offsetY = 5.0,
  }) {
    return RetroFuturism(
      borderRadius: borderRadius,
      gradientColors: gradientColors,
      boxShadow: boxShadow,
      gradientBegin: gradientBegin,
      gradientEnd: gradientEnd,
      blurRadius: blurRadius,
      offsetX: offsetX,
      offsetY: offsetY,
      child: child,
    );
  }

  static Widget skeuomorphism({
    required Widget child,
    double borderRadius = 15.0,
    BoxShadow boxShadow = const BoxShadow(
      color: Colors.black,
      offset: Offset(10, 10),
      blurRadius: 10,
    ),
    required String textureAsset,
    double shadowOpacity = 0.5,
    double offsetX = 10.0,
    double offsetY = 10.0,
    double blurRadius = 10.0,
  }) => Skeuomorphis(
    borderRadius: borderRadius,
    boxShadow: boxShadow,
    textureAsset: textureAsset,
    shadowOpacity: shadowOpacity,
    offsetX: offsetX,
    offsetY: offsetY,
    blurRadius: blurRadius,
    child: child,
  );

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
    String? errorImagePath = 'https://i.pravatar.cc',
    double? size = 24,
    AvatarType? type = AvatarType.rounded,
    bool isAsset = false,
  }) => CustomAvatar(
    imageUrl: imagePath,
    size: size,
    avatarType: type,
    isAsset: isAsset,
    errorImage: errorImagePath,
  );

  static Future<void> loader(
    BuildContext context, {
    String? lottiePath,
  }) async => await customLoader(context, lottie: lottiePath);

  /// Wraps the given [child] widget inside a [toastProvider].
  ///
  /// This ensures that the global context for displaying toasts is always available,
  /// eliminating the need for `navigatorKey`.
  ///
  /// ### Usage Example:
  /// ```dart
  /// void main() {
  ///   runApp(DesignSystem.toastProvider(child: MyApp()));
  /// }
  /// ```
  ///
  /// Now, `DesignSystem.toast(...)` can be used anywhere in the app.
  static Widget toastProvider({required Widget child}) =>
      tp.ToastProvider(child: child);

  static void toast({
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

  static Color strengthenColor({
    required Color color,
    required double factor,
  }) => getStrengthenColor(color: color, factor: factor);

  static Color randomColor({double opacity = 1.0}) =>
      getRandomColor(opacity: opacity);

  static Widget labelDivider({
    required String label,
    double? thickness,
    Color? color,
    double? spacing,
    TextStyle? textStyle,
  }) => LabeledDivider(
    label: label,
    textStyle:
        textStyle ??
        const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Color(0xFF000000),
        ),
    thickness: thickness ?? 2.0,
    spacing: spacing ?? 8.0,
    color: color ?? const Color(0xFF888888),
  );

  /// Creates a customizable Tag Input Field widget.
  ///
  /// This widget allows users to input multiple tags, with options to customize
  /// colors, height, hint text, and text styling. Tags can be dynamically added
  /// and removed.
  ///
  /// - [suggestions]: A list of suggested tags for auto-completion.
  /// - [onTagsChanged]: A callback function triggered when tags are added or removed.
  /// - [tagColor]: Background color of the tag chips. Default is `Colors.blue`.
  /// - [textColor]: Text color inside the tag chips. Default is `Colors.white`.
  /// - [borderColor]: Border color for the tag chips. Default is `Colors.grey`.
  /// - [hintText]: Placeholder text shown inside the input field. Default is `"Enter tags"`.
  /// - [height]: Height of the tag display area. Default is `60.0`.
  /// - [textStyle]: Custom text style for the tag text. Default is `TextStyle(fontSize: 14)`.
  ///
  /// Example:
  /// ```dart
  /// TagInputField.tagInput(
  ///   suggestions: ["Flutter", "Dart", "UI"],
  ///   onTagsChanged: (tags) => print(tags),
  ///   tagColor: Colors.green,
  ///   textColor: Colors.black,
  ///   borderColor: Colors.greenAccent,
  ///   hintText: "Add a tag...",
  ///   height: 80.0,
  ///   textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
  /// )
  /// ```
  static Widget tagInput({
    required List<String> suggestions,
    required Function(List<String>) onTagsChanged,
    Color tagColor = Colors.blue,
    Color textColor = Colors.white,
    Color borderColor = Colors.grey,
    String hintText = "Enter tags",
    double height = 60.0,
    TextStyle textStyle = const TextStyle(fontSize: 14),
  }) => TagInputField(
    suggestions: suggestions,
    onTagsChanged: onTagsChanged,
    tagColor: tagColor,
    textColor: textColor,
    borderColor: borderColor,
    height: height,
    hintText: hintText,
    textStyle: textStyle,
  );

  /// A wrapper around `AnimatedSwitcherWrapper` for smooth transitions.
  /// Returns an `AnimatedSwitcherWrapper` to smoothly transition between widgets.
  ///
  /// - [child]: The widget to animate when it changes.
  /// - [duration]: Duration of the animation (default: `Durations.medium4`).
  static Widget animatedSwitcher({
    required Widget child,
    Duration duration = Durations.medium4,
  }) => AnimatedSwitcherWrapper(duration: duration, child: child);

  static get regx => RegexPatterns.regx;

  static void log({
    required String text,
    LogType type = LogType.debug,
    Object? metadata,
  }) => AppLogger(text, type: type, metadata: metadata);

  static Widget actionButton({
    ButtonVariant variant = ButtonVariant.defaultStyle,
    Color primaryColor = Colors.blue,
    Color darkPrimaryColor = Colors.blueAccent,
    String idleText = "Start",
    String busyText = "Processing...",
    String doneText = "Completed!",
    IconData idleIcon = Icons.play_arrow,
    IconData busyIcon = Icons.sync,
    IconData doneIcon = Icons.check_circle,
    double width = 200.0,
    double height = 50.0,
    Duration animationDuration = const Duration(seconds: 2),
  }) => ActionButton(
    variant: variant,
    primaryColor: primaryColor,
    darkPrimaryColor: darkPrimaryColor,
    idleText: idleText,
    busyText: busyText,
    doneText: doneText,
    idleIcon: idleIcon,
    busyIcon: busyIcon,
    doneIcon: doneIcon,
    width: width,
    height: height,
    animationDuration: animationDuration,
  );

  static Widget richTexts({
    required Iterable<BaseText> texts,
    TextStyle? styleForAll,
    bool selectable = false,
    int? maxLines,
    TextOverflow overflow = TextOverflow.clip,
    TextAlign textAlign = TextAlign.left,
  }) => RichTextWidget(
    texts: texts,
    styleForAll: styleForAll,
    selectable: selectable,
    maxLines: maxLines,
    overflow: overflow,
    textAlign: textAlign,
  );

  static Widget animatedToggle({
    required List<String> values,
    required void Function(int, String) onToggle,
    List<IconData>? icons,
    Duration animationDuration = const Duration(milliseconds: 300),
    Curve animationCurve = Curves.easeInOut,
    Color activeColor = Colors.black,
    Color inactiveColor = Colors.white,
    Color activeTextColor = Colors.white,
    Color inactiveTextColor = Colors.black,
    Color backgroundColor = Colors.grey,
    TextStyle textStyle = const TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.bold,
    ),
    double width = 200,
    double height = 60,
    EdgeInsets padding = const EdgeInsets.symmetric(
      horizontal: 10,
      vertical: 5,
    ),
    EdgeInsets margin = const EdgeInsets.all(0),
    BorderRadius borderRadius = const BorderRadius.all(Radius.circular(30)),
    bool showShadow = true,
  }) {
    return AnimatedToggleSwitch(
      values: values,
      icons: icons,
      onToggle: onToggle,
      animationDuration: animationDuration,
      animationCurve: animationCurve,
      activeColor: activeColor,
      inactiveColor: inactiveColor,
      activeTextColor: activeTextColor,
      inactiveTextColor: inactiveTextColor,
      backgroundColor: backgroundColor,
      textStyle: textStyle,
      width: width,
      height: height,
      padding: padding,
      margin: margin,
      borderRadius: borderRadius,
      showShadow: showShadow,
    );
  }

  static Widget transformingToggle({
    required List<String> primaryValues,
    required List<String> secondaryValues,
    required void Function(int, String) onPrimaryToggle,
    required void Function(int, String) onSecondaryToggle,
    Duration animationDuration = const Duration(milliseconds: 300),
    Curve animationCurve = Curves.easeInOut,
    Color activeColor = Colors.black,
    Color inactiveColor = Colors.white,
    Color activeTextColor = Colors.white,
    Color inactiveTextColor = Colors.black,
    Color backgroundColor = Colors.grey,
    TextStyle textStyle = const TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.bold,
    ),
    double width = 250,
    double height = 60,
    EdgeInsets padding = const EdgeInsets.symmetric(
      horizontal: 10,
      vertical: 5,
    ),
    EdgeInsets margin = const EdgeInsets.all(0),
    BorderRadius borderRadius = const BorderRadius.all(Radius.circular(30)),
    bool showShadow = true,
  }) {
    return TransformingAnimatedToggleSwitch(
      primaryValues: primaryValues,
      secondaryValues: secondaryValues,
      onPrimaryToggle: onPrimaryToggle,
      onSecondaryToggle: onSecondaryToggle,
      animationDuration: animationDuration,
      animationCurve: animationCurve,
      activeColor: activeColor,
      inactiveColor: inactiveColor,
      activeTextColor: activeTextColor,
      inactiveTextColor: inactiveTextColor,
      backgroundColor: backgroundColor,
      textStyle: textStyle,
      width: width,
      height: height,
      padding: padding,
      margin: margin,
      borderRadius: borderRadius,
      showShadow: showShadow,
    );
  }

  static Widget transformativeText({
    required String text,
    TextStyle? style,
    TransformType? type,
    bool? repeat,
  }) => TransformText(
    text: text,
    transformType: type ?? TransformType.glitch,
    style: style,
    repeat: repeat ?? true,
  );

  static Widget animatedSlider({
    required double value,
    required Color barColor,
    required Color rightFillColor,
    required Color leftFillColor,
    required double height,
    required double barWidth,
    BorderRadius? cornerRadius,
    required TextStyle labelStyle,
    void Function(double value)? onChange,
  }) => AnimatedSlider(
    value: value,
    barColor: barColor,
    labelStyle: labelStyle,
    cornerRadius: cornerRadius,
    rightFillColor: rightFillColor,
    leftFillColor: leftFillColor,
    height: height,
    barWidth: barWidth,
  );

  static Widget fadingScroll({
    required Widget Function(BuildContext, ScrollController) builder,
    ScrollController? controller,
    double? startFadingSize,
    double? endFadingSize,
    double? fadingSize,
    double? startScrollExtent,
    double? endScrollExtent,
    double? scrollExtent,
    Duration? transitionDuration,
  }) => FadingScroll(
    builder: builder,
    controller: controller,
    startFadingSize: startFadingSize,
    endFadingSize: endFadingSize,
    fadingSize: fadingSize,
    startScrollExtent: startScrollExtent,
    endScrollExtent: endScrollExtent,
    scrollExtent: scrollExtent,
    transitionDuration: transitionDuration,
  );

  static Widget smoothSlider({
    double range = 8.0,
    required Icon buttonIcon,
    double buttonBorderRadius = 90,
    Color buttonColor = Colors.blue,
    double buttonSize = 50,
    required Widget barText,
    double barHeight = 45,
    Color barColor = Colors.black12,
    double barBorderRadius = 90,
    required Widget progressText,
    Color progressColor = Colors.amber,
    required void Function() onSuccess,
    void Function()? onFailed,
  }) => SmoothSlider(
    buttonIcon: buttonIcon,
    barText: barText,
    progressText: progressText,
    onSuccess: onSuccess,
  );

  /// A static helper method to easily create a [LottieViewer] with common properties.
  static Widget lottieViewer({
    required String lottiePath,
    bool? repeat,
    bool? reverse,
    bool? applyColor,
    String? text,
    TextStyle? textStyle,
    double? height,
    double? width,
    BoxFit? fit,
    double? speed,
    Animation<double>? controller,
    void Function(LottieComposition)? onLoaded,
    LottieDelegates? delegates,
    AlignmentGeometry? alignment,
    EdgeInsetsGeometry? textPadding,
    MainAxisAlignment? mainAxisAlignment,
    CrossAxisAlignment? crossAxisAlignment,
    LottieType type = LottieType.asset,
  }) => LottieViewer(
    path: lottiePath,
    type: type,
    repeat: repeat,
    reverse: reverse,
    applyColor: applyColor,
    text: text,
    textStyle: textStyle,
    height: height,
    width: width,
    fit: fit,
    speed: speed,
    controller: controller,
    onLoaded: onLoaded,
    delegates: delegates,
    alignment: alignment,
    textPadding: textPadding,
    mainAxisAlignment: mainAxisAlignment,
    crossAxisAlignment: crossAxisAlignment,
  );
}
