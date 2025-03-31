import 'package:almohad_design_system/almohad_design_system.dart';
import 'package:flutter/material.dart';

class DummyAudioPlayer extends StatelessWidget {
  const DummyAudioPlayer({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Audio Player')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            AnimatedToggleSwitch(
              values: ['Light', 'Dark'],
              onToggle: (index, value) {
                debugPrint("Toggled to: $value (Index: $index)");
              },
              animationDuration: const Duration(milliseconds: 500),
              animationCurve: Curves.easeInOut,
              activeColor: Colors.green,
              inactiveColor: Colors.red,
              activeTextColor: Colors.white,
              inactiveTextColor: Colors.black,
              backgroundColor: Colors.grey.shade300,
              textStyle: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
              width: 250,
              height: 80,
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              borderRadius: BorderRadius.circular(50),
              showShadow: true,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 38.0),
              child: TransformingAnimatedToggleSwitch(
                activeColor: Colors.blue,
                inactiveColor: Colors.grey[300]!,
                backgroundColor: Colors.grey[200]!,
                animationDuration: const Duration(milliseconds: 300),
                animationCurve: Curves.easeInOut,
                width: 250,
                height: 60,
                borderRadius: BorderRadius.circular(30),
                showShadow: true,
                primaryValues: ['Free', 'Premium'],
                secondaryValues: ['Monthly', 'Annualy'],
                onPrimaryToggle: (index, value) {
                  debugPrint('onPrimaryToggle: $index, $value');
                },
                onSecondaryToggle: (index, value) {
                  debugPrint('onSecondaryToggle: $index, $value');
                },
              ),
            ),
            Text('Audio Player'),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: DesignSystem.audioPlayer(
                isSender: false,

                audioUrl:
                    'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-1.mp3',
                audioTitle: 'The SoundHelix Song',
                showUserAvatar: true,
                userAvatar: "https://i.pravatar.cc",
                backgroundColor: Colors.blue,
                doneColor: Colors.green,
                time: DateTime.now(),
                status: ChatStatus.read,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
