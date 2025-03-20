import 'package:flutter/material.dart';
import 'package:almohad_design_system/almohad_design_system.dart';

class ParallaxImagesExample extends StatelessWidget {
  const ParallaxImagesExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView.builder(
        itemCount: 5,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 10.0,
              horizontal: 16.0,
            ),
            child: DesignSystem.parallaxImage(
              imageUrl: 'https://i.pravatar.cc/',
              height: 250.0,
              parallaxFactor: 0.2,
            ),
          );
        },
      ),
    );
  }
}
