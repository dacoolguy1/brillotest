import 'package:brillotest/PreScreens/Login.dart';
import 'package:brillotest/PreScreens/emailverification.dart';
import 'package:brillotest/PreScreens/forgotpassword.dart';
import 'package:brillotest/constant.dart';
import 'package:brillotest/firebase_constants.dart';

import 'package:flutter/material.dart';
import 'package:firebase_phone_auth_handler/firebase_phone_auth_handler.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

import 'package:firebase_auth/firebase_auth.dart';

import 'package:email_validator/email_validator.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Registeration extends StatefulWidget {
  static String id = 'register';
  static String phonenumber = '';
  const Registeration({Key? key}) : super(key: key);

  @override
  State<Registeration> createState() => _RegisterationState();
}

class _RegisterationState extends State<Registeration> {
  bool _isObscure = true;
  String initialCountry = 'NG';
  PhoneNumber number = PhoneNumber(isoCode: 'NG');
  // int role = 2;
  final formKey = GlobalKey<FormState>();
  // define the Controller we will use to hold the Users Inputs
  final emailEditingController = TextEditingController();
  final phoneEditingController = TextEditingController();
  final passwordEditingController = TextEditingController();
  final confirmPasswordEditingController = TextEditingController();
  bool _isLoading = false;
  // bool _isLoading = false;
  String _errorMessage = '';
// This async function deals with the Signup with email address, the sign phone number auth is pushed to the verification code page
  static Future<User?> signUp(
      {required String userEmail,
      required String password,
      required BuildContext context}) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: userEmail, password: password);
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('The password provided is too weak.')));
      } else if (e.code == 'email-already-in-use') {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('The account already exists for that email.')));
      }
      return null;
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }

  bool validateStructure(String value) {
    String pattern = r'^(?=.*?[A-Z])(?=.*?[0-9]).{6,}$';
    RegExp regExp = new RegExp(pattern);
    return regExp.hasMatch(value);
  }

  // ignore: non_constant_identifier_names
  ComparePassword(String pwd, String confirmPwd) {
    if (pwd != confirmPwd) {
      return AwesomeDialog(
              context: context,
              dialogType: DialogType.ERROR,
              animType: AnimType.SCALE,
              headerAnimationLoop: false,
              // dialogBackgroundColor: Colors.green,
              title: "Error",
              desc: "Password doesn't match",
              btnCancelOnPress: () {})
          .show();
    }
  }

  validatePassword(String pwd) {
    var response = validateStructure(pwd);
    if (response == false) {
      return ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Password doesn't match.")));
    }
  }

  List<String> sports = [
    'Select sports',
    'Football',
    'Basketball',
    'Ice Hockey',
    'Motorsports',
    'Bandy',
    'Rugby',
    'Skiing',
    'Shooting'
  ];
  String selectedSport = '';
  @override
  void initState() {
    super.initState();
    selectedSport = sports[0];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 15,
              ),
              ListTile(
                leading: IconButton(
                    onPressed: (() {
                      Navigator.of(context).pop();
                    }),
                    icon: const Icon(
                      Icons.arrow_back,
                      color: Colors.black,
                    )),
                title: const Text(
                  'Create your account',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Padding(
                padding: kDefaultPadding,
                child: Text('Email:',
                    style: TextStyle(fontSize: 14, fontFamily: 'ProductSans')),
              ),
              const SizedBox(
                height: 10,
              ),
              buildEmailForm('', false, emailEditingController,
                  TextInputType.emailAddress, "Email"),
              const SizedBox(
                height: 10,
              ),
              const Padding(
                padding: kDefaultPadding,
                child: Text('Phone Number:',
                    style: TextStyle(fontSize: 14, fontFamily: 'ProductSans')),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: kDefaultPadding,
                child: InternationalPhoneNumberInput(
                  onInputChanged: (PhoneNumber number) {
                    print(number.phoneNumber);
                  },
                  onInputValidated: (bool value) {
                    print(value);
                  },
                  selectorConfig: const SelectorConfig(
                    selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
                  ),
                  ignoreBlank: false,
                  autoValidateMode: AutovalidateMode.onUserInteraction,
                  selectorTextStyle: const TextStyle(color: Colors.black),
                  initialValue: number,
                  textFieldController: phoneEditingController,
                  formatInput: true,
                  keyboardType: const TextInputType.numberWithOptions(
                      signed: true, decimal: true),
                  inputBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black, width: 2)),
                  onSaved: (PhoneNumber number) {
                    print('On Saved: $number');
                  },
                ),
              ),
              const Padding(
                padding: kDefaultPadding,
                child: Text('What Sports are you interested in ',
                    style: TextStyle(fontSize: 14, fontFamily: 'ProductSans')),
              ),
              const SizedBox(
                height: 20,
              ),
              GestureDetector(
                onTap: () async {
                  SharedPreferences prefs =
                      await SharedPreferences.getInstance();
                  prefs.setString('selected_sport', selectedSport);
                },
                child: Padding(
                  padding: kDefaultPadding,
                  child: DropdownButton<String>(
                    value: selectedSport,
                    onChanged: (value) {
                      setState(() {
                        selectedSport = value!;
                      });
                    },
                    items: sports.map((item) {
                      return DropdownMenuItem<String>(
                        value: item,
                        child: Text(item),
                      );
                    }).toList(),
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),

              const SizedBox(
                height: 10,
              ),
              const Padding(
                padding: kDefaultPadding,
                child: Text('Password:',
                    style: TextStyle(fontSize: 14, fontFamily: 'ProductSans')),
              ),
              const SizedBox(
                height: 10,
              ),
              buildPasswordForm('', true, passwordEditingController,
                  TextInputType.name, "Password"),

              // Padding(
              //   padding: kDefaultPadding,
              //   child: TextField(
              //       obscureText: true,
              //       keyboardType: TextInputType.visiblePassword,
              //       decoration: ktextfieldinputDecoration.copyWith(hintText: '')),
              // ),
              const SizedBox(
                height: 10,
              ),

              const SizedBox(
                height: 10,
              ),
              const Padding(
                padding: kDefaultPadding,
                child: Text('Confirm Password:',
                    style: TextStyle(fontSize: 14, fontFamily: 'ProductSans')),
              ),
              const SizedBox(
                height: 10,
              ),
              buildPasswordForm('', true, confirmPasswordEditingController,
                  TextInputType.text, "Password"),
              // Padding(
              //   padding: kDefaultPadding,
              //   child: TextField(
              //       obscureText: true,
              //       keyboardType: TextInputType.visiblePassword,
              //       decoration: ktextfieldinputDecoration.copyWith(hintText: '')),
              // ),
              const SizedBox(
                height: 50,
              ),
              Center(
                child: _isLoading
                    ? const CircularProgressIndicator()
                    : ElevatedButton(
                        onPressed: () async {
                          setState(() {
                            _isLoading = true;
                          });
                          // verifyPhoneNumber(phoneEditingController.text);
                          // String _verificationId = '';

                          // void _onVerificationIdReceived(String verificationId) {
                          //   setState(() {
                          //     _verificationId = verificationId;
                          //   });
                          // }

                          // verifyPhoneNumber(phoneEditingController.text,
                          //     _onVerificationIdReceived);

// Now you can use the _verificationId variable to pass the verification ID to the next page or to the function that handles verification code entry.
                          // if (_errorMessage.isNotEmpty) SizedBox(height: 16.0);
                          // if (_errorMessage.isNotEmpty)
                          Text(
                            _errorMessage,
                            style: const TextStyle(color: Colors.red),
                          );
                          await signUp(
                              userEmail: emailEditingController.text,
                              password: passwordEditingController.text,
                              context: context);
                          Registeration.phonenumber =
                              phoneEditingController.text;
                          print(phoneEditingController.text);
                          //_sendVerificationCode();
                          //print()
                          // ifauth.currentUser;
                          if (auth.currentUser != null) {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (ctx) =>
                                        const EmailVerificationScreen()));
                          }
                          setState(() {
                            _isLoading = false;
                          });
                        },
                        child: const Text('Sign Up')),
              ),
              const SizedBox(
                height: 30,
              ),
              Row(
                children: [
                  const SizedBox(
                    width: 20,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, ForgotPasswordPage.id);
                    },
                    child: const Text(
                      'Forgot Password, ',
                      style: TextStyle(
                          fontSize: 16,
                          color: Color(0xff0057C1),
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                  const SizedBox(
                    width: 120,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, LoginPage.id);
                    },
                    child: const Text(
                      'Login',
                      style: TextStyle(
                          fontSize: 20,
                          color: Color(0xff0057C1),
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      )),
    );
  }

  Padding buildphonenumInputForm(
      String hint,
      bool pass,
      TextEditingController textController,
      TextInputType inputType,
      String name) {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    return Padding(
        padding: kDefaultPadding,
        child: TextFormField(
          maxLength: 11,
          style: TextStyle(fontSize: 14, fontFamily: 'ProductSans'),
          keyboardType: inputType,
          validator: (value) {
            if (value!.isEmpty) {
              return "$name cannot be empty";
            }
            // else if (value!.length < 11) {
            //   return "$name cant be less than 11 characters";
            // }
          },
          onSaved: (value) {
            textController.text = value!;
          },
          controller: textController,
          obscureText: pass ? _isObscure : false,
          decoration: InputDecoration(
            //hintText: ' ',
            //fillColor: Colors.black,
            contentPadding:
                const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
            border: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black, width: 2)),
            //labelStyle: TextStyle(fontSize: 14, fontFamily: 'ProductSans'),
            hintText: hint,
            hintStyle: const TextStyle(color: kTextFieldColor),
            focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: kPrimaryColor)),
            suffixIcon: pass
                ? IconButton(
                    onPressed: () {
                      setState(() {
                        _isObscure = !_isObscure;
                      });
                    },
                    icon: _isObscure
                        ? const Icon(
                            Icons.visibility_off,
                            color: kTextFieldColor,
                          )
                        : const Icon(
                            Icons.visibility,
                            color: kPrimaryColor,
                          ))
                : null,
          ),
        ));
  }

