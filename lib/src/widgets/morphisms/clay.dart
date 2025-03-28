import 'package:flutter/material.dart';

class Claymorphism extends StatelessWidget {
  final Widget child;
  final double depth;
  final Color color;
  final double borderRadius;
  final double blurRadius;
  final double offsetX;
  final double offsetY;
  final Color? shadowColor;
  final Gradient? gradient;

  const Claymorphism({
    super.key,
    required this.child,
    this.depth = 10.0,
    this.color = Colors.grey,
    this.borderRadius = 20.0,
    this.blurRadius = 10.0,
    this.offsetX = 5.0,
    this.offsetY = 5.0,
    this.shadowColor = Colors.grey,
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
            color: shadowColor ?? Colors.grey[500]!,
            offset: Offset(offsetX, offsetY),
            blurRadius: blurRadius,
          ),
          BoxShadow(
            color: Colors.white,
            offset: Offset(-offsetX, -offsetY),
            blurRadius: blurRadius,
          ),
        ],
      ),
      child: child,
    );
  }
}
