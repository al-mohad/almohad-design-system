import 'package:flutter/material.dart';

class Claymorphism extends StatelessWidget {
  final Widget child;
  final double depth;

  const Claymorphism({super.key, required this.child, this.depth = 10.0});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey[500]!,
            offset: Offset(depth, depth),
            blurRadius: depth,
          ),
          BoxShadow(
            color: Colors.white,
            offset: Offset(-depth, -depth),
            blurRadius: depth,
          ),
        ],
      ),
      child: child,
    );
  }
}
