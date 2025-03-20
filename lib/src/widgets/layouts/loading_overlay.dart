import 'package:flutter/material.dart';

import '../others/my_loading_indicator.dart';

class LoadingOverlay extends StatefulWidget {
  final bool isBusy;
  final Widget child;

  const LoadingOverlay({super.key, required this.isBusy, required this.child});

  @override
  State<LoadingOverlay> createState() => _LoadingOverlayState();
}

class _LoadingOverlayState extends State<LoadingOverlay>
    with SingleTickerProviderStateMixin {
  late Animation<double> opacityAnimation;
  late AnimationController controller;
  double _opacity = 0.0;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      duration: const Duration(milliseconds: 200),
      reverseDuration: const Duration(milliseconds: 400),
      vsync: this,
    );
    opacityAnimation = Tween<double>(begin: 0, end: 1).animate(controller);
    opacityAnimation.addListener(() {
      setState(() => _opacity = opacityAnimation.value);
    });
    _animate();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant LoadingOverlay oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.isBusy != widget.isBusy) _animate();
  }

  void _animate() {
    if (widget.isBusy) {
      controller.forward();
    } else {
      controller.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        widget.child,
        if (_opacity > 0)
          Opacity(
            opacity: _opacity * 0.5,
            child: ModalBarrier(
              dismissible: false,
              color: Theme.of(context).scaffoldBackgroundColor,
            ),
          ),
        if (_opacity >= 0.5)
          Opacity(
            opacity: (_opacity - 0.5) * 2,
            child: Center(child: MyLoadingIndicator()),
          ),
      ],
    );
  }
}
