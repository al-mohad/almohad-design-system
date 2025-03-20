import 'package:almohad_design_system/src/widgets/audio_message/audio_message.dart';
import 'package:flutter/material.dart';

import 'src/src.dart';
import 'src/widgets/container/custom_container.dart';
import 'src/widgets/others/parallax_image.dart';
import 'src/widgets/texts/text_form_field.dart';

export 'src/src.dart';

class DesignSystem {
  /// A chat bubble widget with different styles
  static Widget chatBubble({
    required ChatMessage message,
    required bool isSender,
  }) {
    return ChatWidget(message: message, isSender: isSender);
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
    double elevation = 10,
    bool isDarkMode = false,
  }) {
    return CustomContainer(
      style: style,
      borderRadius: borderRadius,
      color: color,
      padding: padding,
      elevation: elevation,
      isDarkMode: isDarkMode,
      child: child,
    );
  }

  /// A nil widget that does nothing
  static Widget nil = const Nil();

  /// A live date-time provider widget
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
    return LocationWidget(
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
}
