import 'package:flutter/material.dart';

class SendButton extends StatelessWidget {
  const SendButton({super.key, required this.controller, this.iconColor});

  final TextEditingController controller;
  final Color? iconColor;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPressStart: (details) {},
      onLongPressEnd: (details) {},
      onTap: () {},
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color:
              iconColor ??
              Theme.of(context).primaryColor.withValues(alpha: 0.7),
        ),
        child: IconButton(
          onPressed: null,
          icon: Icon(
            controller.text.trim().isEmpty ? Icons.mic : Icons.send,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
