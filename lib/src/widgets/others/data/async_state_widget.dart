import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../layouts/loading_overlay.dart';
import 'async_state.dart';

/// A widget to handle different async states (loading, error, empty, success).
class AsyncStateWidget extends StatelessWidget {
  final AsyncState? asyncState;
  final Widget? child;
  final Widget? emptyAsyncWidget;

  const AsyncStateWidget({
    super.key,
    required this.asyncState,
    this.child,
    this.emptyAsyncWidget,
  });

  @override
  Widget build(BuildContext context) {
    return LoadingOverlay(
      isBusy: asyncState == AsyncState.loading,
      child: Stack(
        alignment: Alignment.center,
        fit: StackFit.expand,
        children: [
          if (child != null) child!,
          _buildStateWidget(
            context,
            asyncState ?? AsyncState.none,
            emptyAsyncWidget,
          ),
        ],
      ),
    );
  }

  static Widget _buildStateWidget(
    BuildContext context,
    AsyncState? state,
    Widget? emptyAsyncWidget,
  ) {
    // final t = T.of(context);

    switch (state) {
      case AsyncState.error:
        return _buildMessageWidget(
          context,
          Iconsax.close_circle,
          'failed to load data',
        );
      case AsyncState.empty:
        return emptyAsyncWidget ??
            _buildMessageWidget(context, Iconsax.close_square, 'no data found');
      default:
        return const SizedBox.shrink();
    }
  }

  static Widget _buildMessageWidget(
    BuildContext context,
    IconData icon,
    String message,
  ) {
    final theme = Theme.of(context);
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, color: theme.primaryColor, size: 50),
        Text(message, style: theme.textTheme.bodyMedium),
      ],
    );
  }
}
