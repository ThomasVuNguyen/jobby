import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

var db = FirebaseFirestore.instance;

Future<String> add_user_msg(String job_title, String experience) async{
  String message = 'Hello there, this person is looking for a job title of $job_title, currently they have these experiences $experience, can you list all possible experiences needed for this type of job? Only output all the experiences by name and separated by comma';
  final msg = <String, String>{
    "prompt": message,
  };
  DateTime now = DateTime.now();

  // Convert the current time to milliseconds since Unix epoch
  String id = now.millisecondsSinceEpoch.toString();
  try{
    await db.collection("generate").doc(id).set(msg);
  } catch (e){
    print('error $e');
  }
  return id;
}


Stream<DocumentSnapshot<Map<String, dynamic>>> listenToResponse(String id) {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  return firestore
      .collection('generate')
      .doc(id)
      .snapshots()
      .where((snapshot) => snapshot.exists && snapshot.data()!.containsKey('response'));
}


