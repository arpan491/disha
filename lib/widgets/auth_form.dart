import 'package:flutter/material.dart';

class AuthForm extends StatefulWidget {
  @override
  State<AuthForm> createState() => _AuthFormState();

  final void Function(String name, String mobileNumber, String password,
      String email, bool isLogin, BuildContext ctx) _submitAuthForm;
  final isLoading;
  AuthForm(this._submitAuthForm, this.isLoading);
}

class _AuthFormState extends State<AuthForm> {
  final _form = GlobalKey<FormState>();
  final TextEditingController _pass = TextEditingController();
  final TextEditingController _confirmPass = TextEditingController();
  var name = '';

  var password = '';

  var email = '';

  var mobileNumber = '';

  var _isLogin = true;

  void trySubmit() {
    final isValid = _form.currentState!.validate();
    FocusScope.of(context).unfocus();
    if (isValid) {
      _form.currentState!.save();
      widget._submitAuthForm(name.trim(), mobileNumber.trim(), password.trim(),
          email.trim(), _isLogin, context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Form(
            key: _form,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (!_isLogin)
                    TextFormField(
                      key: ValueKey('name'),
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
                    key: ValueKey('email'),
                    decoration: InputDecoration(labelText: 'E-Mail'),
                    keyboardType: TextInputType.emailAddress,
                    validator: (val) {
                      if (val!.isEmpty ||
                          !val.contains('@') ||
                          RegExp(
                            r"/^WS{1,2}:\/\/\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}:56789/i",
                            caseSensitive: false,
                            multiLine: false,
                          ).hasMatch(val)) {
                        return "Enter a valid email";
                      }

                      return null;
                    },
                    onSaved: (val) {
                      email = val as String;
                    },
                  ),
                  if (!_isLogin)
                    TextFormField(
                      key: ValueKey('mobile'),
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
                  TextFormField(
                    key: ValueKey('password'),
                    controller: _pass,
                    decoration: InputDecoration(labelText: 'Password'),
                    obscureText: true,
                    validator: (val) {
                      if (val!.isEmpty || val.length < 7) {
                        return "Enter a valid password with more than 7 characters.";
                      }
                      return null;
                    },
                    onSaved: (val) {
                      password = val as String;
                    },
                  ),
                  if (!_isLogin)
                    TextFormField(
                      key: ValueKey('confirmpassword'),
                      controller: _confirmPass,
                      decoration:
                          InputDecoration(labelText: 'Confirm Password'),
                      obscureText: true,
                      validator: (val) {
                        if (val!.isEmpty) {
                          return "Please confirm your password";
                        }
                        if (val != _pass.text) {
                          return "Passwords do not match";
                        }
                        return null;
                      },
                    ),
                  SizedBox(height: 10),
                  if (widget.isLoading) CircularProgressIndicator(),
                  if (!widget.isLoading)
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          onPrimary: Colors.black,
                          primary: Color.fromRGBO(160, 220, 241, 1)),
                      onPressed: trySubmit,
                      child: Text(_isLogin ? 'Login' : 'Create Account'),
                    ),
                  if (!widget.isLoading)
                    TextButton(
                      style: TextButton.styleFrom(
                        primary: Colors.black,
                      ),
                      onPressed: () {
                        setState(() {
                          _isLogin = !_isLogin;
                        });
                      },
                      child: Text(_isLogin
                          ? 'Don\'t have an account? Register here.'
                          : 'Already have an account? Login here.'),
                    )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
