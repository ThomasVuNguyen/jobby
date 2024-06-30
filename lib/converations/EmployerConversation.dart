import 'package:flutter/material.dart';
import 'package:jobby/chatPage/chat_page.dart';

class EmployerConversation extends StatelessWidget {
  const EmployerConversation({super.key, required this.answers});
  final Map<String, String> answers;
  @override
  Widget build(BuildContext context) {
    return chatPage(
        questions: {
          'industry' :['What industry are you in?'],
          'employee_type':['What type of employee do you need (junior or senior)?'],
          'salary': ['What is your budget for employee\'s salary?'],
        },
        answers: answers,
        title: 'Employer interest');
  }
}
