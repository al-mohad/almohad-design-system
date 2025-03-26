import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class ChatMessageText extends StatelessWidget {
  final String text;
  final Function(String)? onHashtagTapped;
  final Function(String)? onTagTapped;
  final Function(String)? onUrlTapped;
  final TextStyle? textStyle;

  const ChatMessageText({
    super.key,
    required this.text,
    this.onHashtagTapped,
    this.onTagTapped,
    this.onUrlTapped,
    this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    final RegExp regex = RegExp(r'(#[\w]+|@[\w]+|https?://[^\s]+|\b\d+\b)');
    final List<TextSpan> spans = [];

    text.splitMapJoin(
      regex,
      onMatch: (Match match) {
        final String matchText = match.group(0)!;

        spans.add(
          TextSpan(
            text: matchText,
            style: _getStyle(matchText),
            recognizer: _getRecognizer(matchText),
          ),
        );
        return matchText;
      },
      onNonMatch: (String nonMatch) {
        spans.add(TextSpan(text: nonMatch, style: textStyle));
        return nonMatch;
      },
    );

    return RichText(
      text: TextSpan(
        style: textStyle ?? Theme.of(context).textTheme.bodyMedium,
        children: spans,
      ),
    );
  }

  /// Determines the appropriate text style based on the content type
  TextStyle _getStyle(String text) {
    if (text.startsWith('#')) {
      return textStyle?.copyWith(
            color: Colors.blue,
            fontWeight: FontWeight.bold,
          ) ??
          const TextStyle(color: Colors.blue, fontWeight: FontWeight.bold);
    } else if (text.startsWith('@')) {
      return textStyle?.copyWith(
            color: Colors.purple,
            fontWeight: FontWeight.bold,
          ) ??
          const TextStyle(color: Colors.purple, fontWeight: FontWeight.bold);
    } else if (Uri.tryParse(text)?.hasAbsolutePath ?? false) {
      return textStyle?.copyWith(
            color: Colors.blue,
            decoration: TextDecoration.underline,
          ) ??
          const TextStyle(
            color: Colors.blue,
            decoration: TextDecoration.underline,
          );
    } else {
      return textStyle ?? const TextStyle(color: Colors.black);
    }
  }

  /// Determines the appropriate tap action based on content type
  GestureRecognizer? _getRecognizer(String text) {
    if (text.startsWith('#')) {
      return (onHashtagTapped != null)
          ? (TapGestureRecognizer()..onTap = () => onHashtagTapped!(text))
          : null;
    } else if (text.startsWith('@')) {
      return (onTagTapped != null)
          ? (TapGestureRecognizer()..onTap = () => onTagTapped!(text))
          : null;
    } else if (Uri.tryParse(text)?.hasAbsolutePath ?? false) {
      return (onUrlTapped != null)
          ? (TapGestureRecognizer()..onTap = () => onUrlTapped!(text))
          : null;
    }
    return null;
  }
}
