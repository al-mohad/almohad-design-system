import 'package:almohad_design_system/src/widgets/chat_bubble/models/message.dart';
import 'package:flutter/material.dart';

import 'chat_message_text.dart';
import 'time_status_widget.dart' show TimeStatusWidget;

class ChatWidget extends StatelessWidget {
  final ChatMessage message;
  final bool isSender;
  final bool showAvatar;
  final Function(String)? onHashtagTapped;
  final Function(String)? onTagTapped;
  final Function(String)? onUrlTapped;
  final Color? bubbleColor;
  final TextStyle? messageTextStyle;
  final TextStyle? timeTextStyle;

  const ChatWidget({
    super.key,
    required this.message,
    required this.isSender,
    this.showAvatar = true,
    this.onHashtagTapped,
    this.onTagTapped,
    this.onUrlTapped,
    this.bubbleColor,
    this.messageTextStyle,
    this.timeTextStyle,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
      child: Row(
        mainAxisAlignment:
            isSender ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if (!isSender && showAvatar) _buildAvatar(),
          const SizedBox(width: 8),
          _buildMessageBubble(context),
        ],
      ),
    );
  }

  /// Builds the sender/receiver avatar.
  Widget _buildAvatar() {
    return CircleAvatar(
      radius: 16,
      backgroundImage:
          message.senderAvatar != null
              ? NetworkImage(message.senderAvatar!)
              : null,
      child: message.senderAvatar == null ? const Icon(Icons.person) : null,
    );
  }

  /// Builds the chat bubble UI.
  Widget _buildMessageBubble(BuildContext context) {
    return Column(
      crossAxisAlignment:
          isSender ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
        Card(
          margin: EdgeInsets.zero,
          color:
              bubbleColor ?? (isSender ? Colors.blue[100] : Colors.grey[300]),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: const Radius.circular(12),
              topRight: const Radius.circular(12),
              bottomLeft: Radius.circular(isSender ? 12 : 4),
              bottomRight: Radius.circular(isSender ? 4 : 12),
            ),
          ),
          child: Container(
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width * 0.75,
            ),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                ChatMessageText(
                  text: message.message,
                  onHashtagTapped: onHashtagTapped,
                  onTagTapped: onTagTapped,
                  onUrlTapped: onUrlTapped,
                  textStyle: messageTextStyle,
                ),
                TimeStatusWidget(message: message, textStyle: timeTextStyle),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
