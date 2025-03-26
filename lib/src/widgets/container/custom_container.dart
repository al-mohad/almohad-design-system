import 'dart:ui' show PathMetric;

import 'package:flutter/material.dart';

import 'style.dart';

class CustomContainer extends StatelessWidget {
  final Widget child;
  final double borderRadius;
  final Color? color;
  final EdgeInsets padding;
  final EdgeInsets margin;
  final double elevation;
  final ContainerStyle style;
  final bool isDarkMode;
  final double? height;
  final double? width;
  final double? strokeWidth;
  final bool isDashed;

  const CustomContainer({
    super.key,
    required this.child,
    this.borderRadius = 12,
    this.color,
    this.height,
    this.width,
    this.padding = const EdgeInsets.all(16),
    this.margin = const EdgeInsets.all(8),
    this.elevation = 10,
    this.style = ContainerStyle.flat,
    this.isDarkMode = false,
    this.strokeWidth = 2,
    this.isDashed = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final defaultColor = color ?? theme.colorScheme.surface;
    final isDark = theme.brightness == Brightness.dark || isDarkMode;

    return CustomPaint(
      painter:
          (style == ContainerStyle.dottedBorder)
              ? DottedBorderPainter(
                borderRadius: borderRadius,
                strokeWidth: strokeWidth!,
                isDashed: isDashed,
              )
              : null,
      child: Container(
        padding: padding,
        margin: margin,
        height: height,
        width: width,
        decoration: _getDecoration(defaultColor, isDark),
        child: child,
      ),
    );
  }

  BoxDecoration _getDecoration(Color defaultColor, bool isDark) {
    switch (style) {
      case ContainerStyle.claymorphism:
        return BoxDecoration(
          color: defaultColor,
          borderRadius: BorderRadius.circular(borderRadius),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.15),
              offset: Offset(6, 6),
              blurRadius: elevation,
            ),
            BoxShadow(
              color: Colors.white.withOpacity(0.5),
              offset: Offset(-6, -6),
              blurRadius: elevation,
            ),
          ],
        );

      case ContainerStyle.glassmorphism:
        return BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadius),
          color: defaultColor.withOpacity(0.15),
          border: Border.all(color: Colors.white.withOpacity(0.3), width: 1),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: elevation,
              spreadRadius: 1,
            ),
          ],
          backgroundBlendMode: BlendMode.overlay,
        );

      case ContainerStyle.neumorphism:
        return BoxDecoration(
          color: defaultColor,
          borderRadius: BorderRadius.circular(borderRadius),
          boxShadow: [
            BoxShadow(
              color: isDark ? Colors.black54 : Colors.grey.shade300,
              offset: Offset(4, 4),
              blurRadius: elevation,
            ),
            BoxShadow(
              color: isDark ? Colors.grey.shade800 : Colors.white,
              offset: Offset(-4, -4),
              blurRadius: elevation,
            ),
          ],
        );

      case ContainerStyle.elevated:
        return BoxDecoration(
          color: defaultColor,
          borderRadius: BorderRadius.circular(borderRadius),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              offset: Offset(0, elevation / 2),
              blurRadius: elevation,
            ),
          ],
        );

      case ContainerStyle.bordered:
        return BoxDecoration(
          color: defaultColor,
          borderRadius: BorderRadius.circular(borderRadius),
          border: Border.all(
            color: Colors.black.withOpacity(0.5),
            width: strokeWidth!,
          ),
        );

      case ContainerStyle.flat:
      case ContainerStyle.dottedBorder:
        return BoxDecoration(
          color: defaultColor,
          borderRadius: BorderRadius.circular(borderRadius),
        );
    }
  }
}

class DottedBorderPainter extends CustomPainter {
  final double borderRadius;
  final double strokeWidth;
  final bool isDashed;

  DottedBorderPainter({
    required this.borderRadius,
    required this.strokeWidth,
    required this.isDashed,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint =
        Paint()
          ..color = Colors.black.withOpacity(0.6)
          ..strokeWidth = strokeWidth
          ..style = PaintingStyle.stroke;

    final Path path =
        Path()..addRRect(
          RRect.fromRectAndRadius(
            Rect.fromLTWH(0, 0, size.width, size.height),
            Radius.circular(borderRadius),
          ),
        );

    if (isDashed) {
      _drawDashedLine(canvas, path, paint);
    } else {
      canvas.drawPath(path, paint);
    }
  }

  void _drawDashedLine(Canvas canvas, Path path, Paint paint) {
    Path dashPath = Path();
    double dashLength = 6;
    double spaceLength = 3;
    double distance = 0.0;

    for (PathMetric pathMetric in path.computeMetrics()) {
      while (distance < pathMetric.length) {
        dashPath.addPath(
          pathMetric.extractPath(distance, distance + dashLength),
          Offset.zero,
        );
        distance += dashLength + spaceLength;
      }
    }

    canvas.drawPath(dashPath, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
