
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';


Future<void> add_conversation(Map<String, String> userAnswer, BuildContext context) async{
  var db = FirebaseFirestore.instance;
  print('convo to be added $userAnswer');
  DateTime now = DateTime.now();
  String id = now.millisecondsSinceEpoch.toString();
  try{
    await db.collection("conversations").doc(id).set(userAnswer);
  } catch (e){
    print('error $e');
  }
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('conversation saved!')));
}