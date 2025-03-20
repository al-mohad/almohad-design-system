import 'package:flutter/material.dart';
import 'package:almohad_design_system/almohad_design_system.dart';

class DummyTexts extends StatelessWidget {
  const DummyTexts({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Dummy Texts')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Dummy Texts'),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('This is a dummy text.'),
            ),
            DesignSystem.textField(
              label: 'Email Address',
              hintText: 'almohad@hey.com',
              prefixIcon: Icons.email,
            ),
            DesignSystem.textField(
              label: 'Password',
              hintText: 'Enter your password',
              obscureText: true,
              prefixIcon: Icons.lock,
              suffixIcon: Icons.visibility,
            ),
          ],
        ),
      ),
    );
  }
}
