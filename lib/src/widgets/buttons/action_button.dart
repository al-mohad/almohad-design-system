import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

enum ButtonVariant {
  defaultStyle,
  animatedBar,
  scaleBounce,
  fadeEffect,
  rotateEffect,
}

enum ActionStatus { idle, busy, done, waiting }

class ActionButton extends StatefulWidget {
  final ButtonVariant variant;
  final Color primaryColor;
  final Color darkPrimaryColor;
  final String idleText;
  final String busyText;
  final String doneText;
  final IconData idleIcon;
  final IconData busyIcon;
  final IconData doneIcon;
  final double width;
  final double height;
  final Duration animationDuration;

  const ActionButton({
    super.key,
    this.variant = ButtonVariant.defaultStyle,
    this.primaryColor = Colors.blue,
    this.darkPrimaryColor = Colors.blueAccent,
    this.idleText = "Download",
    this.busyText = "Downloading...",
    this.doneText = "Completed!",
    this.idleIcon = Icons.file_download,
    this.busyIcon = Icons.sync,
    this.doneIcon = Icons.check_circle,
    this.width = 200,
    this.height = 50,
    this.animationDuration = const Duration(seconds: 2),
  });

  @override
  State<ActionButton> createState() => _ActionButtonState();
}

class _ActionButtonState extends State<ActionButton>
    with SingleTickerProviderStateMixin {
  final ValueNotifier<ActionStatus> _status = ValueNotifier<ActionStatus>(
    ActionStatus.idle,
  );
  late AnimationController controller;

  @override
  void initState() {
    controller = AnimationController(
      vsync: this,
      duration: widget.animationDuration,
    );

    controller.addStatusListener((state) {
      if (state == AnimationStatus.completed) {
        _status.value = ActionStatus.done;
        Future.delayed(const Duration(seconds: 2), () {
          _status.value = ActionStatus.idle;
          controller.reset();
        });
      }
    });

    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    _status.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ActionStatus>(
      valueListenable: _status,
      builder: (context, status, child) {
        return GestureDetector(
          onTap: () {
            if (status == ActionStatus.idle) {
              _status.value = ActionStatus.busy;
              controller.forward();
            }
          },
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            width: widget.width,
            height: widget.height,
            decoration: BoxDecoration(
              color: widget.primaryColor,
              borderRadius: BorderRadius.circular(12),
            ),
            alignment: Alignment.center,
            child: Stack(
              alignment: Alignment.center,
              children: [
                _buildButtonContent(status),
                if (widget.variant == ButtonVariant.rotateEffect)
                  Transform.rotate(
                    angle: controller.value * 2 * pi,
                    child: _buildIcon(status),
                  ).animate().rotate(duration: widget.animationDuration),
                if (widget.variant == ButtonVariant.fadeEffect)
                  Opacity(
                    opacity: 1 - controller.value,
                    child: _buildButtonContent(status),
                  ).animate().fade(duration: widget.animationDuration),
                if (widget.variant == ButtonVariant.scaleBounce)
                  Transform.scale(
                    scale: 1 + (controller.value * 0.2),
                    child: _buildButtonContent(status),
                  ).animate().scale(duration: widget.animationDuration),
                if (widget.variant == ButtonVariant.animatedBar)
                  _buildAnimatedBar(),
                if (widget.variant == ButtonVariant.defaultStyle)
                  CustomPaint(
                    painter: ArcPainter(
                      startAngle: -pi / 2,
                      endAngle: controller.value * 2 * pi,
                      arcColor: _getArcColor(status),
                      strokeWidth: 6,
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildButtonContent(ActionStatus status) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(_getIcon(status), color: Colors.white, size: 24),
        const SizedBox(width: 8),
        Text(
          _getText(status),
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _buildIcon(ActionStatus status) {
    return Icon(_getIcon(status), color: Colors.white, size: 24);
  }

  Widget _buildAnimatedBar() {
    return Positioned(
      left: 0,
      top: 0,
      width: controller.value * widget.width,
      height: widget.height,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.3),
          borderRadius: BorderRadius.circular(12),
        ),
      ).animate().slideX(duration: widget.animationDuration),
    );
  }

  String _getText(ActionStatus status) {
    switch (status) {
      case ActionStatus.idle:
        return widget.idleText;
      case ActionStatus.busy:
        return widget.busyText;
      case ActionStatus.done:
        return widget.doneText;
      default:
        return "Unknown";
    }
  }

  IconData _getIcon(ActionStatus status) {
    switch (status) {
      case ActionStatus.idle:
        return widget.idleIcon;
      case ActionStatus.busy:
        return widget.busyIcon;
      case ActionStatus.done:
        return widget.doneIcon;
      default:
        return Icons.error;
    }
  }

  Color _getArcColor(ActionStatus status) {
    switch (status) {
      case ActionStatus.idle:
        return Colors.blue;
      case ActionStatus.busy:
        return Colors.orange;
      case ActionStatus.done:
        return Colors.green;
      default:
        return Colors.grey;
    }
  }
}

class ArcPainter extends CustomPainter {
  final double startAngle;
  final double endAngle;
  final Color arcColor;
  final double strokeWidth;

  ArcPainter({
    required this.startAngle,
    required this.endAngle,
    required this.arcColor,
    required this.strokeWidth,
  });

  @override
  void paint(Canvas canvas, Size size) {
    var center = Offset(size.width / 2, size.height / 2);
    final paint =
        Paint()
          ..color = arcColor
          ..strokeWidth = strokeWidth
          ..style = PaintingStyle.stroke;

    final rect = Rect.fromCircle(center: center, radius: 20);
    canvas.drawArc(rect, startAngle, endAngle, false, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
