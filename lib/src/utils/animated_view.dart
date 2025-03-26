import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class LottieAnimationView extends StatelessWidget {
  final String lottiePath;
  final bool repeat;
  final bool reverse;
  final bool applyColor;
  final String text;

  const LottieAnimationView({
    super.key,
    required this.lottiePath,
    this.repeat = true,
    this.reverse = false,
    this.applyColor = true,
    this.text = '',
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: 220,
          child: Lottie.asset(
            fit: BoxFit.fill,
            lottiePath,
            reverse: reverse,
            repeat: repeat,
            delegates:
                applyColor
                    ? LottieDelegates(
                      values: [
                        ValueDelegate.color(const [
                          '**',
                        ], value: Theme.of(context).primaryColor),
                      ],
                    )
                    : null,
          ),
        ),
        if (text.trim().isNotEmpty)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
            child: Text(text, textAlign: TextAlign.center),
          ),
      ],
    );
  }
}
