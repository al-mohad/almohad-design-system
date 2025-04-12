import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

enum LottieType { asset, file, memory, network }

class LottieViewer extends StatelessWidget {
  /// The source type of the Lottie animation. Defaults to [LottieType.asset].
  final LottieType type;

  /// The path or data for the Lottie animation based on the [type].
  /// - For [LottieType.asset]: The path to the Lottie asset in the assets folder.
  /// - For [LottieType.file]: The path to the Lottie file on the device.
  /// - For [LottieType.memory]: A [Uint8List] containing the Lottie data.
  /// - For [LottieType.network]: The URL of the Lottie JSON file.
  final String path;

  /// Whether the Lottie animation should repeat. Defaults to true.
  final bool? repeat;

  /// Whether the Lottie animation should play in reverse. Defaults to false.
  final bool? reverse;

  /// Whether to apply the primary color of the current theme to specific parts of the Lottie animation. Defaults to true.
  /// This targets all layers ('**') by default. You can customize this by providing a [LottieDelegates] object via the [delegates] property for more specific color mapping.
  final bool? applyColor;

  /// Optional text to display below the Lottie animation. Defaults to an empty string.
  final String? text;

  /// Optional style for the [text]. If not provided, it defaults to the `bodyMedium` text style of the current theme with the primary color light.
  final TextStyle? textStyle;

  /// Optional fixed height for the Lottie animation. If not provided, the animation will take its intrinsic height within a SizedBox of 220.
  final double? height;

  /// Optional fixed width for the Lottie animation. If not provided, the animation will take its intrinsic width within the available space.
  final double? width;

  /// Optional BoxFit to control how the Lottie animation is inscribed into the available space. Defaults to [BoxFit.fill].
  final BoxFit? fit;

  /// Optional speed of the Lottie animation. Defaults to 1.0.
  final double? speed;

  /// Optional controller to manually control the Lottie animation.
  final Animation<double>? controller;

  /// Optional callback when the Lottie animation is loaded.
  final void Function(LottieComposition)? onLoaded;

  /// Optional delegates to customize the Lottie animation, such as color mapping or text replacement. This overrides the [applyColor] property if provided.
  final LottieDelegates? delegates;

  /// Optional alignment of the Lottie animation within its container. Defaults to [Alignment.center].
  final AlignmentGeometry? alignment;

  /// Optional padding around the text below the Lottie animation. Defaults to `EdgeInsets.symmetric(horizontal: 16.0, vertical: 8)`.
  final EdgeInsetsGeometry? textPadding;

  /// Optional mainAxisAlignment for the Column containing the Lottie and text. Defaults to [MainAxisAlignment.center].
  final MainAxisAlignment? mainAxisAlignment;

  /// Optional crossAxisAlignment for the Column containing the Lottie and text. Defaults to [CrossAxisAlignment.center].
  final CrossAxisAlignment? crossAxisAlignment;

  const LottieViewer({
    super.key,
    required this.path,
    this.type = LottieType.asset,
    this.repeat = true,
    this.reverse = false,
    this.applyColor = true,
    this.text = '',
    this.textStyle,
    this.height,
    this.width,
    this.fit = BoxFit.fill,
    this.speed = 1.0,
    this.controller,
    this.onLoaded,
    this.delegates,
    this.alignment = Alignment.center,
    this.textPadding = const EdgeInsets.symmetric(
      horizontal: 16.0,
      vertical: 8,
    ),
    this.mainAxisAlignment = MainAxisAlignment.center,
    this.crossAxisAlignment = CrossAxisAlignment.center,
  });

  @override
  Widget build(BuildContext context) {
    Widget lottieWidget;
    String ref = 'packages/almohad_design_system/';
    switch (type) {
      case LottieType.asset:
        lottieWidget = Lottie.asset(
          ref + path,
          fit: fit,
          reverse: reverse,
          repeat: repeat,
          controller: controller,
          onLoaded: onLoaded,
          delegates: delegates ?? _buildDelegates(context, applyColor),
          alignment: alignment ?? Alignment.center,
        );
        break;
      case LottieType.file:
        lottieWidget = Lottie.file(
          Uri.file(ref + path),
          fit: fit,
          reverse: reverse,
          repeat: repeat,
          controller: controller,
          onLoaded: onLoaded,
          delegates: delegates ?? _buildDelegates(context, applyColor),
          alignment: alignment ?? Alignment.center,
        );
        break;
      case LottieType.memory:
        lottieWidget = Lottie.memory(
          Uri.parse(ref + path).data!.contentAsBytes(),
          fit: fit,
          reverse: reverse,
          repeat: repeat,
          controller: controller,
          onLoaded: onLoaded,
          delegates: delegates ?? _buildDelegates(context, applyColor),
          alignment: alignment ?? Alignment.center,
        );
        break;
      case LottieType.network:
        lottieWidget = Lottie.network(
          path,
          fit: fit,
          reverse: reverse,
          repeat: repeat,
          controller: controller,
          onLoaded: onLoaded,
          delegates: delegates ?? _buildDelegates(context, applyColor),
          alignment: alignment ?? Alignment.center,
        );
        break;
    }

    return Column(
      mainAxisAlignment: mainAxisAlignment ?? MainAxisAlignment.center,
      crossAxisAlignment: crossAxisAlignment ?? CrossAxisAlignment.center,
      children: [
        SizedBox(height: height ?? 220, width: width, child: lottieWidget),
        if (text != null && text!.trim().isNotEmpty)
          Padding(
            padding:
                textPadding ??
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
            child: Text(
              text!,
              textAlign: TextAlign.center,
              style:
                  textStyle ??
                  Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context).primaryColorLight,
                  ),
            ),
          ),
      ],
    );
  }

  LottieDelegates? _buildDelegates(BuildContext context, bool? applyColor) {
    return applyColor == true
        ? LottieDelegates(
          values: [
            ValueDelegate.color(const [
              '**',
            ], value: Theme.of(context).primaryColor),
          ],
        )
        : null;
  }
}
