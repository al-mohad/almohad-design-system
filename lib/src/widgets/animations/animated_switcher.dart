import 'package:flutter/material.dart';

/// A wrapper around [AnimatedSwitcher] for smooth transitions between widgets.
///
/// This widget makes it easy to animate changes in child widgets with
/// a default fade transition. You can customize the transition animation.
///
/// Example usage:
/// ```dart
/// AnimatedSwitcherWrapper(
///   child: _isToggled ? Text("Hello") : Icon(Icons.check),
///   duration: Duration(milliseconds: 300),
/// )
/// ```
class AnimatedSwitcherWrapper extends StatelessWidget {
  /// The widget to be displayed with animation.
  final Widget child;

  /// The duration of the animation.
  final Duration duration;

  /// The transition builder for customizing animations.
  final AnimatedSwitcherTransitionBuilder transitionBuilder;

  const AnimatedSwitcherWrapper({
    super.key,
    required this.child,
    this.duration = const Duration(milliseconds: 300),
    this.transitionBuilder = defaultTransition,
  });

  /// Default transition: Fades in and out.
  static Widget defaultTransition(Widget child, Animation<double> animation) {
    return FadeTransition(opacity: animation, child: child);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: duration,
      transitionBuilder: transitionBuilder,
      child: child,
    );
  }
}
