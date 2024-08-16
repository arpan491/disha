import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../widgets/messages.dart';
import '../widgets/new_message.dart';

class ChatScreen extends StatefulWidget {
  static const routeName = '/chat-screen';
  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  static const routeName = '/chat-screen';
  // void initState() {
  //   super.initState();
  //   final fbm = FirebaseMessaging.instance;
  //   fbm.requestPermission();
  //   FirebaseMessaging.onMessage.listen((message) {
  //     print(message);
  //     return;
  //   });
  //   FirebaseMessaging.onMessageOpenedApp.listen((message) {
  //     print(message);
  //     return;
  //   });
  //   fbm.subscribeToTopic('chat');
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Chat Room'),
        ),
        body: Column(
          children: [Messages(), NewMessage()],
        )
        // body: StreamBuilder.builder(
        //   itemBuilder: (ctx, i) => ListTile(title: Text('Hi there')),
        //   itemCount: 10,
        // ),

        // floatingActionButton: FloatingActionButton(
        //   onPressed: () {
        // FirebaseFirestore.instance.collection('chats').add({}).then(
        //   (value) {
        //     FirebaseFirestore.instance
        //         .collection('chats/${value.id}/messages')
        //         .add({
        //       'text': 'Bruh this is awesome',
        //     });
        //     print(value.id);
        //   },
        // );
        //   FirebaseFirestore.instance
        //       .collection('chats/0Vj7CmnGb4s3Nzo9wpU9/messages')
        //       .add({
        //     'text': 'Bruh this is awesome',
        //   });
        // },
        // child: Icon(Icons.add),
        // ),
        );
  }
}
