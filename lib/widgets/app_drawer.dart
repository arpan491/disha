import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:disha/screens/language_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../screens/account_settings_screen.dart';
import '../screens/profile_settings_screen.dart';

class AppDrawer extends StatelessWidget {
  Widget buildDrawerItem(Function() onTap, IconData icon, String title) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: ListTile(
          leading: Icon(
            icon,
            color: Colors.white,
          ),
          title: Text(
            title,
            style: TextStyle(color: Colors.white, fontSize: 15),
          ),
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
          return CircularProgressIndicator();
        } else {
          final data = userSnapshot.data as DocumentSnapshot;
          return Drawer(
            backgroundColor: Theme.of(context).backgroundColor,
            child: Column(
              children: [
                Expanded(
                  child: ListView(children: [
                    ListTile(
                      leading: CircleAvatar(
                        child: Icon(
                          Icons.person,
                        ),
                      ),
                      title: Text(
                        'Hi User',
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                      subtitle: GestureDetector(
                        onTap: () {
                          Navigator.of(context)
                              .pushNamed(ProfileSettingsScreen.routeName);
                        },
                        child: Text(
                          'View/Edit Profile',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    Divider(
                      color: Colors.white,
                    ),
                    buildDrawerItem(
                        () {
                          Navigator.of(context).pushNamed(AccountSettingsScreen.routeName);
                        }, Icons.person_pin_rounded, 'My Account'),
                    buildDrawerItem(() {
                      Navigator.of(context).pushNamed(LanguageScreen.routeName);
                    }, Icons.language_rounded, 'Language'),
                    buildDrawerItem(() {}, Icons.settings, 'Settings'),
                    buildDrawerItem(() {}, Icons.warning, 'Report An Issue'),
                    buildDrawerItem(() {}, Icons.book, 'App Guide'),
                  ]),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    bottom: 20,
                  ),
                  child: buildDrawerItem(() {
                    FirebaseAuth.instance.signOut();
                  }, Icons.logout, 'Log out'),
                ),
              ],
            ),
          );
        }
      },
    );
  }
}
