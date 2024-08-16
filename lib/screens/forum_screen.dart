import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modern_form_esys_flutter_share/modern_form_esys_flutter_share.dart';

import '../widgets/new_forum_screen.dart';
import './comments_screen.dart';

class ForumScreen extends StatefulWidget {
  const ForumScreen({Key? key}) : super(key: key);

  static const routeName = '/forum-screen';
  @override
  State<ForumScreen> createState() => _ForumScreenState();
}

class _ForumScreenState extends State<ForumScreen> {
  String? uid;
  @override
  initState() {
    super.initState();
    getCurrentuserUid();
  }

  getCurrentuserUid() async {
    var firebaseuser = FirebaseAuth.instance.currentUser!;
    setState(() {
      uid = firebaseuser.uid;
    });
  }

  likePost(String id) async {
    var firebaseUser = FirebaseAuth.instance.currentUser!;
    CollectionReference forumCollection =
        FirebaseFirestore.instance.collection('forums');
    DocumentSnapshot document = await forumCollection.doc(id).get();
    if (document['likes'].contains(firebaseUser.uid)) {
      forumCollection.doc(id).update({
        'likes': FieldValue.arrayRemove([firebaseUser.uid])
      });
    } else {
      forumCollection.doc(id).update({
        'likes': FieldValue.arrayUnion([firebaseUser.uid])
      });
    }
  }

  sharePost(String id, String forum) async {
    Share.text('Chat Forum', forum, 'text/plain');
    CollectionReference forumCollection =
        FirebaseFirestore.instance.collection('forums');
    DocumentSnapshot document = await forumCollection.doc(id).get();
    forumCollection.doc(id).update({'shares': document['shares'] + 1});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const NewForumScreen(),
          ),
        ),
        child: const Icon(
          Icons.add,
          size: 32,
        ),
      ),
      appBar: AppBar(
        title: Text(
          'Chat Forum',
          style: TextStyle(
            fontSize: 20,
            color: Colors.white,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('forums').snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const CircularProgressIndicator();
            }
            return ListView.builder(
                itemCount: (snapshot.data as QuerySnapshot).docs.length,
                itemBuilder: (BuildContext context, int index) {
                  final forumDoc = (snapshot.data as QuerySnapshot).docs[index];
                  return Card(
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.white,
                        backgroundImage:
                            NetworkImage(forumDoc['profilepic'].toString()),
                      ),
                      title: Text(
                        forumDoc['name'].toString(),
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (forumDoc['type'] == 1)
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                forumDoc['forums'],
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                          if (forumDoc['type'] == 2)
                            Image(image: NetworkImage(forumDoc['image'])),
                          if (forumDoc['type'] == 3)
                            Column(
                              children: [
                                Text(
                                  forumDoc['forums'],
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Image(image: NetworkImage(forumDoc['image'])),
                              ],
                            ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  InkWell(
                                    child: const Icon(Icons.comment),
                                    onTap: () => Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => CommentPage(
                                            documentid: forumDoc['id']),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 20.0,
                                  ),
                                  Text(
                                    forumDoc['commentCount'].toString(),
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  InkWell(
                                    onTap: () => likePost(forumDoc['id']),
                                    child: forumDoc['likes'].contains(uid)
                                        ? const Icon(
                                            Icons.favorite,
                                            color: Colors.red,
                                          )
                                        : const Icon(Icons.favorite_border),
                                  ),
                                  const SizedBox(
                                    width: 20.0,
                                  ),
                                  Text(
                                    forumDoc['likes'].length.toString(),
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  InkWell(
                                    child: const Icon(Icons.share),
                                    onTap: () => sharePost(
                                      forumDoc['id'],
                                      forumDoc['forums'],
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 20.0,
                                  ),
                                  Text(
                                    forumDoc['shares'].toString(),
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  );
                });
          }),
    );
  }
}
