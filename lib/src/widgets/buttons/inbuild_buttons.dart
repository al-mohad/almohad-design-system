import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

enum AnimationType { scale, fade, rotate, slide, bounce, shake }

class CustomButtonX extends StatefulWidget {
  final String text;
  final Future<void> Function() onTap;
  final VoidCallback? onLoading;
  final VoidCallback? onCompleted;
  final AnimationType animationType;
  final bool isSecondary;
  final bool isOutline;
  final TextStyle? textStyle;
  final Color? backgroundColor;
  final Color? textColor;
  final Color? borderColor;
  final double borderRadius;
  final bool shimmer;
  final IconData? icon;

  // **Primary Button Constructor**
  const CustomButtonX.primary({
    super.key,
    required this.text,
    required this.onTap,
    this.onLoading,
    this.onCompleted,
    this.animationType = AnimationType.scale,
    this.textStyle,
    this.backgroundColor = Colors.blue,
    this.textColor = Colors.white,
    this.borderColor,
    this.borderRadius = 12.0,
    this.shimmer = false,
    this.icon,
  }) : isSecondary = false,
       isOutline = false;

  // **Secondary Button Constructor**
  const CustomButtonX.secondary({
    super.key,
    required this.text,
    required this.onTap,
    this.onLoading,
    this.onCompleted,
    this.animationType = AnimationType.scale,
    this.textStyle,
    this.backgroundColor = Colors.grey,
    this.textColor = Colors.black,
    this.borderColor,
    this.borderRadius = 12.0,
    this.shimmer = false,
    this.icon,
  }) : isSecondary = true,
       isOutline = false;

  // **Outline Button Constructor**
  const CustomButtonX.outline({
    super.key,
    required this.text,
    required this.onTap,
    this.onLoading,
    this.onCompleted,
    this.animationType = AnimationType.scale,
    this.textStyle,
    this.backgroundColor = Colors.transparent,
    this.textColor = Colors.blue,
    this.borderColor = Colors.blue,
    this.borderRadius = 12.0,
    this.shimmer = false,
    this.icon,
  }) : isSecondary = false,
       isOutline = true;

  // **Icon Button Constructor**
  const CustomButtonX.icon({
    super.key,
    required this.text,
    required this.onTap,
    required this.icon,
    this.onLoading,
    this.onCompleted,
    this.animationType = AnimationType.scale,
    this.textStyle,
    this.backgroundColor = Colors.blue,
    this.textColor = Colors.white,
    this.borderColor,
    this.borderRadius = 12.0,
    this.shimmer = false,
  }) : isSecondary = false,
       isOutline = false;

  @override
  _CustomButtonXState createState() => _CustomButtonXState();
}

class _CustomButtonXState extends State<CustomButtonX> {
  bool _isLoading = false;
  double _buttonWidth = 200.0;
  double _buttonHeight = 50.0;
  static const double _loadingSize = 50.0;
  bool _isAnimating = false;

  void _startLoading() {
    widget.onLoading?.call();
    setState(() {
      _isLoading = true;
      _buttonWidth = _loadingSize;
      _buttonHeight = _loadingSize;
    });
  }

  void _stopLoading() {
    widget.onCompleted?.call();
    setState(() {
      _isLoading = false;
      _buttonWidth = 200.0;
      _buttonHeight = 50.0;
    });
  }

  Future<void> _handleTap() async {
    if (_isAnimating) return;
    setState(() => _isAnimating = true);

    _startLoading();
    await widget.onTap();
    _stopLoading();

    Future.delayed(const Duration(milliseconds: 400), () {
      setState(() => _isAnimating = false);
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget buttonContent =
        _isLoading
            ? const CircularProgressIndicator(
              color: Colors.white,
              strokeWidth: 2,
            )
            : Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (widget.icon != null)
                  Icon(widget.icon, color: widget.textColor),
                if (widget.icon != null) const SizedBox(width: 5),
                Text(
                  widget.text,
                  style:
                      widget.textStyle ??
                      TextStyle(
                        color: widget.textColor ?? Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ],
            );

    if (widget.shimmer) {
      buttonContent = buttonContent
          .animate(onPlay: (controller) => controller.repeat())
          .shimmer(duration: 1500.ms);
    }

    Widget animatedButton = AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      width: _buttonWidth,
      height: _buttonHeight,
      decoration: BoxDecoration(
        color:
            widget.isOutline
                ? Colors.transparent
                : widget.backgroundColor ?? Colors.blue,
        border:
            widget.isOutline
                ? Border.all(color: widget.borderColor ?? Colors.blue, width: 2)
                : null,
        borderRadius: BorderRadius.circular(
          _isLoading ? 50 : widget.borderRadius,
        ),
        boxShadow:
            _isLoading ? [] : [BoxShadow(color: Colors.black26, blurRadius: 5)],
      ),
      alignment: Alignment.center,
      child: buttonContent,
    );

    switch (widget.animationType) {
      case AnimationType.scale:
        animatedButton = animatedButton
            .animate(target: _isAnimating ? 1 : 0)
            .scale(
              begin: Offset(1.0, 1.0),
              end: Offset(1.1, 1.1),
              duration: 200.ms,
            );
        {}
        break;
      case AnimationType.fade:
        animatedButton = animatedButton
            .animate(target: _isAnimating ? 1 : 0)
            .fade(begin: 1, end: 0.5, duration: 200.ms);
        break;
      case AnimationType.rotate:
        animatedButton = animatedButton
            .animate(target: _isAnimating ? 1 : 0)
            .rotate(begin: 0, end: 0.1, duration: 200.ms);
        break;
      case AnimationType.slide:
        animatedButton = animatedButton
            .animate(target: _isAnimating ? 1 : 0)
            .slide(
              begin: const Offset(0, 0),
              end: const Offset(0, -0.1),
              duration: 200.ms,
            );
        break;
      case AnimationType.bounce:
        animatedButton = animatedButton
            .animate(target: _isAnimating ? 1 : 0)
            .scale(
              begin: Offset(1.0, 1.0),
              end: Offset(1.2, 1.2),
              duration: 100.ms,
            )
            .then()
            .scale(
              begin: Offset(1.2, 1.2),
              end: Offset(1.0, 1.0),
              duration: 100.ms,
            );
        break;
      case AnimationType.shake:
        animatedButton = animatedButton
            .animate(target: _isAnimating ? 1 : 0)
            .shake(duration: 300.ms);
        break;
    }

    return GestureDetector(
      onTap: _isLoading ? null : _handleTap,
      child: animatedButton,
    );
  }
}
