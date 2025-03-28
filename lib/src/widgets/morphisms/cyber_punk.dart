import 'package:flutter/material.dart';

class Cyberpunk extends StatelessWidget {
  final Widget child;
  final double borderRadius;
  final List<Color> gradientColors;
  final BoxShadow boxShadow;
  final AlignmentGeometry gradientBegin;
  final AlignmentGeometry gradientEnd;

  const Cyberpunk({
    super.key,
    required this.child,
    this.borderRadius = 15.0,
    this.gradientColors = const [Colors.pinkAccent, Colors.blueAccent],
    this.boxShadow = const BoxShadow(
      color: Colors.blueAccent,
      offset: Offset(0, 4),
      blurRadius: 10,
    ),
    this.gradientBegin = Alignment.topLeft,
    this.gradientEnd = Alignment.bottomRight,
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
        boxShadow: [boxShadow],
      ),
      child: child,
    );
  }
}
