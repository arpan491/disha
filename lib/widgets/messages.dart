import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'message_bubble.dart';

class Messages extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('chat')
          .orderBy('createdAt', descending: true)
          .snapshots(),
      builder: (ctx, chatSnapshot) {
        if (chatSnapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else {
          final chatDocs = (chatSnapshot.data as QuerySnapshot).docs;
          return Expanded(
            child: ListView.builder(
              reverse: true,
              itemBuilder: (_, i) {
                return MessageBubble(
                    chatDocs[i]['text'], chatDocs[i]['userId'] == user!.uid,
                    key: ValueKey(chatDocs[i].id));
              },
              itemCount: chatDocs.length,
            ),
          );
        }
      },
    );
  }
}
