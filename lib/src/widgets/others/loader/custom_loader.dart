import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

customLoader(BuildContext context, {String? lottie}) async {
  showDialog(
    context: context,
    barrierColor: Theme.of(context).primaryColor.withOpacity(0.1),
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
                  lottie ?? 'assets/lotties/loading.json',
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
