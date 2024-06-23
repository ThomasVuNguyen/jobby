import 'package:flutter/material.dart';
import 'package:jobby/chatPage/chat_page.dart';

class EmployerConversation extends StatelessWidget {
  const EmployerConversation({super.key, required this.answers});
  final Map<String, String> answers;
  @override
  Widget build(BuildContext context) {
    return chatPage(
        questions: {
          'question' :['hi there']
        },
        answers: answers,
        title: 'Employer interest');
  }
}
