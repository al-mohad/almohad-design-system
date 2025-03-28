import 'package:flutter/material.dart';

class RetroFuturism extends StatelessWidget {
  final Widget child;
  final double borderRadius;
  final List<Color> gradientColors;
  final BoxShadow boxShadow;
  final AlignmentGeometry gradientBegin;
  final AlignmentGeometry gradientEnd;
  final double blurRadius;
  final double offsetX;
  final double offsetY;

  const RetroFuturism({
    super.key,
    required this.child,
    this.borderRadius = 20.0,
    this.gradientColors = const [Colors.yellowAccent, Colors.purple],
    this.boxShadow = const BoxShadow(
      color: Colors.pinkAccent,
      offset: Offset(5, 5),
      blurRadius: 15,
    ),
    this.gradientBegin = Alignment.topLeft,
    this.gradientEnd = Alignment.bottomRight,
    this.blurRadius = 15.0,
    this.offsetX = 5.0,
    this.offsetY = 5.0,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: gradientColors,
          begin: gradientBegin,
          end: gradientEnd,
        ),
        borderRadius: BorderRadius.circular(borderRadius),
        boxShadow: [
          BoxShadow(
            color: boxShadow.color,
            offset: Offset(offsetX, offsetY),
            blurRadius: blurRadius,
          ),
        ],
      ),
      child: child,
    );
  }
}
