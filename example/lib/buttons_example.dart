import 'package:almohad_design_system/almohad_design_system.dart';
import 'package:flutter/material.dart';

class ButtonsExample extends StatelessWidget {
  const ButtonsExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Buttons Example')),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              DesignSystem.button(
                text: "Primary Button",
                onPressed: () {
                  debugPrint("Primary Button Clicked");
                },
                type: ButtonType.primary,
                textColor: Colors.white,
                animationType: ButtonAnimationType.slide,
              ),
              const SizedBox(height: 20),

              DesignSystem.button(
                text: "Secondary Button",
                onPressed: () {
                  debugPrint("Secondary Button Clicked");
                },
                type: ButtonType.secondary,
                textColor: Colors.black,
                borderColor: Colors.black,
              ),
              const SizedBox(height: 20),

              DesignSystem.button(
                text: "Icon Start",
                onPressed: () {
                  debugPrint("Button with Icon Clicked");
                },
                type: ButtonType.primary,
                textColor: Colors.white,
                buttonColor: Colors.green,
                icon: const Icon(Icons.thumb_up, color: Colors.white),
                iconAffinity: IconAffinity.start,
              ),
              const SizedBox(height: 20),

              DesignSystem.button(
                text: "Icon End",
                onPressed: () {
                  debugPrint("Button with Icon End Clicked");
                },
                type: ButtonType.primary,
                textColor: Colors.white,
                buttonColor: Colors.orange,
                icon: const Icon(Icons.arrow_forward, color: Colors.white),
                iconAffinity: IconAffinity.end,
              ),
              const SizedBox(height: 20),

              DesignSystem.button(
                text: "Square Button",
                onPressed: () {
                  debugPrint("Square Button Clicked");
                },
                type: ButtonType.primary,
                buttonColor: Colors.red,
                textColor: Colors.white,
                radius: 0,
              ),
              const SizedBox(height: 20),

              DesignSystem.button(
                text: "Small Button",
                onPressed: () {
                  debugPrint("Small Button Clicked");
                },
                type: ButtonType.primary,
                textColor: Colors.white,
                height: 35,
                width: 120,
                fontSize: 12,
              ),
              const SizedBox(height: 20),

              DesignSystem.button(
                text: "Large Button",
                onPressed: () {
                  debugPrint("Large Button Clicked");
                },
                type: ButtonType.primary,
                textColor: Colors.white,
                height: 60,
                width: 250,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
              const SizedBox(height: 20),

              DesignSystem.button(
                text: "Custom Colored",
                onPressed: () {
                  debugPrint("Custom Colored Button Clicked");
                },
                type: ButtonType.primary,
                buttonColor: Colors.purple,
                textColor: Colors.white,
                borderColor: Colors.yellow,
              ),
              const SizedBox(height: 20),

              DesignSystem.button(
                text: "Rounded Button",
                onPressed: () {
                  debugPrint("Rounded Button Clicked");
                },
                type: ButtonType.primary,
                textColor: Colors.white,
                radius: 50,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
