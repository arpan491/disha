import 'package:disha/screens/auth_screen.dart';
import 'package:flutter/material.dart';

class ConfirmEmailScreen extends StatelessWidget {

  static const routeName = '/confirm-email';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Confirm Email'),
      ),
      body: Center(
        child: Column(
          children: [
            Text('Please confirm your email'),
            TextButton(onPressed: (){
              Navigator.of(context).pushReplacementNamed(AuthScreen.routeName);
            },child: Text('Go Back')),
          ],
        ),
        
      ),
    );
  }
}
