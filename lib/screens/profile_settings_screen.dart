import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:disha/widgets/user_detail_form.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../LanguageChangeProvider.dart';
import '../generated/l10n.dart';

class ProfileSettingsScreen extends StatefulWidget {
  static const routeName = '/profile-settings';

  @override
  State<ProfileSettingsScreen> createState() => _ProfileSettingsScreenState();
}

class _ProfileSettingsScreenState extends State<ProfileSettingsScreen> {
  var _isLoading = false;

  void _updateUserInfo(
    String name,
    String mobileNumber,
    String email,
  ) async {
    final user = FirebaseAuth.instance.currentUser;

    setState(() {
      _isLoading = true;
    });
    await FirebaseFirestore.instance.collection('users').doc(user!.uid).set({
      'name': name,
      'mobile number': mobileNumber,
      'email': email,
      'uid' : user.uid,
    }).then(
      (value) => setState(
        () {
          _isLoading = false;
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<LanguageChangeProvider>(
      create: (context) => LanguageChangeProvider(),
      child: Builder(
        builder: (context) => Scaffold(
          appBar: AppBar(
            title: Text(S.of(context).profSett),
          ),
          body: Container(
            padding: EdgeInsets.all(50),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  children: [Text('')],
                ),
                Stack(
                  children: [
                    Image.asset(
                      'assets/images/user_student.png',
                      height: 160,
                      width: 160,
                    ),
                    Positioned(
                      bottom: 0,
                      left: 28,
                      child: GestureDetector(
                        onTap: () {},
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 7,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: Colors.white,
                            border: Border.all(
                              width: 0.5,
                              color: Colors.black87,
                            ),
                          ),
                          child: Container(
                            width: 80,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.edit),
                                Text(
                                  S.of(context).editProfile,
                                  style: TextStyle(
                                    fontSize: 10,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                UserDetailForm(_updateUserInfo, _isLoading),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
