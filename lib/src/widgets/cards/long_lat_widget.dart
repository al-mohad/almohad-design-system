import 'package:flutter/material.dart';

class LatLongWidget extends StatelessWidget {
  const LatLongWidget({super.key});

  @override
  Widget build(BuildContext context) => Row(
    crossAxisAlignment: CrossAxisAlignment.end,
    mainAxisAlignment: MainAxisAlignment.spaceAround,
    children: [
      Text('12.2442', style: TextStyle(color: Colors.white70)),
      Icon(Icons.location_on, color: Colors.white70),
      Text('-23.23412', style: TextStyle(color: Colors.white70)),
    ],
  );
}
