enum ChatStatus { waiting, sent, delivered, read }

class ChatMessage {
  final String message;
  final String? audioUrl;
  final List<String>? imageUrls;
  final String? senderAvatar;
  final ChatStatus status;
  final DateTime time;

  ChatMessage({
    required this.message,
    this.senderAvatar,
    required this.status,
    this.audioUrl,
    this.imageUrls,
    required this.time,
  });
}
