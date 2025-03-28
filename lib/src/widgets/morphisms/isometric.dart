import 'package:flutter/material.dart';

class Isometric extends StatelessWidget {
  final Widget child;
  final double rotationX;
  final double rotationY;
  final Color color;
  final double borderRadius;
  final List<BoxShadow> boxShadow;

  const Isometric({
    super.key,
    required this.child,
    this.rotationX = 0.2,
    this.rotationY = 0.2,
    this.color = Colors.blue,
    this.borderRadius = 15.0,
    this.boxShadow = const [
      BoxShadow(color: Colors.black26, offset: Offset(5, 5), blurRadius: 10),
    ],
  });

  @override
  Widget build(BuildContext context) {
    return Transform(
      alignment: Alignment.center,
      transform:
          Matrix4.identity()
            ..rotateX(rotationX)
            ..rotateY(rotationY),
      child: Container(
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(borderRadius),
          boxShadow: boxShadow,
        ),
        child: child,
      ),
    );
  }
}
