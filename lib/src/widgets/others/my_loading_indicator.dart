import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

/// A custom loading indicator widget.
///
/// This widget uses the `flutter_spinkit` package to display a pulsing grid
/// animation as a loading indicator. The color of the indicator is based on
/// the primary color of the current theme.
///
/// The `MyLoadingIndicator` is designed to be used in situations where the
/// application needs to indicate that an operation is in progress.
///
/// See also:
///
///  * [SpinKitPulsingGrid], which is the underlying widget used to display
///    the loading animation.
class MyLoadingIndicator extends StatelessWidget {
  /// Creates a [MyLoadingIndicator].
  const MyLoadingIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    var colorScheme = theme.colorScheme;
    return SpinKitPulsingGrid(
      color: colorScheme.primary,
      size: 50.0,
    );
  }
}