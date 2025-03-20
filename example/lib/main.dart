import 'package:example/dummy_containers.dart';
import 'package:example/dummy_texts.dart';
import 'package:example/parallax_images.dart';
import 'package:flutter/material.dart';

import 'chat_messages_sample.dart';
import 'dummY_audio_player.dart';
import 'expanded_test.dart';

void main() {
  runApp(const MyApp());
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
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
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
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,

        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
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
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
