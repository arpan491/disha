import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class NewForumScreen extends StatefulWidget {
  const NewForumScreen({Key? key}) : super(key: key);

  static const routeName = '/new-forum';
  @override
  State<NewForumScreen> createState() => _NewForumScreenState();
}

class _NewForumScreenState extends State<NewForumScreen> {
  File? imagePath;
  TextEditingController forumController = TextEditingController();
  bool uploading = false;
  pickImage(ImageSource imgSource) async {
    final image = await ImagePicker().pickImage(source: imgSource);
    setState(() {
      imagePath = File((image?.path).toString());
    });
    Navigator.pop(context);
  }

  optionsDialog() {
    return showDialog(
        context: context,
        builder: (context) {
          return SimpleDialog(
            children: [
              SimpleDialogOption(
                onPressed: () => pickImage(ImageSource.gallery),
                child: Text(
                  "Image from gallery",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.normal,
                    color: Colors.black,
                  ),
                ),
              ),
              SimpleDialogOption(
                onPressed: () => pickImage(ImageSource.camera),
                child: Text(
                  "Image from Camera",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.normal,
                    color: Colors.black,
                  ),
                ),
              ),
              SimpleDialogOption(
                onPressed: () => Navigator.pop(context),
                child: Text(
                  "Cancel",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.normal,
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          );
        });
  }

  uploadImage(String id) async {
    Reference forumPictures =
        FirebaseStorage.instance.ref().child('forumPictures');
    UploadTask storageUploadTask = (forumPictures.child(id).putFile(imagePath!));
    TaskSnapshot storageTaskSnapshot = await storageUploadTask;
    String downloadURL = await storageTaskSnapshot.ref.getDownloadURL();
    return downloadURL;
  }

  postforum() async {
    setState(() {
      uploading = true;
    });
    CollectionReference forumcollection =
        FirebaseFirestore.instance.collection('forums');
    CollectionReference usercollection =
        FirebaseFirestore.instance.collection('users');
    var firebaseUser = FirebaseAuth.instance.currentUser!;
    DocumentSnapshot userDoc = await usercollection.doc(firebaseUser.uid).get();
    var allDocuments = await forumcollection.get();
    int length = allDocuments.docs.length;
    if (forumController.text != '' && imagePath == null) {
      forumcollection.doc('Tweet $length').set({
        'name': userDoc['name'],
        'profilepic': userDoc['profilepic'],
        'uid': firebaseUser.uid,
        'id': 'Tweet $length',
        'forums': forumController.text,
        'likes': [],
        'commentCount': 0,
        'shares': 0,
        'type': 1,
      });
      Navigator.pop(context);
    }
    if (forumController.text == '' && imagePath != null) {
      String imageURL = await uploadImage('Tweet $length');
      forumcollection.doc('Tweet $length').set({
        'name': userDoc['name'],
        'profilepic': userDoc['profilepic'],
        'uid': firebaseUser.uid,
        'id': 'Tweet $length',
        'image': imageURL,
        'likes': [],
        'commentCount': 0,
        'shares': 0,
        'type': 2,
      });
      Navigator.pop(context);
    }
    if (forumController.text != '' && imagePath != null) {
      String imageURL = await uploadImage('Tweet $length');
      forumcollection.doc('Tweet $length').set({
        'name': userDoc['name'],
        'profilepic': userDoc['profilepic'],
        'uid': firebaseUser.uid,
        'id': 'Tweet $length',
        'forums': forumController.text,
        'image': imageURL,
        'likes': [],
        'commentCount': 0,
        'shares': 0,
        'type': 3,
      });
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () => postforum(),
          child: const Icon(
            Icons.publish,
            size: 32,
          ),
        ),
        appBar: AppBar(
          leading: InkWell(
            onTap: () => Navigator.pop(context),
            child: const Icon(
              Icons.arrow_back,
              size: 32,
            ),
          ),
          centerTitle: true,
          title: Text(
            "Add forum",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.normal,
              color: Colors.black,
            ),
          ),
          actions: [
            InkWell(
              onTap: () => optionsDialog(),
              child: const Icon(
                Icons.photo,
                size: 40,
              ),
            ),
          ],
        ),
        body: uploading == false
            ? Column(
                children: [
                  Expanded(
                    child: TextField(
                      controller: forumController,
                      maxLines: null,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.normal,
                        color: Colors.black,
                      ),
                      decoration: InputDecoration(
                        labelText: 'Enter your Chat here',
                        labelStyle: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.normal,
                          color: Colors.black,
                        ),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  imagePath == null
                      ? Container()
                      : MediaQuery.of(context).viewInsets.bottom > 0
                          ? Container()
                          : Image(
                              width: 200,
                              height: 300,
                              image: FileImage(imagePath!),
                            ),
                ],
              )
            : Center(
                child: Text(
                  "Uploading!.....",
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.normal,
                    color: Colors.black,
                  ),
                ),
              ));
  }
}
