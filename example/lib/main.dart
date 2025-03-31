import 'package:almohad_design_system/almohad_design_system.dart';
import 'package:example/buttons_example.dart';
import 'package:example/containers_sample.dart';
import 'package:example/dummy_containers.dart';
import 'package:example/dummy_texts.dart';
import 'package:example/parallax_images.dart';
import 'package:example/texts_sample.dart';
import 'package:flutter/material.dart';

import 'audio_player_sample.dart';
import 'chat_messages_sample.dart';
import 'expanded_test.dart';

void main() {
  runApp(DesignSystem.toastProvider(child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(title: 'Glitch Text'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,

        title: DesignSystem.transformativeText(text: widget.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ListTile(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const TextsSample()),
                );
              },
              title: Text('Texts'),
              trailing: const Icon(Icons.arrow_forward_ios),
            ),
            ListTile(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ParallaxImagesExample(),
                  ),
                );
              },
              title: Text('Parallax Images'),
              trailing: const Icon(Icons.arrow_forward_ios),
            ),
            ListTile(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ExpandedTest()),
                );
              },
              title: Text('Expanded Content Example'),
              trailing: const Icon(Icons.arrow_forward_ios),
              subtitle: Text('This is a simple example of an expanded widget.'),
            ),
            ListTile(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ButtonsExample(),
                  ),
                );
              },
              title: Text('Buttons Example'),
              trailing: const Icon(Icons.arrow_forward_ios),
            ),
            DesignSystem.liveTime(child: Text('data')),
            ListTile(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const DummyTexts()),
                );
              },
              title: Text('Dummy Texts Example'),
              trailing: const Icon(Icons.arrow_forward_ios),
              subtitle: Text('This is a simple example of a text widget.'),
            ),
            ListTile(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const DummyAudioPlayer(),
                  ),
                );
              },
              title: Text('Audio Player Example'),
              trailing: const Icon(Icons.arrow_forward_ios),
              subtitle: Text(
                'This is a simple example of an audio player widget.',
              ),
            ),
            ListTile(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const DummyConversation(),
                  ),
                );
              },
              title: Text('Chat Bubble Example'),
              trailing: const Icon(Icons.arrow_forward_ios),
              subtitle: Text(
                'This is a simple example of a chat bubble widget.',
              ),
            ),
            const SizedBox(height: 20),
            ListTile(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const DummyContainers(),
                  ),
                );
              },
              title: Text('Dummy Texts Example'),
              trailing: const Icon(Icons.arrow_forward_ios),
              subtitle: Text('This is a simple example of a text widget.'),
            ),
            ListTile(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ContainersSample(),
                  ),
                );
              },
              title: Text('Containers Samples'),
              trailing: const Icon(Icons.arrow_forward_ios),
              subtitle: Text('This is a simple example of a text widget.'),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
