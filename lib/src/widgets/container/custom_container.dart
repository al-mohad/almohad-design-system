import 'package:almohad_design_system/src/widgets/container/style.dart';
import 'package:flutter/material.dart';

import 'dashed_border.dart' show DashedBorderPainter;

class CustomContainer extends StatelessWidget {
  final Widget child;
  final double borderRadius;
  final Color? color;
  final EdgeInsets padding;
  final EdgeInsets margin;
  final double elevation;
  final double? blurRadius;
  final double? spreadRadius;
  final ContainerStyle style;
  final bool isDarkMode;
  final double? height;
  final double? width;
  final double? strokeWidth;
  final List<double>? dashPattern;

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
    this.blurRadius = 10, // Default blur radius
    this.spreadRadius = 0, // Default spread radius
    this.style = ContainerStyle.flat,
    this.isDarkMode = false,
    this.strokeWidth = 2,
    this.dashPattern = const [6, 4],
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final defaultColor = color ?? theme.colorScheme.surface;
    final isDark = theme.brightness == Brightness.dark || isDarkMode;

    return Stack(
      children: [
        if (style == ContainerStyle.dashedBorder)
          Positioned.fill(
            child: CustomPaint(
              painter: DashedBorderPainter(
                color: Colors.black45,
                strokeWidth: strokeWidth ?? 1.0,
                dashPattern: dashPattern ?? [6, 4],
                borderRadius: borderRadius,
              ),
            ),
          ),
        Container(
          padding: padding,
          margin: margin,
          height: height,
          width: width,
          decoration: _getDecoration(defaultColor, isDark),
          child: child,
        ),
      ],
    );
  }

  BoxDecoration _getDecoration(Color defaultColor, bool isDark) {
    switch (style) {
      case ContainerStyle.claymorphism:
        return _claymorphism(defaultColor);
      case ContainerStyle.glassmorphism:
        return _glassmorphism(defaultColor);
      case ContainerStyle.neumorphism:
        return _neumorphism(defaultColor, isDark);
      case ContainerStyle.isometric:
        return _isometric(defaultColor);
      case ContainerStyle.cyberpunk:
        return _cyberpunk(defaultColor);
      case ContainerStyle.depth:
        return _depth(defaultColor);
      case ContainerStyle.retroFuturism:
        return _retroFuturism(defaultColor);
      case ContainerStyle.skeuomorphism:
        return _skeuomorphism(defaultColor);
      case ContainerStyle.elevated:
        return _elevated(defaultColor);
      case ContainerStyle.bordered:
        return _bordered(defaultColor);
      case ContainerStyle.flat:
      case ContainerStyle.dottedBorder:
      case ContainerStyle.dashedBorder:
        return BoxDecoration(
          color: defaultColor,
          borderRadius: BorderRadius.circular(borderRadius),
        );
    }
  }

  BoxDecoration _claymorphism(Color color) => BoxDecoration(
    color: color,
    borderRadius: BorderRadius.circular(borderRadius),
    boxShadow: [
      BoxShadow(
        color: Colors.black26,
        offset: Offset(6, 6),
        blurRadius: blurRadius ?? 0.0,
        spreadRadius: spreadRadius ?? 0.0,
      ),
      BoxShadow(
        color: Colors.white70,
        offset: Offset(-6, -6),
        blurRadius: blurRadius ?? 0.0,
        spreadRadius: spreadRadius ?? 0.0,
      ),
    ],
  );

  BoxDecoration _glassmorphism(Color color) => BoxDecoration(
    borderRadius: BorderRadius.circular(borderRadius),
    color: color.withValues(alpha: 0.15),
    border: Border.all(color: Colors.white.withValues(alpha: 0.3), width: 1),
    boxShadow: [
      BoxShadow(
        color: Colors.black.withValues(alpha: 0.1),
        blurRadius: blurRadius ?? 0.0,
        spreadRadius: spreadRadius ?? 0.0,
      ),
    ],
    backgroundBlendMode: BlendMode.overlay,
  );

  BoxDecoration _neumorphism(Color color, bool isDark) => BoxDecoration(
    color: color,
    borderRadius: BorderRadius.circular(borderRadius),
    boxShadow: [
      BoxShadow(
        color: isDark ? Colors.black54 : Colors.grey.shade300,
        offset: Offset(4, 4),
        blurRadius: blurRadius ?? 0.0,
        spreadRadius: spreadRadius ?? 0.0,
      ),
      BoxShadow(
        color: isDark ? Colors.grey.shade800 : Colors.white,
        offset: Offset(-4, -4),
        blurRadius: blurRadius ?? 0.0,
        spreadRadius: spreadRadius ?? 0.0,
      ),
    ],
  );

  BoxDecoration _isometric(Color color) => BoxDecoration(
    color: color,
    borderRadius: BorderRadius.circular(borderRadius),
    boxShadow: [
      BoxShadow(
        color: Colors.black38,
        offset: Offset(8, 12),
        blurRadius: blurRadius ?? 0.0,
        spreadRadius: spreadRadius ?? 0.0,
      ),
    ],
  );

  BoxDecoration _cyberpunk(Color color) => BoxDecoration(
    color: Colors.black,
    borderRadius: BorderRadius.circular(borderRadius),
    border: Border.all(color: Colors.cyanAccent, width: 2),
    boxShadow: [
      BoxShadow(
        color: Colors.purpleAccent,
        offset: Offset(2, 2),
        blurRadius: blurRadius ?? 0.0,
        spreadRadius: spreadRadius ?? 0.0,
      ),
    ],
  );

  BoxDecoration _depth(Color color) => BoxDecoration(
    color: color,
    borderRadius: BorderRadius.circular(borderRadius),
    boxShadow: [
      BoxShadow(
        color: Colors.black54,
        offset: Offset(6, 6),
        blurRadius: blurRadius ?? 0.0,
        spreadRadius: spreadRadius ?? 0.0,
      ),
      BoxShadow(
        color: Colors.white24,
        offset: Offset(-6, -6),
        blurRadius: blurRadius ?? 0.0,
        spreadRadius: spreadRadius ?? 0.0,
      ),
    ],
  );

  BoxDecoration _retroFuturism(Color color) => BoxDecoration(
    gradient: LinearGradient(colors: [Colors.purple, Colors.blueAccent]),
    borderRadius: BorderRadius.circular(borderRadius),
    boxShadow: [
      BoxShadow(
        color: Colors.black54,
        blurRadius: blurRadius ?? 0.0,
        spreadRadius: spreadRadius ?? 0.0,
      ),
    ],
  );

  BoxDecoration _skeuomorphism(Color color) => BoxDecoration(
    color: Colors.brown.shade200,
    borderRadius: BorderRadius.circular(borderRadius),
    border: Border.all(color: Colors.brown.shade700, width: 2),
    boxShadow: [
      BoxShadow(
        color: Colors.brown.shade800,
        offset: Offset(4, 4),
        blurRadius: blurRadius ?? 0.0,
        spreadRadius: spreadRadius ?? 0.0,
      ),
      BoxShadow(
        color: Colors.brown.shade100,
        offset: Offset(-4, -4),
        blurRadius: blurRadius ?? 0.0,
        spreadRadius: spreadRadius ?? 0.0,
      ),
    ],
  );

  BoxDecoration _elevated(Color color) => BoxDecoration(
    color: color,
    borderRadius: BorderRadius.circular(borderRadius),
    boxShadow: [
      BoxShadow(
        color: Colors.black26,
        offset: Offset(0, elevation / 2),
        blurRadius: blurRadius ?? 0.0,
        spreadRadius: spreadRadius ?? 0.0,
      ),
    ],
  );

  BoxDecoration _bordered(Color color) => BoxDecoration(
    color: color,
    borderRadius: BorderRadius.circular(borderRadius),
    border: Border.all(color: Colors.black45, width: strokeWidth!),
  );
}
