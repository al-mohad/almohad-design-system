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
    final RegExp regex = RegExp(r'(#\w+|@\w+|https?://\S+|\b\d+\b)');
    final List<TextSpan> spans = [];

    text.splitMapJoin(
      regex,
      onMatch: (Match match) {
        String matchText = match.group(0)!;
        if (matchText.startsWith('#')) {
          spans.add(
            TextSpan(
              text: matchText,
              style:
                  textStyle ??
                  TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
              recognizer:
                  TapGestureRecognizer()
                    ..onTap = () => onHashtagTapped?.call(matchText),
            ),
          );
        } else if (matchText.startsWith('@')) {
          spans.add(
            TextSpan(
              text: matchText,
              style:
                  textStyle ??
                  TextStyle(color: Colors.purple, fontWeight: FontWeight.bold),
              recognizer:
                  TapGestureRecognizer()
                    ..onTap = () => onTagTapped?.call(matchText),
            ),
          );
        } else if (Uri.tryParse(matchText)?.hasAbsolutePath ?? false) {
          spans.add(
            TextSpan(
              text: matchText,
              style:
                  textStyle ??
                  TextStyle(
                    color: Colors.blue,
                    decoration: TextDecoration.underline,
                  ),
              recognizer:
                  TapGestureRecognizer()
                    ..onTap = () => onUrlTapped?.call(matchText),
            ),
          );
        } else {
          spans.add(
            TextSpan(
              text: matchText,
              style:
                  textStyle ??
                  TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
            ),
          );
        }
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
}
