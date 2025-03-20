import 'package:flutter/material.dart';

import 'long_lat_widget.dart';

class ImageWidget extends StatelessWidget {
  const ImageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      /// space from white container
      padding: EdgeInsets.symmetric(horizontal: 16),
      height: size.height * 0.5,
      width: size.width * 0.8,
      child: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(color: Colors.black26, blurRadius: 2, spreadRadius: 1),
          ],
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
        child: Stack(
          children: [
            buildImage(),
            Container(
              padding: const EdgeInsets.all(8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [buildTopText(), LatLongWidget()],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildImage() => SizedBox.expand(
    child: ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(8)),
      child: Image.network('https://i.pravatar.cc/', fit: BoxFit.cover),
    ),
  );

  Widget buildTopText() => Text(
    'Mount Everest',
    style: TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.bold,
      fontSize: 20,
    ),
  );
}
