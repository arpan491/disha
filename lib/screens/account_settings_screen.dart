import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../widgets/app_drawer.dart';

class AccountSettingsScreen extends StatelessWidget {
  static const routeName = '/account-settings';

  Widget settingsItemBuilder(onTap, IconData icon, String title) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(left: 10.0),
        child: Row(
          children: [
            Icon(icon),
            SizedBox(width: 15),
            Text(
              title,
              style: TextStyle(fontSize: 15),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    return FutureBuilder(
      future:
          FirebaseFirestore.instance.collection('users').doc(user!.uid).get(),
      builder: (ctx, userSnapshot) {
        if (userSnapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else {
          final data = userSnapshot.data as DocumentSnapshot;
          
          // print(userDocs.docs);
          return Scaffold(
            appBar: AppBar(
              title: Text('Account Settings'),
            ),
            body: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(children: [
                Row(
                  children: [
                    Image.asset(
                      'assets/images/user_student.png',
                      height: 100,
                      width: 100,
                    ),
                    Container(
                      margin: EdgeInsets.only(
                        top: 20,
                        left: 20,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            data['name'],
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 4),
                          GestureDetector(
                            onTap: () {},
                            child: Text('Edit Profile'),
                          ),
                          SizedBox(height: 6),
                          Row(
                            children: [
                              Icon(Icons.mail),
                              SizedBox(width: 4),
                              Text(
                                data['email'],
                                style: TextStyle(fontSize: 10),
                              ),
                            ],
                          ),
                          SizedBox(height: 3),
                          data['mobile number'].length==10?Row(
                            children: [
                              Icon(Icons.phone),
                              SizedBox(width: 4),
                              Text(data['mobile number']),
                            ],
                          ):Row(),
                        ],
                      ),
                    )
                  ],
                ),
                SizedBox(height: 10),
                Divider(),
                Padding(
                  padding: EdgeInsets.only(top: 20),
                  child: Column(
                    children: [
                      settingsItemBuilder(() {}, Icons.payment, 'Change Plan'),
                    ],
                  ),
                )
              ]),
            ),
          );
        }
      },
    );
  }
}