//Deals with the email Textfield
  Padding buildEmailForm(
      String hint,
      bool pass,
      TextEditingController textController,
      TextInputType inputType,
      String name) {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    return Padding(
        padding: kDefaultPadding,
        child: TextFormField(
          style: const TextStyle(fontSize: 14, fontFamily: 'ProductSans'),
          keyboardType: inputType,
          validator: (value) => EmailValidator.validate(textController.text)
              ? null
              : "Please enter a valid email",
          onSaved: (value) {
            textController.text = value!;
          },
          controller: textController,
          obscureText: pass ? _isObscure : false,
          decoration: InputDecoration(
            contentPadding:
                const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
            border: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black, width: 2)),
            labelStyle: TextStyle(fontSize: 14, fontFamily: 'ProductSans'),
            hintText: hint,
            hintStyle: const TextStyle(color: kTextFieldColor),
            focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: kPrimaryColor)),
            suffixIcon: pass
                ? IconButton(
                    onPressed: () {
                      setState(() {
                        _isObscure = !_isObscure;
                      });
                    },
                    icon: _isObscure
                        ? const Icon(
                            Icons.visibility_off,
                            color: kTextFieldColor,
                          )
                        : const Icon(
                            Icons.visibility,
                            color: kPrimaryColor,
                          ))
                : null,
          ),
        ));
  }

