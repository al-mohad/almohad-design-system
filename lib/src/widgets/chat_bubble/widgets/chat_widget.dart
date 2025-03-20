import 'package:flutter/material.dart';
import 'package:flutter_design_system/src/widgets/chat_bubble/models/message.dart';

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
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 1),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment:
            isSender ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          if (!isSender && showAvatar)
            CircleAvatar(
              radius: 16,
              backgroundImage: NetworkImage(message.senderAvatar ?? ''),
              child: message.senderAvatar == null ? Icon(Icons.person) : null,
            ),
          SizedBox(width: showAvatar ? 8 : 0),
          Column(
            crossAxisAlignment:
                isSender ? CrossAxisAlignment.end : CrossAxisAlignment.start,
            children: [
              Card(
                margin: EdgeInsets.all(2),
                color:
                    bubbleColor ??
                    (isSender ? Colors.blue[100] : Colors.grey[300]),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(12),
                    topRight: Radius.circular(12),
                    bottomLeft: Radius.circular(isSender ? 12 : 4),
                    bottomRight: Radius.circular(isSender ? 4 : 12),
                  ),
                ),
                child: Container(
                  constraints: BoxConstraints(
                    maxWidth: MediaQuery.of(context).size.width * 0.8,
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                    child: Wrap(
                      alignment: WrapAlignment.end,
                      children: [
                        ChatMessageText(
                          text: message.message,
                          onHashtagTapped: onHashtagTapped,
                          onTagTapped: onTagTapped,
                          onUrlTapped: onUrlTapped,
                          textStyle: messageTextStyle,
                        ),
                        TimeStatusWidget(
                          message: message,
                          textStyle: timeTextStyle,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
