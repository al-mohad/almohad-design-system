import 'package:flutter/foundation.dart' show immutable, VoidCallback;
import 'package:flutter/material.dart' show TextStyle, Colors, TextDecoration;

@immutable
class BaseText {
  final String text;
  final TextStyle? style;

  const BaseText({required this.text, this.style});

  factory BaseText.plain({
    required String text,
    TextStyle? style = const TextStyle(),
  }) {
    return BaseText(text: text, style: style);
  }
  factory BaseText.link({
    required String text,
    required VoidCallback onTapped,
    TextStyle? style = const TextStyle(
      color: Colors.blue,
      decoration: TextDecoration.underline,
    ),
  }) {
    return LinkText(text: text, style: style, onTapped: onTapped);
  }
}

@immutable
class LinkText extends BaseText {
  final VoidCallback onTapped;
  const LinkText({required super.text, super.style, required this.onTapped});
}
