import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_multiselect/flutter_multiselect.dart';

import '../data/languages.dart';
import '../data/specializations.dart';
import '../data/states.dart';

class ExpertSearchScreen extends StatefulWidget {
  static const routeName = 'expert-search';
  @override
  State<ExpertSearchScreen> createState() => _ExpertSearchScreenState();
}

class _ExpertSearchScreenState extends State<ExpertSearchScreen> {
  final _form = GlobalKey<FormState>();
  var bestUID = "";
  var chosenlocations = [];
  var chosenspecializations = [];
  var chosenlanguages = [];
  var queryDescription = "";
  var _isLoading = false;
  void getExpert(List<String> userSpecializations,List<String> userLocations,List<String> userLanguages,) async {
    var bestScore = 0.0;
    
    FirebaseFirestore.instance
        .collection('/experts')
        .get()
        .then((querySnapshot) {
      var docSnapshots = querySnapshot.docs;
      
      for (var doc in docSnapshots) {
        var specializations = (doc.data as Map<String,dynamic>)['specializations'];
        var locations = (doc.data as Map<String,dynamic>)['locations'];
        var languages = (doc.data as Map<String,dynamic>)['languages'];

        var sp = 0;
        var local = 0;
        var lang = 0;
        for(var special in specializations){
          for(var userSpecial in userSpecializations){
            if(userSpecial==special){
              sp=sp+1;
            }
          }
        }

        for(var langua in languages){
          for(var userlangua in userLanguages){
            if(userlangua==langua){
              lang=lang+1;
            }
          }
        }

        for(var locals in locations){
          for(var userLocals in userLocations){
            if(locals==userLocals){
              local=local+1;
            }
          }
        }

        var queryScore = (sp*30.0) + (lang*15.0) + (local*10.0);
        if(sp==0){
          queryScore = 0;
        }
        if(queryScore>=bestScore){
          bestUID = (doc.data as Map<String,dynamic>)['uid'];
        }
        
        // Check for your document data here and break when you find it
      }
      print(bestUID);
    });
    print(bestUID);
  }

