import 'package:brillotest/MainScreens/profile.dart';
import 'package:brillotest/MainScreens/settings.dart';
import 'package:brillotest/PreScreens/Login.dart';
import 'package:brillotest/PreScreens/forgotpassword.dart';
import 'package:brillotest/PreScreens/register.dart';
import 'package:brillotest/PreScreens/verificationpage.dart';
import 'package:brillotest/config/approuter.dart';
import 'package:brillotest/firebase_constants.dart';
import 'package:brillotest/MainScreens/homepage.dart';
import 'package:firebase_phone_auth_handler/firebase_phone_auth_handler.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await firebaseInitialization;
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return FirebasePhoneAuthProvider(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Registeration(),
        onGenerateRoute: AppRouter.onGenerateRoute,
        routes: {
          // '/verification_code': (context) => verificationCode(),
          UserProfile.id: (context) => UserProfile(),
          Registeration.id: (context) => Registeration(),
          HomePage.id: (context) => HomePage(),
          LoginPage.id: (context) => LoginPage(),
          SettingsPage.main: (context) => SettingsPage(),
          ForgotPasswordPage.id: (context) => ForgotPasswordPage(),

          //  verificationCode.id: (context) => verificationCode.()
        },
      ),
    );
  }
}
