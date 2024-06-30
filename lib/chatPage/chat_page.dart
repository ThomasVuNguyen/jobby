import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:jobby/chatPage/congrats.dart';
import 'package:jobby/converations/EmployeeCoversation.dart';
import 'package:jobby/converations/EmployerConversation.dart';
import 'package:jobby/converations/PotentialCandidatesPage.dart';
import 'package:jobby/database_function/function.dart';
import 'package:uuid/uuid.dart';

import '../converations/ExperiencePicker.dart';
import '../converations/JoblessBoy.dart';

class chatPage extends StatefulWidget {
  const chatPage({super.key, required this.questions, required this.answers, required this.title});
  final Map<String, List<String>> questions; final Map<String, String> answers; final String title;


  @override
  State<chatPage> createState() => _chatPageState();
}

class _chatPageState extends State<chatPage> {
  bool _questionAnswered = false;
  Map<String, String> userAnswer = {};
  final _user = const types.User(
    id: 'currentUser',
    role: types.Role.user,
  );
  final _comfyHelper = const types.User(
      id: 'comfyHelper',
      role: types.Role.admin,
      imageUrl: 'https://comfystudio.tech/chilling-in-the-park.jpg'
  );
  List<types.Message> _messages = [];

  @override
  void initState() {
    userAnswer.addAll(widget.answers);
    _conversationSequence();
    super.initState();
  }

  Future<void> _conversationSequence() async{
    //Loop through the map of conversation
    Map<String, List<String>> questionMap = widget.questions;
    for(var title in questionMap.keys) {
      List<String> questions = questionMap[title]!;
      //Send all questions in the question
      await Future.delayed(Duration(milliseconds: 200));
      for (final question in questions){
        //Send each question one by one
        _sendAdminMessage(question);
        await Future.delayed(Duration(milliseconds: 200));
        print(question);
      }
      //await for response
      while (!_questionAnswered) {
        await Future.delayed(Duration(milliseconds: 100));
      }
      //log response
      userAnswer[title] = _messages.first.toJson()['text'];
      print(userAnswer[title]);

      // Send confirmation message
      //_sendAdminMessage("$title is ${userAnswer[title]}, confirmed");

      //ask the next questions (continue loop)
    };
    if (kDebugMode) {
      print(userAnswer.toString());
    }
    _moveToNextPage();
  }
  Future<void> _moveToNextPage() async {
    if(widget.title == 'Employment Status'){
      var answer = userAnswer['employment_status'];
      print('Answer to employment status is $answer');
      if(answer?.toLowerCase().contains('employer') == true){
        Navigator.push(context, MaterialPageRoute(builder: (context) => EmployerConversation(answers: userAnswer)
        ));
      }
      else{
        Navigator.push(context, MaterialPageRoute(builder: (context) => Employeecoversation(answers: userAnswer)));
      }
    }
    else if(widget.title == 'Employer interest'){
      await add_conversation(userAnswer, context);
      Navigator.push(context, MaterialPageRoute(builder: (context) => CheapLaborPage()));
    }
    else if(widget.title == 'Tryin to get you a job'){
      await add_conversation(userAnswer, context);
      Navigator.push(context, MaterialPageRoute(builder: (context) => ExperiencePicker(
        job_title: userAnswer['job_title']!, experience: userAnswer['current_experience']!,
      )));
    }

  }
  void _sendAdminMessage(String msg){
    final textMessage = types.TextMessage(
      author: _comfyHelper,
      createdAt: DateTime.now().millisecondsSinceEpoch,
      id: const Uuid().v4(),
      text: msg,
    );
    setState(() {
      _messages.insert(0, textMessage);
      _questionAnswered = false;
    });
  }

  void _sendUserMessage(String msg){
    final textMessage = types.TextMessage(
      author: _user,
      createdAt: DateTime.now().millisecondsSinceEpoch,
      id: const Uuid().v4(),
      text: msg,
    );

    setState(() {
      _messages.insert(0, textMessage);
      _questionAnswered = true;
    });
  }
  void _handleSendPressed(types.PartialText message) {
    _sendUserMessage(message.text);
    //_questionAnswered = true;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title, style: Theme.of(context).textTheme.titleLarge),
        centerTitle: true,

      ),
      body: Chat(
          messages: _messages,
          onSendPressed: _handleSendPressed,
          user: _user,
          showUserAvatars: true,
          theme: DefaultChatTheme(
              primaryColor: Theme.of(context).colorScheme.primary,
              secondaryColor:
              //Theme.of(context).colorScheme.secondary,
              Theme.of(context).colorScheme.onPrimary,
              backgroundColor: Theme.of(context).colorScheme.surface,
              inputTextStyle: Theme.of(context).textTheme.bodyMedium!,
              inputTextColor: Theme.of(context).colorScheme.surface,
              receivedMessageBodyTextStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(color: Theme.of(context).colorScheme.onSurface),
              sentMessageBodyTextStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(color: Theme.of(context).colorScheme.surface),
              inputBackgroundColor: Theme.of(context).colorScheme.primary
          )
      ),
    );
  }
}