import 'package:almohad_design_system/almohad_design_system.dart';
import 'package:flutter/material.dart';

class SlidersExample extends StatelessWidget {
  const SlidersExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          DesignSystem.animatedSlider(
            value: 0.6,
            barColor: Colors.black,
            rightFillColor: Colors.amberAccent,
            leftFillColor: Colors.indigo,
            height: 40,
            barWidth: 190,
            labelStyle: TextStyle(),
          ),
          SizedBox(height: 20),
          DesignSystem.smoothSlider(
            buttonIcon: Icon(Icons.forward),
            barText: Text('data'),
            progressText: Text('p'),
            onSuccess: () {},
          ),
        ],
      ),
    );
  }
}
