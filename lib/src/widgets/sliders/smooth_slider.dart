import 'package:flutter/material.dart';

class SmoothSlider extends StatefulWidget {
  final double range;
  final double buttonSize;
  final double buttonBorderRadius;
  final Icon buttonIcon;
  final Color buttonColor;
  final Color progressColor;
  final Widget progressText;
  final Widget barText;
  final Color barColor;
  final double barBorderRadius;
  final double barHeight;
  final VoidCallback onSuccess;
  final VoidCallback? onFailed;

  const SmoothSlider({
    super.key,
    this.range = 0.8,
    required this.buttonIcon,
    this.buttonBorderRadius = 90,
    this.buttonColor = Colors.blue,
    this.buttonSize = 50,
    required this.barText,
    this.barHeight = 45,
    this.barColor = Colors.black12,
    this.barBorderRadius = 90,
    required this.progressText,
    this.progressColor = Colors.amber,
    required this.onSuccess,
    this.onFailed,
  });

  @override
  SmoothSliderState createState() => SmoothSliderState();
}

class SmoothSliderState extends State<SmoothSlider>
    with TickerProviderStateMixin {
  final GlobalKey _trackKey = GlobalKey();
  double _positionX = 0;
  final double _scaleFactor = 1.3;

  late AnimationController _animationController;
  late AnimationController _scaleAnimationController;
  late AnimationController _opacityAnimationController;

  late Animation<double> _backPosition;
  late Animation<double> _scaleAnimation;
  late Animation<double> _opacityAnimation;
  late Animation<double> _textPositionAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );
    _scaleAnimationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );
    _opacityAnimationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
    );

    _backPosition = Tween<double>(begin: 0, end: 0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOutBack),
    );
    _scaleAnimation = Tween<double>(begin: 1, end: _scaleFactor).animate(
      CurvedAnimation(parent: _scaleAnimationController, curve: Curves.easeOut),
    );
    _opacityAnimation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(_opacityAnimationController);
    _textPositionAnimation = Tween<double>(begin: -150, end: 0).animate(
      CurvedAnimation(
        parent: _opacityAnimationController,
        curve: Curves.easeOut,
      ),
    );
  }

  void _reset() {
    _setPosition(0);
    _opacityAnimationController.reverse();
    _scaleAnimationController.reverse();
  }

  void _setPosition(double x, [VoidCallback? callback]) {
    _backPosition = Tween<double>(begin: _positionX, end: x).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.elasticOut),
    );
    _animationController.forward().whenComplete(() {
      setState(() => _positionX = x);
      _animationController.reset();
      callback?.call();
    });
  }

  void _onDragStart(DragStartDetails details) {
    _scaleAnimationController.forward();
  }

  void _onDragUpdate(DragUpdateDetails details) {
    final maxWidth = _trackKey.currentContext?.size?.width ?? 0;
    final limit = maxWidth - widget.buttonSize;
    double position = details.localPosition.dx.clamp(0, limit);

    setState(() {
      _positionX = position;
      if (_positionX > limit * widget.range) {
        _opacityAnimationController.forward();
      } else {
        _opacityAnimationController.reverse();
      }
    });
  }

  void _onDragEnd(DragEndDetails details) {
    final maxWidth = _trackKey.currentContext?.size?.width ?? 0;
    final limit = maxWidth - widget.buttonSize;

    if (_positionX < limit * widget.range) {
      _setPosition(0, widget.onFailed);
      _scaleAnimationController.reverse();
    } else {
      _setPosition(limit, widget.onSuccess);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.centerLeft,
      children: [
        _Track(
          key: _trackKey,
          text: widget.barText,
          color: widget.barColor,
          height: widget.barHeight,
          borderRadius: widget.barBorderRadius,
        ),
        _ProgressBar(
          width: _positionX + widget.buttonSize / 2,
          color: widget.progressColor,
          height: widget.barHeight,
          borderRadius: widget.barBorderRadius,
        ),
        AnimatedBuilder(
          animation: _opacityAnimationController,
          builder:
              (_, child) => Transform.translate(
                offset: Offset(_textPositionAnimation.value, 0),
                child: Opacity(opacity: _opacityAnimation.value, child: child),
              ),
          child: widget.progressText,
        ),
        _SliderHandle(
          positionX: _positionX,
          scaleAnimation: _scaleAnimation,
          icon: widget.buttonIcon,
          size: widget.buttonSize,
          color: widget.buttonColor,
          borderRadius: widget.buttonBorderRadius,
          onDragStart: _onDragStart,
          onDragUpdate: _onDragUpdate,
          onDragEnd: _onDragEnd,
        ),
      ],
    );
  }
}

// Track container
class _Track extends StatelessWidget {
  final Widget text;
  final Color color;
  final double height;
  final double borderRadius;

  const _Track({
    required this.text,
    required this.color,
    required this.height,
    required this.borderRadius,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: height,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: Center(child: text),
    );
  }
}

// Progress bar
class _ProgressBar extends StatelessWidget {
  final double width;
  final Color color;
  final double height;
  final double borderRadius;

  const _ProgressBar({
    required this.width,
    required this.color,
    required this.height,
    required this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(borderRadius),
      ),
    );
  }
}

// Slider handle (button)
class _SliderHandle extends StatelessWidget {
  final double positionX;
  final Animation<double> scaleAnimation;
  final Icon icon;
  final double size;
  final Color color;
  final double borderRadius;
  final Function(DragStartDetails) onDragStart;
  final Function(DragUpdateDetails) onDragUpdate;
  final Function(DragEndDetails) onDragEnd;

  const _SliderHandle({
    required this.positionX,
    required this.scaleAnimation,
    required this.icon,
    required this.size,
    required this.color,
    required this.borderRadius,
    required this.onDragStart,
    required this.onDragUpdate,
    required this.onDragEnd,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: positionX,
      child: GestureDetector(
        onHorizontalDragStart: onDragStart,
        onHorizontalDragUpdate: onDragUpdate,
        onHorizontalDragEnd: onDragEnd,
        child: ScaleTransition(
          scale: scaleAnimation,
          child: Container(
            height: size,
            width: size,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(borderRadius),
            ),
            child: Center(child: icon),
          ),
        ),
      ),
    );
  }
}
