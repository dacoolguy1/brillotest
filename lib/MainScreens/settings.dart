import 'package:brillotest/PreScreens/Login.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SettingsPage extends StatefulWidget {
  static String main = 'settings';
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final _formKey = GlobalKey<FormState>();
  final _auth = FirebaseAuth.instance;
  String _newPassword = '';
  String _newEmail = '';
  //String _newUsername = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Settings'),
        ),
        body: Padding(
            padding: EdgeInsets.all(16.0),
            child: Form(
                key: _formKey,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      TextFormField(
                        decoration: InputDecoration(labelText: 'New Password'),
                        obscureText: true,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter a new password';
                          }
                          return null;
                        },
                        onChanged: (value) {
                          setState(() {
                            _newPassword = value;
                          });
                        },
                      ),
                      SizedBox(height: 16.0),
                      TextFormField(
                        decoration: InputDecoration(labelText: 'New Email'),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter a new email';
                          }
                          return null;
                        },
                        onChanged: (value) {
                          setState(() {
                            _newEmail = value;
                          });
                        },
                      ),
                      SizedBox(height: 16.0),
                      ElevatedButton(
                        child: Text('Change Password'),
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            try {
                              await _auth.currentUser!
                                  .updatePassword(_newPassword);
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content: Text(
                                          'Password changed successfully')));
                            } on FirebaseAuthException catch (e) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text(e.message!)));
                            }
                          }
                        },
                      ),
                      SizedBox(height: 16.0),
                      ElevatedButton(
                        child: Text('Update Email'),
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            try {
                              await _auth.currentUser!.updateEmail(_newEmail);

                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content:
                                          Text('Email updated successfully')));
                            } on FirebaseAuthException catch (e) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text(e.message!)));
                            }
                          }
                        },
                      ),
                      SizedBox(height: 16.0),
                      ElevatedButton(
                        child: Text('Logout'),
                        onPressed: () async {
                          await _auth.signOut();
                          Navigator.of(context).pushNamed(LoginPage.id);
                        },
                      ),
                    ]))));
  }
}
