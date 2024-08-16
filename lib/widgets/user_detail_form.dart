import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserDetailForm extends StatefulWidget {
  @override
  State<UserDetailForm> createState() => UserDetailFormState();

  final _updateUserInfo;
  final isLoading;
  UserDetailForm(this._updateUserInfo, this.isLoading);
}

class UserDetailFormState extends State<UserDetailForm> {
  final _form = GlobalKey<FormState>();

  var name = '';
  var mobileNumber = '';
  var email = '';
  void trySave() {
    final isValid = _form.currentState!.validate();
    FocusScope.of(context).unfocus();
    if (isValid) {
      _form.currentState!.save();
      widget._updateUserInfo(
        name.trim(),
        mobileNumber.trim(),
        email.trim(),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    return FutureBuilder(
        future:
            FirebaseFirestore.instance.collection('users').doc(user!.uid).get(),
        builder: (context, docSnapshot) {
          if(docSnapshot.connectionState==ConnectionState.waiting){
            return Center(child: CircularProgressIndicator(),);
          }
          final data = docSnapshot.data as DocumentSnapshot;
          email = data['email'];
          return Container(
            margin: const EdgeInsets.all(16),
            child: SingleChildScrollView(
              child: Form(
                key: _form,
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextFormField(
                        maxLength: data['name'].length,
                        key: ValueKey('name'),
                        initialValue: data['name'],
                        decoration: InputDecoration(labelText: 'Name'),
                        validator: (val) {
                          if (val!.isEmpty || val.length < 2) {
                            return "Enter a valid name of length atleast 2.";
                          }
                          return null;
                        },
                        onSaved: (val) {
                          name = val as String;
                        },
                      ),
                      TextFormField(
                        maxLength: data['email'].length,
                        key: ValueKey('email'),
                        initialValue: data['email'],
                        readOnly: true,
                        decoration: InputDecoration(labelText: 'E-Mail'),
                        keyboardType: TextInputType.emailAddress,
                        onSaved: (val) {
                          // email = val as String;
                        },
                      ),
                      TextFormField(
                        maxLength: 10,
                        key: ValueKey('mobile'),
                        initialValue: data['mobile number'],
                        decoration: InputDecoration(labelText: 'Mobile Number'),
                        keyboardType: TextInputType.phone,
                        validator: (val) {
                          if (val!.isNotEmpty &&
                              (val.length != 10 || int.parse(val[0]) < 6)) {
                            return "Enter a valid phone number.";
                          }
                          return null;
                        },
                        onSaved: (val) {
                          mobileNumber = val as String;
                        },
                      ),
                      if (widget.isLoading) CircularProgressIndicator(),
                      if (!widget.isLoading)
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              onPrimary: Colors.black,
                              primary: Color.fromRGBO(160, 220, 241, 1)),
                          onPressed: trySave,
                          child: Text('Save'),
                        ),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }
}
