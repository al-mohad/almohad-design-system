import 'package:almohad_design_system/src/widgets/images/dynamic_image_grid.dart';
import 'package:flutter/material.dart';

import '../../../../almohad_design_system.dart';
import 'chat_message_text.dart';

enum ChatWidgetType { text, image, audio }

enum ImageViewType { grid, list }

class ChatWidget extends StatelessWidget {
  final ChatMessage message;
  final bool isSender;
  final bool showAvatar;
  final Function(String)? onHashtagTapped;
  final Function(String)? onTagTapped;
  final Function(String)? onUrlTapped;
  final Function(List<String>, int)? onImagePreview;

  // Customization properties
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

  // Message type and image view type
  final ChatWidgetType? chatWidgetType;
  final ImageViewType? imageViewType;

  // Optional custom dimensions for image thumbnails in grid or list view.
  final double? imageThumbnailWidth;
  final double? imageThumbnailHeight;
  final double? listImageHeight;

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
    this.bubblePadding,
    this.chatPadding,
    this.bubbleRadius,
    this.messageTextStyle,
    this.timeTextStyle,
    this.usernameTextStyle,
    this.chatWidgetType,
    this.imageViewType,
    this.imageThumbnailWidth,
    this.imageThumbnailHeight,
    this.listImageHeight,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          chatPadding ??
          const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment:
            isSender ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          if (!isSender && showAvatar) _buildAvatar(),
          const SizedBox(width: 8),
          Flexible(
            // 💡 Ensure the bubble doesn't overflow
            child: _buildChatBubble(context),
          ),
        ],
      ),
    );
  }

  /// Builds the sender's avatar; shown only if `isSender` is false.
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

  /// Builds the chat bubble with the appropriate message content.
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
            padding:
                bubblePadding ??
                const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            child: _buildMessageContent(context),
          ),
        ),
      ],
    );
  }

  /// Decides which content to show (text, image, or audio).
  Widget _buildMessageContent(BuildContext context) {
    switch (chatWidgetType) {
      case ChatWidgetType.text:
        return _buildTextMessage();
      case ChatWidgetType.audio:
        return _buildAudioMessage();
      case ChatWidgetType.image:
        return _buildImageMessage(context);
      default:
        return _buildTextMessage(); // Fallback to text message.
    }
  }

  /// Builds a text message.
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

  /// Builds an audio message with an inline player.
  Widget _buildAudioMessage() {
    return DesignSystem.audioPlayer(
      isSender: isSender,
      audioUrl: message.audioUrl ?? '',
      audioTitle: 'Voice Message',
      showUserAvatar: !isSender && showAvatar,
      userAvatar: message.senderAvatar,
      backgroundColor: Colors.blue.shade200,
      doneColor: Colors.green,
      time: message.time,
      status: message.status,
    );
  }

  /// Builds an image message, supporting both grid and list view layouts.
  Widget _buildImageMessage(BuildContext context) {
    final images = message.imageUrls ?? [];
    if (imageViewType == ImageViewType.list) {
      // List view: each image in its own row.
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children:
            images.map((url) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: GestureDetector(
                  onTap:
                      () => onImagePreview?.call(images, images.indexOf(url)),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.network(
                      url,
                      width: MediaQuery.of(context).size.width * 0.8,
                      height: listImageHeight ?? 150,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              );
            }).toList(),
      );
    } else {
      return SizedBox(
        height: 200,
        width: 200,
        child: DynamicImageGrid(imageUrls: images),
      );
    }
  }
}
