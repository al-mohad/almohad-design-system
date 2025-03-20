import 'package:flutter/material.dart';
import 'package:flutter_design_system/flutter_design_system.dart';

class ExpandedTest extends StatefulWidget {
  const ExpandedTest({super.key});

  @override
  State<ExpandedTest> createState() => _ExpandedTestState();
}

class _ExpandedTestState extends State<ExpandedTest> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      appBar: AppBar(title: Text('Expanded Test')),
      body: Center(
        child: DesignSystem.expandedContent(
          expandedChildren: [
            Text('Expanded Content 1'),
            Text('Expanded Content 2'),
            Text('Expanded Content 3'),
            Row(
              children: [
                Text('Expanded Content 4'),
                Text('Expanded Content 5'),
              ],
            ),
          ],
          collapsedContent: Image.network(
            'https://i.pravatar.cc/',
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
