import 'dart:math';

import 'package:almohad_design_system/almohad_design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class TransformText extends StatefulWidget {
  final String text;
  final TextStyle? style;
  final TransformType transformType;
  final Duration duration;
  final bool repeat;

  const TransformText({
    super.key,
    required this.text,
    this.style,
    required this.transformType,
    this.duration = const Duration(milliseconds: 500),
    this.repeat = true,
  });

  @override
  _TransformTextState createState() => _TransformTextState();
}

class _TransformTextState extends State<TransformText>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    switch (widget.transformType) {
      case TransformType.glitch:
        return _buildGlitchText();
      case TransformType.wave:
        return _buildWaveText();
      case TransformType.shake:
        return _buildShakeText();
      case TransformType.fade:
        return _buildFadeText();
      case TransformType.scale:
        return _buildScaleText();
      case TransformType.rotate:
        return _buildRotateText();
      case TransformType.blur:
        return _buildBlurText();
      case TransformType.flip:
        return _buildFlipText();
      case TransformType.colorShift:
        return _buildColorShiftText();
      case TransformType.typewriter:
        return _buildTypewriterText();
      case TransformType.shimmer:
        return _buildShimmerText();
      case TransformType.outline:
        return _buildOutlineText();
      case TransformType.rainbow:
        return _buildRainbowText();
      case TransformType.shadowPulse:
        return _buildShadowPulseText();
      case TransformType.bounce:
        return _buildBounceText();
    }
  }

  Widget _buildGlitchText() {
    return Stack(
      children: [
        Text(widget.text, style: widget.style),
        Positioned(
          left: Random().nextDouble() * 4 - 2,
          top: Random().nextDouble() * 4 - 2,
          child: Text(
            widget.text,
            style: widget.style?.copyWith(
              color: Colors.redAccent.withValues(alpha: 0.7),
            ),
          ),
        ),
        Positioned(
          right: Random().nextDouble() * 4 - 2,
          bottom: Random().nextDouble() * 4 - 2,
          child: Text(
            widget.text,
            style: widget.style?.copyWith(
              color: Colors.blueAccent.withValues(alpha: 0.7),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildWaveText() {
    return Text(widget.text, style: widget.style)
        .animate(
          onPlay: (controller) => widget.repeat ? controller.repeat() : null,
        )
        .moveY(begin: -5, end: 5, duration: widget.duration)
        .swap(builder: (context, child) => child ?? SizedBox());
  }

  Widget _buildShakeText() {
    return Text(widget.text, style: widget.style)
        .animate(
          onPlay: (controller) => widget.repeat ? controller.repeat() : null,
        )
        .moveX(begin: -5, end: 5, duration: widget.duration)
        .swap(builder: (context, child) => child ?? SizedBox());
  }

  Widget _buildFadeText() {
    return Text(widget.text, style: widget.style)
        .animate(
          onPlay: (controller) => widget.repeat ? controller.repeat() : null,
        )
        .fade(duration: widget.duration);
  }

  Widget _buildScaleText() {
    return Text(widget.text, style: widget.style)
        .animate(
          onPlay: (controller) => widget.repeat ? controller.repeat() : null,
        )
        .scaleXY(begin: 0.8, end: 1.2, duration: widget.duration)
        .swap(builder: (context, child) => child ?? SizedBox());
  }

  Widget _buildRotateText() {
    return Text(widget.text, style: widget.style)
        .animate(
          onPlay: (controller) => widget.repeat ? controller.repeat() : null,
        )
        .rotate(begin: -0.1, end: 0.1, duration: widget.duration)
        .swap(builder: (context, child) => child ?? SizedBox());
  }

  Widget _buildBlurText() {
    return Text(widget.text, style: widget.style)
        .animate(
          onPlay: (controller) => widget.repeat ? controller.repeat() : null,
        )
        .blurXY(begin: 5, end: 0, duration: widget.duration);
  }

  Widget _buildFlipText() {
    return Text(widget.text, style: widget.style)
        .animate(
          onPlay: (controller) => widget.repeat ? controller.repeat() : null,
        )
        .flipH(duration: widget.duration)
        .swap(builder: (context, child) => child ?? SizedBox());
  }

  Widget _buildColorShiftText() {
    return Text(widget.text, style: widget.style)
        .animate(
          onPlay: (controller) => widget.repeat ? controller.repeat() : null,
        )
        .tint(color: Colors.blue, duration: widget.duration)
        .swap(builder: (context, child) => child ?? SizedBox());
  }

  Widget _buildTypewriterText() {
    return Text(widget.text, style: widget.style)
        .animate(
          onPlay: (controller) => widget.repeat ? controller.repeat() : null,
        )
        .fade(duration: widget.duration)
        .slideX(begin: -1, end: 0, duration: widget.duration);
  }

  Widget _buildShimmerText() {
    return Text(widget.text, style: widget.style)
        .animate(
          onPlay: (controller) => widget.repeat ? controller.repeat() : null,
        )
        .shimmer(duration: widget.duration);
  }

  Widget _buildOutlineText() {
    return Stack(
      children: [
        Text(
          widget.text,
          style: widget.style?.copyWith(
            foreground:
                Paint()
                  ..style = PaintingStyle.stroke
                  ..strokeWidth = 2
                  ..color = Colors.black,
          ),
        ),
        Text(widget.text, style: widget.style),
      ],
    );
  }

  Widget _buildRainbowText() {
    return Text(widget.text, style: widget.style)
        .animate(
          onPlay: (controller) => widget.repeat ? controller.repeat() : null,
        )
        .tint(color: Colors.red, duration: widget.duration)
        .then(delay: widget.duration)
        .tint(color: Colors.orange, duration: widget.duration)
        .then(delay: widget.duration)
        .tint(color: Colors.yellow, duration: widget.duration)
        .swap(builder: (context, child) => child ?? SizedBox());
  }

  Widget _buildShadowPulseText() {
    return Text(widget.text, style: widget.style)
        .animate(
          onPlay: (controller) => widget.repeat ? controller.repeat() : null,
        )
        .tint(
          color: Colors.black.withValues(alpha: 0.5),
          duration: widget.duration,
        )
        .swap(builder: (context, child) => child ?? SizedBox());
  }

  Widget _buildBounceText() {
    return Text(widget.text, style: widget.style)
        .animate(
          onPlay: (controller) => widget.repeat ? controller.repeat() : null,
        )
        .moveY(begin: -10, end: 0, duration: widget.duration)
        .swap(builder: (context, child) => child ?? SizedBox());
  }
}
