import 'package:flutter/material.dart';
import 'package:jobby/chatPage/firebase_functions.dart';

class ExperiencePicker extends StatelessWidget {
  const ExperiencePicker({super.key, required this.job_title, required this.experience});
  final String job_title; final String experience;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Experience level picker'),
      ),
      body: FutureBuilder(
        future: add_user_msg(job_title, experience),
        builder: (context, snapshot){
          if(snapshot.connectionState == ConnectionState.done){
            String doc_id = snapshot.data!;
            print('doc id is $doc_id');
            return StreamBuilder(stream: listenToResponse(doc_id), builder: (context, snapshot){
              //return Center(child: Text(snapshot.connectionState.toString()),);
              if(snapshot.connectionState == ConnectionState.active){
                String experience_list_text = snapshot.data!['response']!.replaceAll(".", "");
                print('experience list is $experience_list_text');
                List<String> experience_list = experience_list_text.split(',');
                return ListView.builder(
                  itemCount: experience_list.length,
                    itemBuilder: (context, index){
                    return ListTile(
                      title: Text(experience_list[index]),
                    );
                    }
                );
              }
              else if(snapshot.hasError){
                return const Center(child: Text('error'),);
              }
              else{
                return Center(child: CircularProgressIndicator(),);
              }
            });
          }
          else{
            return const Center(child: CircularProgressIndicator(),);
          }
        },
      )
    );
  }
}
