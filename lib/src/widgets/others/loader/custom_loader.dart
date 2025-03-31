import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

customLoader(BuildContext context, {String? lottie}) async {
  await showDialog(
    context: context,
    barrierColor: Theme.of(context).primaryColor.withValues(alpha: 0.1),
    barrierDismissible: false,
    builder:
        (_) => PopScope(
          canPop: false,
          child: Center(
            child: SizedBox(
              width: 70,
              height: 70,
              child: Material(
                color: Theme.of(context).primaryColorDark,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: LottieBuilder.asset(
                  (lottie == null || lottie.isEmpty)
                      ? 'assets/lotties/loading.json'
                      : lottie,
                  height: 120,
                  width: 120,
                  fit: BoxFit.contain,
                  repeat: true,
                ),
              ),
            ),
          ),
        ),
  );
}
