import 'package:almohad_design_system/src/widgets/chat_input/front_widget.dart';
import 'package:almohad_design_system/src/widgets/chat_input/send_button.dart';
import 'package:flutter/material.dart';

import 'back_widget.dart';

class CustomChatInput extends StatefulWidget {
  final Widget? emojiIcon;
  final Widget? attachmentIcon;
  final Widget? cameraIcon;
  final Widget? audioIcon;
  final Widget? sendIcon;
  final TextEditingController textEditingController;
  final VoidCallback? onEmojiPressed;
  final VoidCallback? onAttachmentPressed;
  final VoidCallback? onCameraPressed;
  final VoidCallback? onRecordPressed;
  final VoidCallback? onSendPressed;
  final String? hintText;
  final TextStyle? textStyle;
  final Function(String?)? onTextChanged;
  final Color? iconColor;
  const CustomChatInput({
    super.key,
    this.emojiIcon,
    this.attachmentIcon,
    this.cameraIcon,
    this.audioIcon,
    this.sendIcon,
    required this.textEditingController,
    this.onEmojiPressed,
    this.onAttachmentPressed,
    this.onCameraPressed,
    this.onRecordPressed,
    this.onSendPressed,
    this.hintText,
    this.textStyle,
    this.onTextChanged,
    this.iconColor,
  });

  @override
  State<CustomChatInput> createState() => _ChatInputState();
}

class _ChatInputState extends State<CustomChatInput> {
  // final TextEditingController widget.textEditingController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 6, bottom: 6, right: 6),
      child: Stack(
        children: [
          Row(
            children: [
              Expanded(
                child: Card(
                  color: Theme.of(context).colorScheme.surface,
                  margin: EdgeInsets.only(right: 6),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Stack(
                    children: [
                      BackWidget(
                        textEditingController: widget.textEditingController,
                      ),
                      FrontWidget(
                        textEditingController: widget.textEditingController,
                        scrollController: _scrollController,
                        onChanged: (v) => widget.onTextChanged!(v),
                      ),
                    ],
                  ),
                ),
              ),
              IconButton(
                onPressed: null,
                icon: Icon(
                  Icons.send,
                  color: widget.iconColor ?? Colors.transparent,
                ),
              ),
            ],
          ),
          Positioned.fill(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Row(
                children: [
                  Spacer(),
                  SendButton(
                    controller: widget.textEditingController,
                    iconColor: widget.iconColor,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
