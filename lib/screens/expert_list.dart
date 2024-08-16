import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../widgets/expert_card.dart';

class ExpertListScreen extends StatelessWidget {
  static const routeName = 'expert-list';
  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    return Scaffold(
      appBar: AppBar(title: Text('Find Experts')),
      body: FutureBuilder(
          future: FirebaseFirestore.instance
              .collection('users')
              .doc(user!.uid)
              .get(),
          builder: (context, userSnapshot) {
            if (userSnapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else {
              final data = userSnapshot.data as DocumentSnapshot;
              return StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('experts')
                      .snapshots(),
                  builder: (ctx, expertSnapshot) {
                    if (expertSnapshot.connectionState ==
                        ConnectionState.waiting) {
                      return CircularProgressIndicator();
                    } else {
                      final expertDocs =
                          (expertSnapshot.data as QuerySnapshot).docs;
                      return ListView.builder(
                          itemBuilder: (_, i) {
                            return ExpertCard(
                              userName: data['name'],
                              userEmail: data['email'],
                              userId: user.uid,
                              expertName: expertDocs[i]['name'],
                              expertEmail: expertDocs[i]['email'],
                              expertId: expertDocs[i]['uid'],
                            );
                          },
                          itemCount: expertDocs.length,
                        
                      );
                    }
                  });
            }
          }),
    );
  }
}
