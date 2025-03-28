import 'package:flutter/material.dart';

class Skeuomorphis extends StatelessWidget {
  final Widget child;
  final double borderRadius;
  final BoxShadow boxShadow;
  final String textureAsset;
  final double shadowOpacity;
  final double offsetX;
  final double offsetY;
  final double blurRadius;

  const Skeuomorphis._({
    super.key,
    required this.child,
    this.borderRadius = 15.0,
    this.boxShadow = const BoxShadow(
      color: Colors.black,
      offset: Offset(10, 10),
      blurRadius: 10,
    ),
    required this.textureAsset,
    this.shadowOpacity = 0.5,
    this.offsetX = 10.0,
    this.offsetY = 10.0,
    this.blurRadius = 10.0,
  });

  factory Skeuomorphis({
    Key? key,
    required Widget child,
    double borderRadius = 15.0,
    BoxShadow boxShadow = const BoxShadow(
      color: Colors.black,
      offset: Offset(10, 10),
      blurRadius: 10,
    ),
    String textureAsset = 'assets/wood_texture.png',
    double shadowOpacity = 0.5,
    double offsetX = 10.0,
    double offsetY = 10.0,
    double blurRadius = 10.0,
  }) {
    if (textureAsset.isEmpty) {
      throw ArgumentError(
        "Texture asset must be provided and cannot be empty.",
      );
    }
    return Skeuomorphis._(
      key: key,
      borderRadius: borderRadius,
      boxShadow: boxShadow,
      textureAsset: textureAsset,
      shadowOpacity: shadowOpacity,
      offsetX: offsetX,
      offsetY: offsetY,
      blurRadius: blurRadius,
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius),
        boxShadow: [
          boxShadow.copyWith(
            color: boxShadow.color.withValues(alpha: shadowOpacity),
            offset: Offset(offsetX, offsetY),
            blurRadius: blurRadius,
          ),
        ],
        image: DecorationImage(
          image: AssetImage(textureAsset),
          fit: BoxFit.cover,
        ),
      ),
      child: child,
    );
  }
}