// Deals with the password textfield
  Padding buildPasswordForm(
      String hint,
      bool pass,
      TextEditingController textController,
      TextInputType inputType,
      String name) {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    return Padding(
        padding: kDefaultPadding,
        child: TextFormField(
          style: const TextStyle(fontSize: 14, fontFamily: 'ProductSans'),
          keyboardType: inputType,
          validator: (value) => validateStructure(textController.text)
              ? null
              : "Password must contain at least one Uppercase and a digit",
          onSaved: (value) {
            textController.text = value!;
          },
          controller: textController,
          obscureText: pass ? _isObscure : false,
          decoration: InputDecoration(
            contentPadding:
                const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
            border: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black, width: 2)),
            labelStyle:
                const TextStyle(fontSize: 14, fontFamily: 'ProductSans'),
            hintText: hint,
            hintStyle: const TextStyle(color: kTextFieldColor),
            focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: kPrimaryColor)),
            suffixIcon: pass
                ? IconButton(
                    onPressed: () {
                      setState(() {
                        _isObscure = !_isObscure;
                      });
                    },
                    icon: _isObscure
                        ? const Icon(
                            Icons.visibility_off,
                            color: kTextFieldColor,
                          )
                        : const Icon(
                            Icons.visibility,
                            color: kPrimaryColor,
                          ))
                : null,
          ),
        ));
  }

  void getPhoneNumber(String phoneNumber) async {
    PhoneNumber number =
        await PhoneNumber.getRegionInfoFromPhoneNumber(phoneNumber, 'US');

    setState(() {
      this.number = number;
    });
  }
}
