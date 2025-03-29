import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

enum ButtonType { primary, secondary }

enum IconAffinity { start, end }

enum ButtonAnimationType { scale, fade, rotate, slide, bounce, shake }

class CustomButton extends StatefulWidget {
  final String text;
  final VoidCallback onPressed;
  final ButtonType type;
  final Color? textColor;
  final Color? buttonColor;
  final Color? borderColor;
  final double? fontSize;
  final TextStyle? textStyle;
  final FontWeight? fontWeight;
  final double? height;
  final double? width;
  final double? radius;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;
  final Widget? icon;
  final IconAffinity iconAffinity;
  final ButtonAnimationType? buttonAnimationType;

  const CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.type = ButtonType.primary,
    this.textColor,
    this.buttonColor,
    this.borderColor,
    this.fontSize,
    this.textStyle,
    this.fontWeight,
    this.height,
    this.width,
    this.radius,
    this.margin,
    this.padding,
    this.icon,
    this.iconAffinity = IconAffinity.start,
    this.buttonAnimationType = ButtonAnimationType.scale,
  });

  @override
  CustomButtonState createState() => CustomButtonState();
}

class CustomButtonState extends State<CustomButton> {
  bool _isAnimating = false;

  void _handleTap() {
    if (_isAnimating) return;
    setState(() => _isAnimating = true);

    widget.onPressed();

    Future.delayed(const Duration(milliseconds: 400), () {
      setState(() => _isAnimating = false);
    });
  }

  @override
  Widget build(BuildContext context) {
    final bool isPrimary = widget.type == ButtonType.primary;
    final Color effectiveButtonColor =
        widget.buttonColor ??
        (isPrimary ? Theme.of(context).primaryColor : Colors.transparent);
    final Color effectiveTextColor =
        widget.textColor ?? (isPrimary ? Colors.white : Colors.black);

    Widget buttonContent = Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (widget.icon != null &&
            widget.iconAffinity == IconAffinity.start) ...[
          widget.icon!,
          const SizedBox(width: 8),
        ],
        Flexible(
          child: Text(
            widget.text,
            style:
                widget.textStyle ??
                TextStyle(
                  color: effectiveTextColor,
                  fontSize: widget.fontSize ?? 16,
                  fontWeight: widget.fontWeight ?? FontWeight.w600,
                ),
          ),
        ),
        if (widget.icon != null && widget.iconAffinity == IconAffinity.end) ...[
          const SizedBox(width: 8),
          widget.icon!,
        ],
      ],
    );

    Widget animatedButton = AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      height: widget.height ?? 50,
      width: widget.width ?? 200,
      padding: widget.padding ?? const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: effectiveButtonColor,
        borderRadius: BorderRadius.circular(widget.radius ?? 10),
        border:
            isPrimary
                ? null
                : Border.all(
                  color: widget.borderColor ?? Colors.black,
                  width: 1,
                ),
      ),
      child: Center(child: buttonContent),
    );

    switch (widget.buttonAnimationType) {
      case ButtonAnimationType.scale:
        animatedButton = animatedButton
            .animate(target: _isAnimating ? 1 : 0)
            .scale(
              begin: Offset(1.0, 1.0),
              end: Offset(1.1, 1.1),
              duration: 200.ms,
            );
        break;
      case ButtonAnimationType.fade:
        animatedButton = animatedButton
            .animate(target: _isAnimating ? 1 : 0)
            .fade(begin: 1, end: 0.5, duration: 200.ms);
        break;
      case ButtonAnimationType.rotate:
        animatedButton = animatedButton
            .animate(target: _isAnimating ? 1 : 0)
            .rotate(begin: 0, end: 0.1, duration: 200.ms);
        break;
      case ButtonAnimationType.slide:
        animatedButton = animatedButton
            .animate(target: _isAnimating ? 1 : 0)
            .slide(
              begin: const Offset(0, 0),
              end: const Offset(0, -0.1),
              duration: 200.ms,
            );
        break;
      case ButtonAnimationType.bounce:
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
      case ButtonAnimationType.shake:
        animatedButton = animatedButton
            .animate(target: _isAnimating ? 1 : 0)
            .shake(duration: 300.ms);
        break;
      case null:
        break;
    }

    return GestureDetector(onTap: _handleTap, child: animatedButton);
  }
}
