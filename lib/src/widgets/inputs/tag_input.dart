import 'package:flutter/material.dart';

class TagInputField extends StatefulWidget {
  final List<String> suggestions;
  final Function(List<String>) onTagsChanged;
  final Color tagColor;
  final Color textColor;
  final Color borderColor;
  final double height;
  final String hintText;
  final TextStyle textStyle;

  const TagInputField({
    super.key,
    required this.suggestions,
    required this.onTagsChanged,
    this.tagColor = Colors.blue,
    this.textColor = Colors.white,
    this.borderColor = Colors.grey,
    this.height = 60.0,
    this.hintText = "Enter tags...",
    this.textStyle = const TextStyle(fontSize: 14),
  });

  @override
  TagInputFieldState createState() => TagInputFieldState();
}

class TagInputFieldState extends State<TagInputField> {
  final TextEditingController _controller = TextEditingController();
  final List<String> _tags = [];

  void _addTag(String tag) {
    if (tag.isNotEmpty && !_tags.contains(tag)) {
      setState(() {
        _tags.add(tag);
        _controller.clear();
      });
      widget.onTagsChanged(_tags);
    }
  }

  void _removeTag(String tag) {
    setState(() {
      _tags.remove(tag);
    });
    widget.onTagsChanged(_tags);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomPaint(
          painter: TagRenderBox(
            tags: _tags,
            onRemove: _removeTag,
            tagColor: widget.tagColor,
            textColor: widget.textColor,
            borderColor: widget.borderColor,
          ),
          child: Container(height: widget.height),
        ),
        TextField(
          controller: _controller,
          style: widget.textStyle,
          decoration: InputDecoration(
            hintText: widget.hintText,
            hintStyle: widget.textStyle,
            labelStyle: widget.textStyle,
            suffixIcon: IconButton(
              icon: const Icon(Icons.add),
              onPressed: () => _addTag(_controller.text.trim()),
            ),
          ),
          onSubmitted: (value) => _addTag(value.trim()),
        ),
      ],
    );
  }
}

class TagRenderBox extends CustomPainter {
  final List<String> tags;
  final Function(String) onRemove;
  final Color tagColor;
  final Color textColor;
  final Color borderColor;

  TagRenderBox({
    required this.tags,
    required this.onRemove,
    required this.tagColor,
    required this.textColor,
    required this.borderColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final Paint tagBackground =
        Paint()..color = tagColor.withValues(alpha: 0.7);
    final Paint borderPaint =
        Paint()
          ..color = borderColor
          ..style = PaintingStyle.stroke
          ..strokeWidth = 1.5;

    final TextPainter textPainter = TextPainter(
      textDirection: TextDirection.ltr,
    );

    double x = 8;
    double y = 8;

    for (var tag in tags) {
      textPainter.text = TextSpan(
        text: tag,
        style: TextStyle(fontSize: 14, color: textColor),
      );
      textPainter.layout();

      final double tagWidth = textPainter.width + 30;
      final double tagHeight = textPainter.height + 12;

      if (x + tagWidth > size.width) {
        x = 8;
        y += tagHeight + 8;
      }

      final Rect tagRect = Rect.fromLTWH(x, y, tagWidth, tagHeight);

      // Draw tag background
      canvas.drawRRect(
        RRect.fromRectAndRadius(tagRect, const Radius.circular(8)),
        tagBackground,
      );

      // Draw tag border
      canvas.drawRRect(
        RRect.fromRectAndRadius(tagRect, const Radius.circular(8)),
        borderPaint,
      );

      // Draw text
      textPainter.paint(canvas, Offset(x + 10, y + 5));

      // Draw "X" button for removing the tag
      final TextPainter removePainter = TextPainter(
        text: TextSpan(
          text: " ×",
          style: TextStyle(
            fontSize: 14,
            color: textColor.withValues(alpha: 0.8),
          ),
        ),
        textDirection: TextDirection.ltr,
      );
      removePainter.layout();
      removePainter.paint(canvas, Offset(x + tagWidth - 18, y + 5));

      x += tagWidth + 8;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
