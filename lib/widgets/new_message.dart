import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class NewMessage extends StatefulWidget {
  @override
  State<NewMessage> createState() => _NewMessageState();
}

class _NewMessageState extends State<NewMessage> {
  var message = '';

  final _controller = TextEditingController();
  void sendMessage() {
    FocusScope.of(context).unfocus();
    final user = FirebaseAuth.instance.currentUser;
    FirebaseFirestore.instance
        .collection('chat')
        .add({'text': message, 'createdAt': Timestamp.now(), 'userId': user!.uid});
    setState(() {
      message = '';
    });
    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(
            child: Container(
              // decoration: BoxDecoration(
              //   border: Border.all(color: Colors.grey, width: 1),
              //   borderRadius: BorderRadius.circular(10),
              // ),
              child: TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide(color: Colors.grey, width: 2),
                  ),
                  
                  contentPadding: EdgeInsets.all(10),
                  labelText: 'Send a message....',
                ),
                controller: _controller,
                onChanged: (val) {
                  setState(() {
                    message = val;
                  });
                },
              ),
            ),
          ),
          
          IconButton(
            onPressed: message.isEmpty ? null : sendMessage,
            icon: Icon(Icons.send),
          ),
        ],
      ),
    );
  }
}
