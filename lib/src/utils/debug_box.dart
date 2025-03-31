import 'dart:math';

import 'package:flutter/widgets.dart';

/// A widget that wraps its child with a colored container for debugging purposes.
///
/// The `DebugBox` widget is useful for visualizing the layout of widgets in
/// your application. It adds a colored background and padding to its child,
/// making it easier to see the boundaries of the widget.
///
/// The color of the container is randomly generated each time the widget is built.
///
/// Example Usage:
///
/// ```dart
/// DebugBox(
///   child: Text('Hello, World!'),
/// ),
/// ```
/// or using the extension method
/// ```
/// Text('Hello, World!').debug,
/// ```
///
class DebugBox extends StatelessWidget {
  /// The child widget to wrap with a colored container.
  final Widget child;

  /// Creates a [DebugBox] widget.
  ///
  /// The [child] parameter is required and represents the widget to be wrapped.
  const DebugBox({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(4),
      color: randomColor(),
      child: child,
    );
  }
}

/// An extension on [Widget] that provides a convenient way to wrap a widget
/// with a [DebugBox].
extension DebugBoxExtension on Widget {
  /// Wraps the widget with a [DebugBox].
  ///
  /// This extension method allows you to easily wrap any widget with a
  /// `DebugBox` by using the `.debug` property.
  DebugBox get debug => DebugBox(child: this);
}

/// Generates a random color for the [DebugBox].
///
/// This method uses the `HSLColor` class to generate a random color with a
/// fixed saturation and lightness.
Color randomColor() {
  return HSLColor.fromAHSL(1, Random().nextDouble() * 360, 1, 0.5).toColor();
}