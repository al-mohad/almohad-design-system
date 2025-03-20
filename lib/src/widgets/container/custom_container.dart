import 'package:flutter/material.dart';

import 'style.dart';

class CustomContainer extends StatelessWidget {
  final Widget child;
  final double borderRadius;
  final Color? color;
  final EdgeInsets padding;
  final double elevation;
  final ContainerStyle style;
  final bool isDarkMode;

  const CustomContainer({
    super.key,
    required this.child,
    this.borderRadius = 12,
    this.color,
    this.padding = const EdgeInsets.all(16),
    this.elevation = 10,
    this.style = ContainerStyle.flat,
    this.isDarkMode = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final defaultColor = color ?? theme.colorScheme.surface;
    final isDark = theme.brightness == Brightness.dark || isDarkMode;

    return Container(
      padding: padding,
      decoration: _getDecoration(defaultColor, isDark),
      child: child,
    );
  }

  /// Returns different decoration styles based on the chosen style
  BoxDecoration _getDecoration(Color defaultColor, bool isDark) {
    switch (style) {
      case ContainerStyle.claymorphism:
        return BoxDecoration(
          color: defaultColor,
          borderRadius: BorderRadius.circular(borderRadius),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.15),
              offset: Offset(6, 6),
              blurRadius: elevation,
            ),
            BoxShadow(
              color: Colors.white.withValues(alpha: 0.5),
              offset: Offset(-6, -6),
              blurRadius: elevation,
            ),
          ],
        );

      case ContainerStyle.glassmorphism:
        return BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadius),
          color: defaultColor.withValues(alpha: 0.15),
          border: Border.all(
            color: Colors.white.withValues(alpha: 0.3),
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
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
              color: Colors.black.withValues(alpha: 0.2),
              offset: Offset(0, elevation / 2),
              blurRadius: elevation,
            ),
          ],
        );

      case ContainerStyle.flat:
        return BoxDecoration(
          color: defaultColor,
          borderRadius: BorderRadius.circular(borderRadius),
        );
    }
  }
}
