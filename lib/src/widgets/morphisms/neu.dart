import 'package:flutter/material.dart';

class Neumorphism extends StatelessWidget {
  final Widget child;
  final double depth;
  final Color color;

  const Neumorphism({
    super.key,
    required this.child,
    this.depth = 10.0,
    this.color = Colors.grey,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            offset: Offset(depth, depth),
            blurRadius: depth,
          ),
          BoxShadow(
            color: Colors.white.withOpacity(0.7),
            offset: Offset(-depth, -depth),
            blurRadius: depth,
          ),
        ],
      ),
      child: child,
    );
  }
}
