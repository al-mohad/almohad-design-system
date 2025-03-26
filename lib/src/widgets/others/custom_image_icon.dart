import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomImageIcon extends StatelessWidget {
  final String assetPath;
  final double size;
  final Color? color;
  final bool isSvg;

  const CustomImageIcon({
    super.key,
    required this.assetPath,
    this.size = 24.0,
    this.color,
    this.isSvg = false,
  });

  @override
  Widget build(BuildContext context) {
    return isSvg
        ? SvgPicture.asset(
          assetPath,
          width: size,
          height: size,
          colorFilter:
              color != null ? ColorFilter.mode(color!, BlendMode.srcIn) : null,
        )
        : ImageIcon(AssetImage(assetPath), size: size, color: color);
  }
}