  void trySubmit() async {
    final isValid = _form.currentState!.validate();
    FocusScope.of(context).unfocus();
    if (isValid) {
      _form.currentState!.save();

      final user = FirebaseAuth.instance.currentUser;

      setState(() {
        _isLoading = true;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
              'Query Submitted Successfully. Please wait until we find you a match.'),
        ),
      );

      await FirebaseFirestore.instance.collection('query').doc(user!.uid).set({
        'queryDescription': queryDescription,
        'locations': chosenlocations,
        'specializations': chosenspecializations,
        'languages': chosenlanguages,
      }).then((value) {
        
        setState(
          () {
            print('test');
            _isLoading = false;
          },
        );
        getExpert(chosenspecializations as List<String>,chosenlanguages as List<String>,chosenlocations as List<String>);
        // Navigator.push();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Ask Your Query')),
        body: Column(
          children: [
            // Container(
            //   height: 400,
            //   child: Image.asset('assets/images/expert_search.png', height: 200, width: 200, fit: BoxFit.cover),
            // ),
            SingleChildScrollView(
              child: Form(
                key: _form,
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextFormField(
                        maxLines: 5,
                        key: ValueKey('explainQuery'),
                        decoration: InputDecoration(
                            labelText:
                                'Explain your query in max 100 characters'),
                        maxLength: 100,
                        onSaved: (val) {
                          queryDescription = val as String;
                        },
                      ),
                      MultiSelect(
                        autovalidateMode: AutovalidateMode.always,
                        initialValue: const [],
                        titleText: 'Location',
                        maxLength: 3,
                        validator: (dynamic value) {
                          return value == null
                              ? 'Please select one or more option(s)'
                              : null;
                        },
                        errorText: 'Please select one or more option(s)',
                        dataSource: states,
                        textField: 'name',
                        valueField: 'key',
                        filterable: true,
                        required: true,
                        onSaved: (value) {
                          chosenlocations = value;
                        },
                        change: (value) {
                          print('The selected values are $value');
                        },
                        maxLengthIndicatorColor: Colors.white,
                        selectIcon: Icons.arrow_drop_down_circle,
                        titleTextColor: Colors.black,
                        // saveButtonColor: Theme.of(context).primaryColor,
                        checkBoxColor: Theme.of(context).primaryColorDark,
                        // cancelButtonColor: Theme.of(context).primaryColorLight,
                        responsiveDialogSize: const Size(600, 800),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      MultiSelect(
                        autovalidateMode: AutovalidateMode.always,
                        initialValue: const [],
                        titleText: 'Specializations',
                        maxLength: 5,
                        validator: (dynamic value) {
                          return value == null
                              ? 'Please select one or more option(s)'
                              : null;
                        },
                        errorText: 'Please select one or more option(s)',
                        dataSource: specializations,
                        textField: 'name',
                        valueField: 'key',
                        filterable: true,
                        required: true,
                        onSaved: (value) {
                          chosenspecializations = value;
                          print('The saved values are $value');
                        },
                        change: (value) {
                          print('The selected values are $value');
                        },
                        maxLengthIndicatorColor: Colors.white,
                        selectIcon: Icons.arrow_drop_down_circle,
                        titleTextColor: Colors.black,
                        // saveButtonColor: Theme.of(context).primaryColor,
                        checkBoxColor: Theme.of(context).primaryColorDark,
                        // cancelButtonColor: Theme.of(context).primaryColorLight,
                        responsiveDialogSize: const Size(600, 800),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      MultiSelect(
                        autovalidateMode: AutovalidateMode.always,
                        initialValue: const [],
                        titleText: 'Languages',
                        maxLength: 5,
                        validator: (dynamic value) {
                          return value == null
                              ? 'Please select one or more option(s)'
                              : null;
                        },
                        errorText: 'Please select one or more option(s)',
                        dataSource: languages,
                        textField: 'name',
                        valueField: 'key',
                        filterable: true,
                        required: true,
                        onSaved: (value) {
                          chosenlanguages = value;
                          print('The saved values are $value');
                        },
                        change: (value) {
                          print('The selected values are $value');
                        },
                        maxLengthIndicatorColor: Colors.white,
                        selectIcon: Icons.arrow_drop_down_circle,
                        titleTextColor: Colors.black,
                        // saveButtonColor: Theme.of(context).primaryColor,
                        checkBoxColor: Theme.of(context).primaryColorDark,
                        // cancelButtonColor: Theme.of(context).primaryColorLight,
                        responsiveDialogSize: const Size(600, 800),
                      ),
                      //     TextFormField(
                      //       key: ValueKey('state-pref'),
                      //       decoration: InputDecoration(labelText: 'State Preference'),
                      //       keyboardType: TextInputType.emailAddress,
                      //       onSaved: (val) {
                      //         // email = val as String;
                      //       },
                      //     ),
                      //     TextFormField(
                      //       maxLength: 10,
                      //       key: ValueKey('mobile'),
                      //       initialValue: data['mobile number'],
                      //       decoration: InputDecoration(labelText: 'Mobile Number'),
                      //       keyboardType: TextInputType.phone,
                      //       validator: (val) {
                      //         if (val!.isNotEmpty &&
                      //             (val.length != 10 || int.parse(val[0]) < 6)) {
                      //           return "Enter a valid phone number.";
                      //         }
                      //         return null;
                      //       },
                      //       onSaved: (val) {
                      //         mobileNumber = val as String;
                      //       },
                      //     ),
                      //     if (!widget.isLoading)
                      if (_isLoading) CircularProgressIndicator(),
                      if (!_isLoading)
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              onPrimary: Colors.black,
                              primary: Color.fromRGBO(160, 220, 241, 1)),
                          onPressed: trySubmit,
                          child: Text('Submit'),
                        ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ));
  }
}
