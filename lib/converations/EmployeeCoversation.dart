import 'package:flutter/material.dart';
import 'package:jobby/chatPage/chat_page.dart';

class Employeecoversation extends StatelessWidget {
  const Employeecoversation({super.key, required this.answers});
  final Map<String, String> answers;
  @override
  Widget build(BuildContext context) {
    return chatPage(
        questions: {
          'job_title': ['What type of job world you like?'],
          'education_level':['What is your highest level of education? (highschool or bachelor, master\'s, or phD)'],
          'current_experience': ['Briefly list out the experiences you currently have'],

        },
        answers: answers,
        title: 'Tryin to get you a job');
  }
}
