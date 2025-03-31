import 'package:almohad_design_system/almohad_design_system.dart';
import 'package:flutter/material.dart';

class ContainersSample extends StatelessWidget {
  const ContainersSample({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('containers')),
      body: SingleChildScrollView(
        child: Column(
          children: [
            AnimatedInfoButton(
              primaryTitle: 'Continue',
              // secondaryTitle: 'Cancel',
              title: 'Are you sure?',
              animationCurve: Curves.easeInOut,
              description:
                  'Delectus sunt aperiam deserunt fugiat architecto dolore ut. Cum illum iusto est porro vel sunt laboriosam quo qui. Sed debitis corrupti rerum. Qui quo numquam quidem maiores quia. Animi aliquam voluptatem consequuntur.',
            ),
            DesignSystem.container(
              child: Text("Isometric Style"),
              style: ContainerStyle.isometric,
              color: Colors.blueGrey,
              borderRadius: 16,
              elevation: 12,
              height: 100,
              width: 200,
            ),
            DesignSystem.container(
              child: Text("Cyberpunk", style: TextStyle(color: Colors.white)),
              style: ContainerStyle.cyberpunk,
              color: Colors.purpleAccent,
              borderRadius: 8,
              elevation: 15,
              height: 120,
              width: 220,
              blurRadius: 20, // Custom blur radius
              spreadRadius: 5, // Custom spread radius
            ),
            DesignSystem.container(
              child: Text("Depth Effect"),
              style: ContainerStyle.depth,
              color: Colors.deepPurple,
              borderRadius: 12,
              elevation: 20,
              height: 100,
              width: 200,
            ),
            DesignSystem.container(
              child: Text("Retro Futurism"),
              style: ContainerStyle.retroFuturism,
              color: Colors.teal,
              borderRadius: 20,
              elevation: 10,
              height: 110,
              width: 230,
            ),
            DesignSystem.container(
              child: Text("Skeuomorphism"),
              style: ContainerStyle.skeuomorphism,
              color: Colors.brown,
              borderRadius: 15,
              elevation: 8,
              height: 100,
              width: 200,
            ),
            DesignSystem.container(
              child: Text("Skeuomorphism"),
              style: ContainerStyle.dottedBorder,
              color: Colors.brown,
              borderRadius: 15,
              elevation: 8,
              height: 100,
              width: 200,
            ),
            DesignSystem.container(
              child: Text("Dashed Border Container"),
              height: 100,
              width: 200,
              margin: EdgeInsets.all(2),
              style: ContainerStyle.dashedBorder, // Using the new style
              strokeWidth: 2,
              dashPattern: [10, 5], // Custom dash pattern
              color: Colors.blueAccent.shade100,
            ),
          ],
        ),
      ),
    );
  }
}
