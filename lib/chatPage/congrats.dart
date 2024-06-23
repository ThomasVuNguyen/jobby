import 'package:flutter/material.dart';

class congratPage extends StatelessWidget {
  const congratPage({super.key, required this.title});
  final String title;
  @override
  Widget build(BuildContext context) {
    if(title == 'employer'){
      return Scaffold(
        body:
        Center(child: Text('Congrats for finishing, we will find you cheap labor in no time'),),
      );
    }
    else{
      return Scaffold(
        body:
        Center(child: Text('Congrats, you will finally have a job to pay child support'),),
      );
    }

  }
}
