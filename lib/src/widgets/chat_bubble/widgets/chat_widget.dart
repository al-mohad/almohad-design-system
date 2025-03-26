import 'package:flutter/material.dart';

import '../../../../almohad_design_system.dart';
import 'chat_message_text.dart';

enum ChatWidgetType { text, image, audio }

class ChatWidget extends StatelessWidget {
  final ChatMessage message;
  final bool isSender;
  final bool showAvatar;
  final Function(String)? onHashtagTapped;
  final Function(String)? onTagTapped;
  final Function(String)? onUrlTapped;
  final Function(List<String>, int)? onImagePreview;

  // Customization
  final Color? bubbleColor;
  final Color? textColor;
  final Color? timestampColor;
  final Color? avatarBackgroundColor;
  final double? avatarRadius;
  final EdgeInsets? bubblePadding;
  final EdgeInsets? chatPadding;
  final BorderRadius? bubbleRadius;
  final TextStyle? messageTextStyle;
  final TextStyle? timeTextStyle;
  final TextStyle? usernameTextStyle;

  final ChatWidgetType? chatWidgetType;

  const ChatWidget({
    super.key,
    required this.message,
    required this.isSender,
    this.showAvatar = true,
    this.onHashtagTapped,
    this.onTagTapped,
    this.onUrlTapped,
    this.onImagePreview,
    this.bubbleColor,
    this.textColor,
    this.timestampColor,
    this.avatarBackgroundColor,
    this.avatarRadius = 16,
    this.bubblePadding = const EdgeInsets.symmetric(
      horizontal: 10,
      vertical: 6,
    ),
    this.chatPadding = const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
    this.bubbleRadius,
    this.messageTextStyle,
    this.timeTextStyle,
    this.usernameTextStyle,
    this.chatWidgetType,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: chatPadding!,
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
      radius: avatarRadius,
      backgroundColor: avatarBackgroundColor ?? Colors.grey.shade300,
      backgroundImage:
          message.senderAvatar != null
              ? NetworkImage(message.senderAvatar!)
              : null,
      child:
          message.senderAvatar == null
              ? const Icon(Icons.person, color: Colors.white)
              : null,
    );
  }

  /// Builds the chat bubble with appropriate message content
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
            borderRadius: bubbleRadius ?? BorderRadius.circular(12),
          ),
          child: Padding(
            padding: bubblePadding!,
            child: _buildMessageContent(context),
          ),
        ),
      ],
    );
  }

  /// Decides which content to show (text, image, or audio)
  Widget _buildMessageContent(BuildContext context) {
    switch (chatWidgetType) {
      case ChatWidgetType.text:
        return _buildTextMessage();
      case ChatWidgetType.audio:
        return _buildAudioMessage();
      case ChatWidgetType.image:
        return _buildImageMessage(context);
      default:
        return _buildTextMessage(); // Fallback to text
    }
  }

  /// Builds a text message
  Widget _buildTextMessage() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ChatMessageText(
          text: message.message,
          onHashtagTapped: onHashtagTapped,
          onTagTapped: onTagTapped,
          onUrlTapped: onUrlTapped,
          textStyle:
              messageTextStyle ?? TextStyle(color: textColor ?? Colors.black),
        ),
        Align(
          alignment: Alignment.bottomRight,
          child: Text(
            CustomDateHelper.formatDate(message.time),
            style:
                timeTextStyle ??
                TextStyle(color: timestampColor ?? Colors.grey, fontSize: 12),
          ),
        ),
      ],
    );
  }

  /// Builds an audio message with an inline player
  Widget _buildAudioMessage() {
    return Column(
      children: [
        DesignSystem.audioPlayer(
          isSender: isSender,
          audioUrl: message.audioUrl ?? '',
          audioTitle: 'Voice Message',
          showUserAvatar: !isSender && showAvatar,
          userAvatar: message.senderAvatar,
          backgroundColor: Colors.blue.shade200,
          doneColor: Colors.green,
          time: message.time,
          status: message.status,
        ),
      ],
    );
  }

  /// Builds an image message with a preview feature
  Widget _buildImageMessage(BuildContext context) {
    final images = message.imageUrls ?? [];
    return Wrap(
      spacing: 4,
      runSpacing: 4,
      children: [
        for (int i = 0; i < (images.length > 3 ? 3 : images.length); i++)
          _buildImageThumbnail(images, i),
        if (images.length > 3) _buildMoreImagesOverlay(images),
      ],
    );
  }

  /// Builds a single image thumbnail
  Widget _buildImageThumbnail(List<String> images, int index) {
    return GestureDetector(
      onTap: () => onImagePreview?.call(images, index),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Image.network(
          images[index],
          width: 80,
          height: 80,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  /// Shows `+X more` overlay when more than 4 images exist
  Widget _buildMoreImagesOverlay(List<String> images) {
    return GestureDetector(
      onTap: () => onImagePreview?.call(images, 3),
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(
              images[3],
              width: 80,
              height: 80,
              fit: BoxFit.cover,
            ),
          ),
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.6),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(
              child: Text(
                "+${images.length - 3} more",
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
