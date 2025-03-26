import 'package:almohad_design_system/almohad_design_system.dart';
import 'package:flutter/material.dart';

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
          collapsedContent: Center(
            child: Text('Drag this widget up to expand'),
          ),
        ),
      ),
    );
  }
}
