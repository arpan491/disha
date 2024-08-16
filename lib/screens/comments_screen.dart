import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as tAgo;

class CommentPage extends StatefulWidget {
  const CommentPage({Key? key, required this.documentid}) : super(key: key);
  final String documentid;
  @override
  State<CommentPage> createState() => _CommentPageState();
}

class _CommentPageState extends State<CommentPage> {
  var commentController = TextEditingController();

  addComment() async {
    FocusScope.of(context).unfocus();
    var firebaseUser = FirebaseAuth.instance.currentUser;
    CollectionReference usercollection =
        FirebaseFirestore.instance.collection('users');
    CollectionReference forumCollection =
        FirebaseFirestore.instance.collection('forums');
    final userDoc = await usercollection.doc(firebaseUser!.uid).get();
    forumCollection.doc(widget.documentid).collection('comments').doc().set({
      'comment': commentController.text,
      'name': userDoc['name'],
      'uid': userDoc['uid'],
      'profilepic': userDoc['profilepic'],
      'time': DateTime.now(),
    });
    DocumentSnapshot commentCount =
        await forumCollection.doc(widget.documentid).get();
    forumCollection.doc(widget.documentid).update({
      'commentCount': commentCount['commentCount'] + 1,
    });
    commentController.clear();
  }

  CollectionReference forumCollection =
      FirebaseFirestore.instance.collection('forums');
  @override
  Widget build(BuildContext context) {
    // CollectionReference usercollection =
    // FirebaseFirestore.instance.collection('users');
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add comment'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SingleChildScrollView(
              physics: const ScrollPhysics(),
              child: SizedBox(
                height: MediaQuery.of(context).size.height - 150,
                child: Column(
                  children: [
                    Expanded(
                      child: StreamBuilder(
                        stream: forumCollection
                            .doc(widget.documentid)
                            .collection('comments')
                            .snapshots(),
                        builder: (context, snapshot) {
                          if (!snapshot.hasData) {
                            return const Center(
                                child: CircularProgressIndicator());
                          }
                          return ListView.builder(
                              shrinkWrap: true,
                              itemCount:
                                  (snapshot.data as QuerySnapshot).docs.length,
                              itemBuilder: (context, index) {
                                DocumentSnapshot commentdoc =
                                    (snapshot.data as QuerySnapshot)
                                        .docs[index];
                                return ListTile(
                                  leading: CircleAvatar(
                                    backgroundImage:
                                        NetworkImage(commentdoc['profilepic']),
                                    backgroundColor: Colors.white,
                                  ),
                                  title: Row(
                                    children: [
                                      Text(
                                        commentdoc['name'],
                                        style: const TextStyle(fontSize: 20),
                                      ),
                                      const SizedBox(
                                        width: 15.0,
                                      ),
                                      Text(
                                        commentdoc['comment'],
                                        style: const TextStyle(
                                          fontSize: 20,
                                          color: Colors.grey,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                  subtitle: Text(
                                    tAgo
                                        .format(commentdoc['time'].toDate())
                                        .toString(),
                                    style: TextStyle(fontSize: 15),
                                  ),
                                );
                              });
                        },
                      ),
                    ),
                    const Divider(),
                  ],
                ),
              ),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(
                  child: ListTile(
                    title: TextFormField(
                      controller: commentController,
                      decoration: const InputDecoration(
                        hintText: "Add a comment..",
                        hintStyle: TextStyle(fontSize: 18),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                      ),
                    ),
                    trailing: OutlinedButton(
                      onPressed: () => addComment(),
                      child: const Text(
                        "Publish",
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
