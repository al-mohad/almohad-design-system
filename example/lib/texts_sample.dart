import 'package:almohad_design_system/almohad_design_system.dart';
import 'package:flutter/material.dart';

class TextsSample extends StatelessWidget {
  const TextsSample({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('texts')),
      body: Column(
        children: [
          DesignSystem.transformativeText(
            text: 'Glitch Effect',
            type: TransformType.glitch,
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 20),
          DesignSystem.transformativeText(
            text: 'Wave Effect',
            type: TransformType.wave,
            style: TextStyle(fontSize: 24, color: Colors.blue),
          ),
          SizedBox(height: 20),
          DesignSystem.transformativeText(
            text: 'Shake Effect',
            type: TransformType.shake,
            style: TextStyle(fontSize: 24, color: Colors.red),
          ),
          SizedBox(height: 20),
          DesignSystem.transformativeText(
            text: 'Fade Effect',
            type: TransformType.fade,
            style: TextStyle(fontSize: 24, color: Colors.green),
          ),
          SizedBox(height: 20),
          DesignSystem.transformativeText(
            text: 'Bounce Effect',
            type: TransformType.bounce,
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
