import 'package:flutter/material.dart';
import 'package:almohad_design_system/almohad_design_system.dart';

class DummyContainers extends StatelessWidget {
  const DummyContainers({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Containers')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Containers'),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: DesignSystem.container(
                child: Text("Flat Container"),
                style: ContainerStyle.flat,
                color: Colors.red,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: DesignSystem.container(
                child: Text("Claymorphism Container"),
                style: ContainerStyle.claymorphism,
                color: Colors.green,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: DesignSystem.container(
                child: Text("Glassmorphism Container"),
                style: ContainerStyle.glassmorphism,
                color: Colors.blue,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: DesignSystem.container(
                child: Text("Custom Container"),
                color: Colors.yellow,
                borderRadius: 20,
                style: ContainerStyle.flat,
                padding: const EdgeInsets.all(32),
                elevation: 20,
                isDarkMode: true,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: DesignSystem.container(
                child: Text("Custom Container"),
                style: ContainerStyle.elevated,
                color: Colors.purple,
                padding: const EdgeInsets.all(32),
              ),
            ),
            DesignSystem.nil,
          ],
        ),
      ),
    );
  }
}
