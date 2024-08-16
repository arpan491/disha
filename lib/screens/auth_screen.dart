import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../widgets/auth_form.dart';
import './verify_screen.dart';

class AuthScreen extends StatefulWidget {
  static const routeName = 'auth-screen';
  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final auth = FirebaseAuth.instance;

  var _isLoading = false;

  void _submitAuthForm(String name, String mobileNumber, String password,
      String email, bool isLogin, BuildContext ctx) async {
    UserCredential authResult;

    try {
      setState(() {
        _isLoading = true;
      });
      if (isLogin) {
        authResult = await auth.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
      } else {
        auth
            .createUserWithEmailAndPassword(email: email, password: password)
            .then((_) {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => VerifyScreen(
                name,
                email,
                mobileNumber,
              ),
            ),
          );
        });

        //   ScaffoldMessenger.of(ctx).showSnackBar(
        //   SnackBar(
        //     content: Text('Email verification sent. Please confirm.'),
        //     backgroundColor: Colors.green,
        //   ),
        // );
        //   await authResult.user!.sendEmailVerification();

      }
    } on PlatformException catch (err) {
      var message = 'An error occured, please check your credentials';

      if (err.message != null) {
        message = err.message as String;
      }
      ScaffoldMessenger.of(ctx).showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: Theme.of(ctx).errorColor,
        ),
      );
      setState(() {
        _isLoading = false;
      });
    } catch (err) {
      ScaffoldMessenger.of(ctx).showSnackBar(
        SnackBar(
          content: Text(err.toString()),
          backgroundColor: Theme.of(ctx).errorColor,
        ),
      );
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.only(top: 100),
              child: Image.asset(
                'assets/images/user_student.png',
                height: 220,
                width: 200,
                fit: BoxFit.cover,
              ),
            ),
            AuthForm(_submitAuthForm, _isLoading),
          ],
        ),
      ),
    );
  }
}
