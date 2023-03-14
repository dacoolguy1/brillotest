import 'package:brillotest/PreScreens/register.dart';
import 'package:brillotest/MainScreens/homepage.dart';
import 'package:firebase_phone_auth_handler/firebase_phone_auth_handler.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../constant.dart';

class verificationCode extends StatefulWidget {
  static const String id = 'verification code';
  final String verificationId;
  final String phoneNumber;

  //verificationCode({Key? key}) : super(key: key);
  static Route route(String verificationId, String phoneNumber) {
    return MaterialPageRoute(
        settings: RouteSettings(name: id),
        builder: (_) => verificationCode(
              verificationId: verificationId,
              phoneNumber: phoneNumber,
            ));
  }

  verificationCode({required this.verificationId, required this.phoneNumber});

  //final registerDetails register;

  // const verificationCode({
  //   //required this.register,
  // });

  @override
  State<verificationCode> createState() => _verificationCodeState();
}

class _verificationCodeState extends State<verificationCode> {
  TextEditingController controller = TextEditingController();
  final phoneEditingController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  bool _isLoading = false;
  String _errorMessage = '';
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _sendVerificationCode();
  }

  void _sendVerificationCode() async {
    //final TextEditingController _phoneNumberController = TextEditingController();
    phoneEditingController.text = Registeration.phonenumber;
    final String phoneNumber = '+234 ' + phoneEditingController.text.trim();

    setState(() {
      //  _isLoading = true;
      _errorMessage = '';
    });
    print('wrjn on rion wrionn onwg');
    print(phoneNumber);

    //Start the phone number verification process
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: (PhoneAuthCredential credential) {},
      verificationFailed: (FirebaseAuthException exception) {
        setState(() {
          // _isLoading = false;
          _errorMessage = exception.message ??
              'An error occurred while sending the verification code.';
        });
      },
      codeSent: (String verificationId, int? resendToken) {
        setState(() {
          print('it has been sent');
          // _isLoading = false;
        });
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => verificationCode(
                verificationId: verificationId, phoneNumber: phoneNumber),
          ),
        );
        print('it was successful');
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }

  void _signInWithPhoneNumber() async {
    final String verificationCode = controller.text.trim();

    setState(() {
      //_isLoading = true;
      _errorMessage = '';
      print(controller.text);
      // Navigator.pushNamed(
      //   context,
      //   Homepage.id,
      // );
    });
//    _isLoading = false;

    // Sign in with the verification code
    final credential = PhoneAuthProvider.credential(
        verificationId: widget.verificationId, smsCode: verificationCode);
    try {
      await FirebaseAuth.instance.signInWithCredential(credential);
      // _isLoading = false;
      Navigator.pushNamed(context, HomePage.id);
      // Navigator.pushAndRemoveUntil(
      // context,
      //aterialPageRoute(builder: (context) => Homepage()),
      // (_) => false,
      //);
    } catch (e) {
      setState(() {
        //  _isLoading = false;
        _errorMessage = 'Invalid verification code entered.';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        body: Form(
          key: formKey,
          child: SafeArea(
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
                    'Enter Verification Code',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Center(
                  child: Text('Kindly input the verification code we',
                      style: TextStyle(
                          fontWeight: FontWeight.w100,
                          color: Colors.grey,
                          fontSize: 16,
                          fontFamily: 'ProductSans')),
                ),
                Center(
                    child: Text('sent to ${Registeration.phonenumber}',
                        style: const TextStyle(
                            fontWeight: FontWeight.w100,
                            color: Colors.grey,
                            fontSize: 16,
                            fontFamily: 'ProductSans'))),
                const SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: kDefaultPadding,
                  child: PinCodeTextField(
                      appContext: context,
                      controller: controller,
                      length: 6,
                      keyboardType: TextInputType.number,
                      pinTheme: PinTheme(
                        shape: PinCodeFieldShape.box,
                        fieldWidth: 50,
                        activeColor: Color(0xff0057C1),
                        inactiveColor: Color(0xff0057C1),
                        selectedColor: Color(0xff0057C1),
                        selectedFillColor: Color(0xff0057C1),
                        inactiveFillColor: Color(0xff0057C1),
                      ),
                      onChanged: ((value) {})),
                ),
                const SizedBox(
                  height: 30,
                ),
                ElevatedButton(
                  onPressed: _isLoading ? null : _signInWithPhoneNumber,
                  child: _isLoading
                      ? const CircularProgressIndicator()
                      : Padding(
                          child: Container(
                            alignment: Alignment.center,
                            width: 348.0,
                            height: 60.0,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: Color(0xff0057C1)),
                            child: Text(
                              "Verify",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontFamily: 'ProductSans'),
                            ),
                          ),
                          padding: kDefaultPadding,
                        ),
                ),
                if (_errorMessage.isNotEmpty) SizedBox(height: 16.0),
                if (_errorMessage.isNotEmpty)
                  Text(
                    _errorMessage,
                    style: TextStyle(color: Colors.red),
                  ),
                GestureDetector(
                    onTap: () async {
                      Container(
                        height: 400,
                      );

                      if (!formKey.currentState!.validate()) {
                        // setState(() {
                        //   _isLoading = true;
                        // });
                        return;
                      }

                      print(controller.text);

                      _signInWithPhoneNumber;
                      // print('signed i');
                      // String _verificationId = '';

                      // void _onVerificationIdReceived(String verificationId) {
                      //   setState(() {
                      //     _verificationId = verificationId;
                      //   });
                      // }

                      // // Now you can use the _verificationId variable to pass the verification ID to the next page or to the function that handles verification code entry.
                      // print(controller.text);
                      // final String verificationCode = controller
                      //     .text; // Prompt the user to enter the verification code

                      // final PhoneAuthCredential phoneAuthCredential =
                      //     PhoneAuthProvider.credential(
                      //         verificationId:
                      //             _onVerificationIdReceived.toString(),
                      //         smsCode: verificationCode);

                      // final authCredential = await FirebaseAuth.instance
                      //     .signInWithCredential(phoneAuthCredential);
                      // print('User is signed in: ${authCredential.user}');
                    },
                    child: Text('')),
                SizedBox(
                  height: 20,
                ),
                Center(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(
                        child: Text('Did not receive the code ?     ',
                            style: TextStyle(
                                fontSize: 14,
                                fontFamily: 'ProductSans',
                                fontWeight: FontWeight.w200)),
                      ),
                      InkWell(
                        onTap: () {
                          // Navigator.pushNamed(context, tenantorraltor.id);
                        },
                        child: Center(
                          child: Text(
                            'Resend Code',
                            style: TextStyle(
                                fontSize: 14,
                                fontFamily: 'ProductSans',
                                fontWeight: FontWeight.w700),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ])),
        ),
      ),
    );
  }
}
