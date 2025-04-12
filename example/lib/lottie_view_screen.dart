import 'package:almohad_design_system/almohad_design_system.dart';
import 'package:flutter/material.dart';

class LottieViewScreen extends StatelessWidget {
  const LottieViewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: DesignSystem.lottieViewer(
        lottiePath: 'assets/lotties/loading.json',
      ),
    );
  }
}
