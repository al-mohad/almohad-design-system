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
            Text('Audio Player'),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: DesignSystem.audioPlayer(
                isSender: false,

                audioUrl:
                    'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-1.mp3',
                audioTitle: 'The SoundHelix Song',
                showUserAvatar: true,
                userAvatar: "i.pravatar.cc",
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
