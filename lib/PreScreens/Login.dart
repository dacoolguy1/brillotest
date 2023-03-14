import 'dart:math';

import 'package:brillotest/MainScreens/homepage.dart';
import 'package:brillotest/constant.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:firebase_auth/firebase_auth.dart';
//static String id = 'login';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginPage extends StatefulWidget {
  static String id = 'logi';
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _phoneController = TextEditingController();
  late String _verificationId;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            Padding(
              padding: kDefaultPadding,
              child: TextFormField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  labelText: 'Email or Phone',
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your email or phone number';
                  }
                  return null;
                },
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: kDefaultPadding,
              child: TextFormField(
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Password',
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your password';
                  }
                  return null;
                },
              ),
            ),
            SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    try {
                      if (_emailController.text.contains('@')) {
                        try {
                          UserCredential userCredential = await FirebaseAuth
                              .instance
                              .signInWithEmailAndPassword(
                            email: _emailController.text.trim(),
                            password: _passwordController.text.trim(),
                          );
                          print('User ${userCredential.user!.uid} signed in');
                          Navigator.of(context).pushNamed(HomePage.id);
                        } on FirebaseAuthException catch (e) {
                          if (e.code == 'user-not-found') {
                            //print('No user found for that email.');
                            showDialog(
                                context: context,
                                builder: (ctx) => AlertDialog(
                                        title: Text('An error occurred!'),
                                        content: Text(
                                            'No user found for that email.'),
                                        actions: <Widget>[
                                          ElevatedButton(
                                            child: Text('Okay'),
                                            onPressed: () {
                                              Navigator.of(ctx).pop();
                                            },
                                          )
                                        ]));
                          } else if (e.code == 'wrong-password') {
                            showDialog(
                                context: context,
                                builder: (ctx) => AlertDialog(
                                        title: Text('An error occurred!'),
                                        content: Text(
                                            'Wrong password provided for that user.'),
                                        actions: <Widget>[
                                          ElevatedButton(
                                            child: Text('Okay'),
                                            onPressed: () {
                                              Navigator.of(ctx).pop();
                                            },
                                          )
                                        ]));
                            print('Wrong password provided for that user.');
                          } else {
                            showDialog(
                                context: context,
                                builder: (ctx) => AlertDialog(
                                        title: Text('An error occurred!'),
                                        content: Text(
                                            'Error during sign in: ${e.message}'),
                                        actions: <Widget>[
                                          ElevatedButton(
                                            child: Text('Okay'),
                                            onPressed: () {
                                              Navigator.of(ctx).pop();
                                            },
                                          )
                                        ]));

                            print('Error during sign in: ${e.message}');
                          }
                        } catch (e) {
                          showDialog(
                              context: context,
                              builder: (ctx) => AlertDialog(
                                      title: Text('An error occurred!'),
                                      content: Text('Error during sign in: $e'),
                                      actions: <Widget>[
                                        ElevatedButton(
                                          child: Text('Okay'),
                                          onPressed: () {
                                            Navigator.of(ctx).pop();
                                          },
                                        )
                                      ]));

                          print('Error during sign in: $e');
                        }

                        // Navigator.of(context).pushNamed(HomePage.id);

                        // Navigator.of(context).pushNamed(HomePage.id);
                      } else {
                        await FirebaseAuth.instance.verifyPhoneNumber(
                          phoneNumber: _emailController.text,
                          verificationCompleted: (credential) async {
                            await FirebaseAuth.instance
                                .signInWithCredential(credential);
                          },
                          verificationFailed: (exception) {
                            print(exception);
                          },
                          codeSent: (verificationId, [forceResendingToken]) {
                            _verificationId = verificationId;
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: Text('Enter Verification Code'),
                                content: TextFormField(
                                  controller: _phoneController,
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                    labelText: 'Verification Code',
                                  ),
                                ),
                                actions: [
                                  ElevatedButton(
                                    child: Text('Verify'),
                                    onPressed: () async {
                                      try {
                                        PhoneAuthCredential credential =
                                            PhoneAuthProvider.credential(
                                          verificationId: _verificationId,
                                          smsCode: _phoneController.text,
                                        );
                                        await FirebaseAuth.instance
                                            .signInWithCredential(credential);
                                        // Navigator.pop(context);
                                        Navigator.of(context)
                                            .pushNamed(HomePage.id);
                                      } catch (e) {
                                        showDialog(
                                            context: context,
                                            builder: (ctx) => AlertDialog(
                                                    title: Text(
                                                        'An error occurred!'),
                                                    content: Text(' $e'),
                                                    actions: <Widget>[
                                                      ElevatedButton(
                                                        child: Text('Okay'),
                                                        onPressed: () {
                                                          Navigator.of(ctx)
                                                              .pop();
                                                        },
                                                      )
                                                    ]));

                                        print(e);
                                      }
                                    },
                                  ),
                                ],
                              ),
                            );
                          },
                          codeAutoRetrievalTimeout: (verificationId) {
                            _verificationId = verificationId;
                          },
                        );
                        // Navigator.of(context).pushNamed(HomePage.id);
                      }
                    } catch (e) {
                      print(e);
                    }
                  }
                },
                child: Text('Login'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
