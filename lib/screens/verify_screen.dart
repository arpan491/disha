import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:disha/screens/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class VerifyScreen extends StatefulWidget {
  final String name;
  final String email;
  final String mobileNumber;
  VerifyScreen(this.name, this.email, this.mobileNumber);

  static const routeName = 'verify-screen';
  @override
  _VerifyScreenState createState() => _VerifyScreenState();
}

class _VerifyScreenState extends State<VerifyScreen> {
  final auth = FirebaseAuth.instance;
  late User user;
  late Timer timer;

  @override
  void initState() {
    user = auth.currentUser!;
    user.sendEmailVerification();
    timer = Timer.periodic(Duration(seconds: 3), (timer) {
      checkEmailVerified();
    });
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Verify your email')),
      body: Center(
        child: Text('An email has been sent to ${user.email}.'),
      ),
    );
  }

  Future<void> checkEmailVerified() async {
    user = auth.currentUser!;
    await user.reload();
    if (user.emailVerified) {
      timer.cancel();
      await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
        'name': widget.name,
        'mobile number': widget.mobileNumber,
        'email': widget.email,
        'uid': user.uid,
        'lang': 'English',
        'profilepic':
            'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460__340.png',
      });
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => HomeScreen()));
    }
  }
}
