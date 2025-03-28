import 'package:flutter/material.dart';

class Neumorphism extends StatelessWidget {
  final Widget child;
  final double depth;
  final Color color;
  final double borderRadius;
  final Color shadowColor;
  final Color highlightColor;
  final double blurRadius;
  final double offsetX;
  final double offsetY;
  final Gradient? gradient;

  const Neumorphism({
    super.key,
    required this.child,
    this.depth = 10.0,
    this.color = Colors.grey,
    this.borderRadius = 20.0,
    this.shadowColor = Colors.black,
    this.highlightColor = Colors.white,
    this.blurRadius = 10.0,
    this.offsetX = 5.0,
    this.offsetY = 5.0,
    this.gradient,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: gradient,
        color: color,
        borderRadius: BorderRadius.circular(borderRadius),
        boxShadow: [
          BoxShadow(
            color: shadowColor.withValues(alpha: 0.2),
            offset: Offset(offsetX, offsetY),
            blurRadius: blurRadius,
          ),
          BoxShadow(
            color: highlightColor.withValues(alpha: 0.7),
            offset: Offset(-offsetX, -offsetY),
            blurRadius: blurRadius,
          ),
        ],
      ),
      child: child,
    );
  }
}
