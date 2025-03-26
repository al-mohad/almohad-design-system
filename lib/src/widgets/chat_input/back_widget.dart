import 'package:almohad_design_system/src/src.dart';
import 'package:flutter/material.dart';

class BackWidget extends StatelessWidget {
  const BackWidget({super.key, required this.textEditingController});
  final TextEditingController textEditingController;

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Row(
          children: [
            IconButton(
              onPressed: () {
                CustomToasts.show(
                  context: context,
                  type: ToastType.info,
                  message: 'Show emojies',
                );
              },
              icon: Icon(Icons.emoji_emotions_outlined),
            ),
            Expanded(
              child: TextField(
                maxLines: null,
                style: TextStyle(color: Colors.transparent),
                decoration: InputDecoration(
                  hintText: "",
                  hintStyle: TextStyle(color: Colors.transparent),
                  border: InputBorder.none,
                ),
              ),
            ),
            IconButton(
              onPressed: () {
                CustomToasts.show(
                  context: context,
                  type: ToastType.info,
                  message: 'Show picker',
                );
              },
              icon: Icon(Icons.attach_file_outlined),
            ),
            if (textEditingController.text.isEmpty)
              IconButton(
                onPressed: () {
                  CustomToasts.show(
                    context: context,
                    type: ToastType.info,
                    message: 'open camera',
                  );
                },
                icon: Icon(Icons.camera_alt_outlined),
              ),
          ],
        ),
      ),
    );
  }
}
