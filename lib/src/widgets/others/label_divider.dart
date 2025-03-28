import 'package:flutter/widgets.dart';

class LabeledDividerRenderBox extends RenderBox {
  String label;
  double thickness;
  Color color;
  double spacing;
  TextStyle textStyle;
  late TextPainter textPainter;

  LabeledDividerRenderBox({
    required this.label,
    this.thickness = 2.0,
    this.color = const Color(0xFF888888),
    this.spacing = 8.0,
    TextStyle? textStyle,
  }) : textStyle =
           textStyle ??
           const TextStyle(
             fontSize: 16,
             fontWeight: FontWeight.bold,
             color: Color(0xFF000000),
           ) {
    _updateTextPainter();
  }

  void _updateTextPainter() {
    textPainter = TextPainter(
      text: TextSpan(text: label, style: textStyle),
      textDirection: TextDirection.ltr,
    )..layout();
  }

  @override
  void performLayout() {
    _updateTextPainter();
    final double height =
        textPainter.height > thickness ? textPainter.height : thickness;
    size = Size(constraints.maxWidth, height);
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    final Canvas canvas = context.canvas;
    final double textWidth = textPainter.width;
    final double dividerWidth = (size.width - textWidth - (spacing * 2)) / 2;
    final double centerY = offset.dy + size.height / 2;

    final Paint paint =
        Paint()
          ..color = color
          ..strokeWidth = thickness;

    // Left Divider
    canvas.drawLine(
      Offset(offset.dx, centerY),
      Offset(offset.dx + dividerWidth, centerY),
      paint,
    );

    // Draw Text
    textPainter.paint(
      canvas,
      Offset(offset.dx + dividerWidth + spacing, offset.dy),
    );

    // Right Divider
    canvas.drawLine(
      Offset(offset.dx + dividerWidth + spacing + textWidth + spacing, centerY),
      Offset(offset.dx + size.width, centerY),
      paint,
    );
  }

  @override
  bool hitTestSelf(Offset position) => false;
}

class LabeledDivider extends LeafRenderObjectWidget {
  final String label;
  final double thickness;
  final Color color;
  final double spacing;
  final TextStyle textStyle;

  const LabeledDivider({
    super.key,
    required this.label,
    this.thickness = 2.0,
    this.color = const Color(0xFF888888),
    this.spacing = 8.0,
    this.textStyle = const TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.bold,
      color: Color(0xFF000000),
    ),
  });

  @override
  RenderObject createRenderObject(BuildContext context) {
    return LabeledDividerRenderBox(
      label: label,
      thickness: thickness,
      color: color,
      spacing: spacing,
      textStyle: textStyle,
    );
  }

  @override
  void updateRenderObject(
    BuildContext context,
    LabeledDividerRenderBox renderObject,
  ) {
    if (renderObject.label != label) {
      renderObject.label = label;
      renderObject._updateTextPainter();
    }
    if (renderObject.thickness != thickness) {
      renderObject.thickness = thickness;
      renderObject.markNeedsPaint();
    }
    if (renderObject.color != color) {
      renderObject.color = color;
      renderObject.markNeedsPaint();
    }
    if (renderObject.spacing != spacing) {
      renderObject.spacing = spacing;
      renderObject.markNeedsLayout();
    }
    if (renderObject.textStyle != textStyle) {
      renderObject.textStyle = textStyle;
      renderObject._updateTextPainter();
      renderObject.markNeedsLayout();
    }
  }
}
