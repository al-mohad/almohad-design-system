import 'package:flutter/material.dart';

class Depth extends StatelessWidget {
  final Widget child;
  final double depth;
  final Color color;
  final double borderRadius;
  final Color shadowColor;
  final Color highlightColor;
  final double offsetX;
  final double offsetY;
  final double blurRadius;

  const Depth({
    super.key,
    required this.child,
    this.depth = 15.0,
    this.color = Colors.white,
    this.borderRadius = 25.0,
    this.shadowColor = const Color(0x33000000), // Semi-transparent black
    this.highlightColor = const Color(0x99FFFFFF), // Semi-transparent white
    this.offsetX = 5.0,
    this.offsetY = 5.0,
    this.blurRadius = 15.0,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(borderRadius),
        boxShadow: [
          BoxShadow(
            color: shadowColor,
            offset: Offset(offsetX, offsetY),
            blurRadius: blurRadius,
          ),
          BoxShadow(
            color: highlightColor,
            offset: Offset(-offsetX, -offsetY),
            blurRadius: blurRadius,
          ),
        ],
      ),
      child: child,
    );
  }
}
