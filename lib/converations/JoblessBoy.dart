import 'package:flutter/material.dart';
import 'package:jobby/chatPage/chat_page.dart';

class JoblessBoy extends StatelessWidget {
  const JoblessBoy({super.key, required this.answers});
  final Map<String, String> answers;
  @override
  Widget build(BuildContext context) {
    return chatPage(
        questions: {
          //add multiple job functionality
          'job_preference': ['Thank you for using Jobby', 'What is a job you would like to have?'],
          'current_experience': ['What experience do you have in this field?'],
          'time_available': ['Do you have any time available to prepare for a job application?']
        },
        answers: answers,
        title: 'Help you get a job');
  }
}
