enum ChatStatus { waiting, sent, delivered, read }

class ChatMessage {
  final String message;
  final String? senderAvatar;
  final ChatStatus status;
  final bool isSender;
  final DateTime time;

  ChatMessage({
    required this.message,
    this.senderAvatar,
    required this.status,
    required this.isSender,
    required this.time,
  });
}
