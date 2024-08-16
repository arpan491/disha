import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../LanguageChangeProvider.dart';
import '../generated/l10n.dart';

class LanguageScreen extends StatefulWidget {
  static const routeName = '/language';

  @override
  State<LanguageScreen> createState() => _LanguageScreenState();
}

class _LanguageScreenState extends State<LanguageScreen> {
  final user = FirebaseAuth.instance.currentUser;

  var _isLoading = false;

  // void _updateLanguageInfo(
  //   String selectedValue
  // ) async {
  //   final user = FirebaseAuth.instance.currentUser;

  //   setState(() {
  //     _isLoading = true;
  //   });
  //   await FirebaseFirestore.instance.collection('users').doc(user!.uid).set({
  //     'name': name,
  //     'mobile number': mobileNumber,
  //     'email': email,
  //   }).then(
  //     (value) => setState(
  //       () {
  //         _isLoading = false;
  //       },
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<LanguageChangeProvider>(
      create: (context) => LanguageChangeProvider(),
      child: Builder(
        builder: (context) => FutureBuilder(
            future: FirebaseFirestore.instance
                .collection('users')
                .doc(user!.uid)
                .get(),
            builder: (context, userSnapshot) {
              if (userSnapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              final data = userSnapshot.data as DocumentSnapshot;
              var selectedLanguage = data['lang'];
              return Scaffold(
                appBar: AppBar(title: Text(S.of(context).langsett)),
                body: Row(
                  children: [
                    Text(S.of(context).chooseLang),
                    DropdownButton(
                        value: selectedLanguage,
                        items: [
                          DropdownMenuItem(
                            // onTap: () {
                            //
                            // },
                            child: Row(
                              children: [
                                SizedBox(width: 10),
                                Text('English'),
                              ],
                            ),
                            value: 'English',
                          ),
                          DropdownMenuItem(
                            // onTap: () {
                            //   context.read<LanguageChangeProvider>().changeLocale("hi");
                            // },
                            child: Row(
                              children: [
                                SizedBox(width: 10),
                                Text('हिंदी '),
                              ],
                            ),
                            value: 'हिंदी',
                          ),
                        ],
                        onChanged: (selectedValue) {
                          if (selectedValue == 'en') {
                            setState(() {});
                            context
                                .read<LanguageChangeProvider>()
                                .changeLocale("en");
                          } else {
                            setState(() {
                              selectedLanguage = 'हिंदी';
                            });
                            context
                                .read<LanguageChangeProvider>()
                                .changeLocale("hi");
                          }
                        })
                  ],
                ),
                // body: Column(children: [
                //   ElevatedButton(onPressed: ()=>{context.read<LanguageChangeProvider>().changeLocale("en")},child: Text('English'), ),
                //   ElevatedButton(onPressed: ()=>{context.read<LanguageChangeProvider>().changeLocale("hi")},child: Text('Hindi'), ),
                // ]),
              );
            }),
      ),
    );
  }
}
