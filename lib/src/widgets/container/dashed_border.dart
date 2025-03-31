import 'dart:ui' as ui;

import 'package:flutter/material.dart';

class DashedBorderPainter extends CustomPainter {
  final Color color;
  final double strokeWidth;
  final List<double> dashPattern;
  final double borderRadius;

  DashedBorderPainter({
    required this.color,
    required this.strokeWidth,
    this.dashPattern = const [6, 4],
    this.borderRadius = 12,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint =
        Paint()
          ..color = color
          ..strokeWidth = strokeWidth
          ..style = PaintingStyle.stroke
          ..strokeCap = StrokeCap.round
          ..shader = ui.Gradient.linear(
            Offset(0, 0),
            Offset(size.width, size.height),
            [color, color.withOpacity(0.8)],
          );

    final Path path =
        Path()..addRRect(
          RRect.fromRectAndRadius(
            Rect.fromLTWH(0, 0, size.width, size.height),
            Radius.circular(borderRadius),
          ),
        );

    _drawDashedPath(canvas, path, paint);
  }

  void _drawDashedPath(Canvas canvas, Path path, Paint paint) {
    ui.PathMetric pathMetric = path.computeMetrics().first;
    double distance = 0;
    final Path dashPath = Path();

    while (distance < pathMetric.length) {
      final double dashLength = dashPattern[0];
      final double spaceLength =
          dashPattern.length > 1 ? dashPattern[1] : dashPattern[0];

      dashPath.addPath(
        pathMetric.extractPath(distance, distance + dashLength),
        Offset.zero,
      );
      distance += dashLength + spaceLength;
    }

    canvas.drawPath(dashPath, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

enum ContainerStyle {
  flat,
  bordered,
  dashedBorder, // Added dashed border style
}
