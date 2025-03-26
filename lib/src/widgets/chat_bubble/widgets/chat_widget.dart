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
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment:
            isSender ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          if (!isSender && showAvatar) _buildAvatar(),
          const SizedBox(width: 8),
          _buildChatBubble(context),
        ],
      ),
    );
  }

  /// Builds the sender's avatar, shown only if `isSender` is `false`
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

  /// Builds the chat bubble with text and status
  Widget _buildChatBubble(BuildContext context) {
    return Column(
      crossAxisAlignment:
          isSender ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
        Card(
          margin: const EdgeInsets.all(2),
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
          child: _buildMessageContent(context),
        ),
      ],
    );
  }

  /// Message content including text, hashtags, and status
  Widget _buildMessageContent(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        maxWidth: MediaQuery.of(context).size.width * 0.8,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ChatMessageText(
              text: message.message,
              onHashtagTapped: onHashtagTapped,
              onTagTapped: onTagTapped,
              onUrlTapped: onUrlTapped,
              textStyle: messageTextStyle,
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: TimeStatusWidget(
                message: message,
                textStyle: timeTextStyle,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
