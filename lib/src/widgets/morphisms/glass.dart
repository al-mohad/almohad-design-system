import 'dart:ui';

import 'package:flutter/material.dart';

/// A glassmorphic effect widget with customizable blur, transparency, and border.
class Glassmorphism extends StatelessWidget {
  /// The child widget displayed inside the glassmorphic container.
  final Widget child;

  /// The intensity of the blur effect (default: `10.0`).
  final double? blur;

  /// The opacity of the glass background (default: `0.2`).
  final double? opacity;

  /// The border radius of the glass container (default: `20.0`).
  final double? borderRadius;

  /// The border color (default: semi-transparent white).
  final Color? borderColor;

  /// The border width (default: `1.5`).
  final double? borderWidth;

  /// The background color for the glassmorphic effect.
  final Color? color;

  /// The gradient background (optional).
  final Gradient? gradient;

  const Glassmorphism({
    super.key,
    required this.child,
    this.blur,
    this.opacity,
    this.borderRadius,
    this.borderColor,
    this.borderWidth,
    this.color,
    this.gradient,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius ?? 20.0),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: blur ?? 10, sigmaY: blur ?? 10),
        child: Container(
          decoration: BoxDecoration(
            color:
                color?.withValues(alpha: opacity ?? 0.2) ??
                Colors.white.withValues(alpha: opacity ?? 0.2),
            borderRadius: BorderRadius.circular(borderRadius ?? 20.0),
            border: Border.all(
              color: borderColor ?? Colors.white54,
              width: borderWidth ?? 1.5,
            ),
            gradient: gradient,
          ),
          child: child,
        ),
      ),
    );
  }
}
