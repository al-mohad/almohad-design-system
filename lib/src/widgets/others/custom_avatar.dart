import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// Enum to define the shape of the avatar
enum AvatarType { circle, square, rounded }

class CustomAvatar extends StatelessWidget {
  final String imageUrl;
  final double? size;
  final bool isAsset;
  final String? errorImage;
  final AvatarType? avatarType;

  const CustomAvatar({
    super.key,
    required this.imageUrl,
    this.size,
    this.isAsset = true,
    this.errorImage,
    this.avatarType, // Default is circle
  });

  bool get _isSvg => imageUrl.toLowerCase().endsWith('.svg');

  @override
  Widget build(BuildContext context) {
    return ClipRRect(borderRadius: _getBorderRadius(), child: _buildImage());
  }

  BorderRadius _getBorderRadius() {
    switch (avatarType ?? AvatarType.rounded) {
      case AvatarType.circle:
        return BorderRadius.circular(size ?? 50 / 2);
      case AvatarType.rounded:
        return BorderRadius.circular(8.0);
      case AvatarType.square:
        return BorderRadius.zero; // FIX: Use BorderRadius.zero instead of null
    }
  }

  Widget _buildImage() {
    if (isAsset) {
      return _isSvg
          ? SvgPicture.asset(
            imageUrl,
            width: size,
            height: size,
            fit: BoxFit.cover,
          )
          : Image.asset(
            imageUrl,
            width: size,
            height: size,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) => _errorWidget(),
          );
    } else {
      return _isSvg
          ? SvgPicture.network(
            imageUrl,
            width: size,
            height: size,
            fit: BoxFit.cover,
            placeholderBuilder: (context) => _shimmerEffect(),
          )
          : CachedNetworkImage(
            imageUrl: imageUrl,
            width: size,
            height: size,
            fit: BoxFit.cover,
            placeholder: (context, url) => _shimmerEffect(),
            errorWidget: (context, url, error) => _errorWidget(),
          );
    }
  }

  Widget _shimmerEffect() {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: Colors.grey[300],
        shape:
            avatarType == AvatarType.circle
                ? BoxShape.circle
                : BoxShape.rectangle,
        borderRadius:
            avatarType == AvatarType.rounded
                ? BorderRadius.circular(8.0)
                : BorderRadius.zero,
      ),
    ).animate().shimmer(duration: 1200.ms);
  }

  Widget _errorWidget() {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape:
            avatarType == AvatarType.circle
                ? BoxShape.circle
                : BoxShape.rectangle,
        borderRadius:
            avatarType == AvatarType.rounded
                ? BorderRadius.circular(8.0)
                : BorderRadius.zero,
        image: DecorationImage(
          image: AssetImage(errorImage ?? 'assets/images/default_avatar.png'),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
