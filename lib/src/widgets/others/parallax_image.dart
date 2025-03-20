import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ImageParallax extends StatelessWidget {
  final String imageUrl;
  final double height;
  final double parallaxFactor;
  final bool isAsset;

  const ImageParallax({
    super.key,
    required this.imageUrl,
    this.height = 300.0,
    this.parallaxFactor = 0.3,
    this.isAsset = false,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16.0),
      child: LayoutBuilder(
        builder: (context, constraints) {
          return SizedBox(
            height: 300,
            width: double.infinity,
            child: Stack(
              children: [
                Positioned.fill(
                  child: NotificationListener<ScrollNotification>(
                    onNotification: (ScrollNotification notification) {
                      return true;
                    },
                    child: Flow(
                      // Smooth scrolling effect
                      delegate: ParallaxFlowDelegate(
                        scrollable: Scrollable.of(context),
                        height: height,
                        parallaxFactor: parallaxFactor,
                      ),
                      children: [
                        isAsset
                            ? Image.asset(
                              imageUrl,
                              fit: BoxFit.cover,
                              width: double.infinity,
                            )
                            : Image.network(
                              imageUrl,
                              fit: BoxFit.cover,
                              width: double.infinity,
                            ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class ParallaxFlowDelegate extends FlowDelegate {
  final ScrollableState scrollable;
  final double height;
  final double parallaxFactor;

  ParallaxFlowDelegate({
    required this.scrollable,
    required this.height,
    required this.parallaxFactor,
  }) : super(repaint: scrollable.position);

  @override
  void paintChildren(FlowPaintingContext context) {
    final scrollOffset = scrollable.position.pixels;
    final baseOffset = context.size.height * parallaxFactor;
    final verticalOffset = -scrollOffset * parallaxFactor + baseOffset;

    context.paintChild(
      0,
      transform: Matrix4.translationValues(0, verticalOffset, 0),
    );
  }

  @override
  bool shouldRepaint(covariant FlowDelegate oldDelegate) => true;
}
