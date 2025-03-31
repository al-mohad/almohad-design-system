import 'package:almohad_design_system/almohad_design_system.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

@immutable
class RichTextWidget extends StatelessWidget {
  final TextStyle? styleForAll;
  final Iterable<BaseText> texts;
  final TextAlign textAlign;
  final TextOverflow overflow;
  final int? maxLines;
  final bool selectable;

  const RichTextWidget({
    super.key,
    required this.texts,
    this.styleForAll,
    this.textAlign = TextAlign.start,
    this.overflow = TextOverflow.clip,
    this.maxLines,
    this.selectable = false,
  });

  @override
  Widget build(BuildContext context) {
    final textSpan = TextSpan(children: texts.map(_buildTextSpan).toList());

    return selectable
        ? SelectableText.rich(
          textSpan,
          textAlign: textAlign,
          maxLines: maxLines,
        )
        : RichText(
          text: textSpan,
          textAlign: textAlign,
          overflow: overflow,
          maxLines: maxLines,
        );
  }

  TextSpan _buildTextSpan(BaseText baseText) {
    final mergedStyle = (styleForAll ?? const TextStyle()).merge(
      baseText.style,
    );

    if (baseText is LinkText) {
      return TextSpan(
        text: baseText.text,
        style: mergedStyle,
        recognizer: (TapGestureRecognizer()..onTap = baseText.onTapped),
      );
    }

    return TextSpan(text: baseText.text, style: mergedStyle);
  }
}
