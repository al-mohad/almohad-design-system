import 'package:flutter/material.dart';
import 'package:almohad_design_system/almohad_design_system.dart';

class DummyConversation extends StatelessWidget {
  const DummyConversation({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Chat Messages')),
      body: Column(
        children: [
          DesignSystem.chatBubble(
            message: ChatMessage(
              message:
                  'Hey @john, check their website https://example.com and give me feedback. #designReview',
              status: ChatStatus.sent,
              isSender: false,
              time: DateTime.now().subtract(Duration(minutes: 15)),
            ),
            isSender: false,
          ),
          DesignSystem.chatBubble(
            message: ChatMessage(
              message: 'I will check it out. Also, have you seen #UIUpdate?',
              status: ChatStatus.waiting,
              isSender: true,
              time: DateTime.now().subtract(Duration(minutes: 12)),
            ),
            isSender: true,
          ),
          DesignSystem.chatBubble(
            message: ChatMessage(
              message: 'Not yet! Can you send me the link?',
              status: ChatStatus.sent,
              isSender: false,
              time: DateTime.now().subtract(Duration(minutes: 10)),
            ),
            isSender: false,
          ),
          DesignSystem.chatBubble(
            message: ChatMessage(
              message: 'Sure! Here it is: https://uiexamples.com/update',
              status: ChatStatus.delivered,
              isSender: true,
              time: DateTime.now().subtract(Duration(minutes: 9)),
            ),
            isSender: true,
          ),
          DesignSystem.chatBubble(
            message: ChatMessage(
              message:
                  'Looks great! Also, call me at +1 234 567 8900 when free.',
              status: ChatStatus.read,
              isSender: false,
              time: DateTime.now().subtract(Duration(minutes: 7)),
            ),
            isSender: false,
          ),
          DesignSystem.chatBubble(
            message: ChatMessage(
              message: 'Will do! Let me just wrap up #featureTesting.',
              status: ChatStatus.read,
              isSender: true,
              time: DateTime.now().subtract(Duration(minutes: 5)),
            ),
            isSender: true,
          ),
          DesignSystem.chatBubble(
            message: ChatMessage(
              message: 'Sounds good! Ping me at @mike if you need help.',
              status: ChatStatus.sent,
              isSender: false,
              time: DateTime.now().subtract(Duration(minutes: 3)),
            ),
            isSender: false,
          ),
          DesignSystem.chatBubble(
            message: ChatMessage(
              message: 'Thanks! Talk soon.',
              status: ChatStatus.read,
              isSender: true,
              time: DateTime.now().subtract(Duration(minutes: 1)),
            ),
            isSender: true,
          ),
        ],
      ),
    );
  }
}
