import 'package:flutter/material.dart';
import 'package:jobby/chatPage/chat_page.dart';

class EmployerEmployeePage extends StatefulWidget {
  const EmployerEmployeePage({super.key});

  @override
  State<EmployerEmployeePage> createState() => _EmployerEmployeePageState();
}

class _EmployerEmployeePageState extends State<EmployerEmployeePage> {
  @override
  Widget build(BuildContext context) {
    return chatPage(
        questions: {
          'employment_status': ['Hey there, cool humans!', 'Are you an employer or looking for a job?']
        },
        answers: {},
        title: 'Employment Status');
  }
}
