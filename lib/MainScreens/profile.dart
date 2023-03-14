import 'package:brillotest/PreScreens/register.dart';
import 'package:brillotest/constant.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

class UserProfile extends StatefulWidget {
  static String id = 'userProfile';

  const UserProfile({super.key});
  static String phone = '';
  final String phone1 = '';

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  static userphonenumber() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user = auth.currentUser;
    if (user != null) {
      String? phoneNumber = user.phoneNumber;
      if (phoneNumber != null) {
        //   UserProfile.phone = phoneNumber.toString();

        print('User phone number: $phoneNumber');
      } else {
        print('User phone number is not available.');
      }
    } else {
      print('No user is currently logged in.');
    }
    // return PhoneNumber;
  }

  @override
  void initState() {
    super.initState();
    userphonenumber();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          CircleAvatar(
            backgroundImage: AssetImage("assets/images/person.png"),
            radius: 80,
          ),
          SizedBox(
            height: 30,
          ),
          Padding(
              padding: kDefaultPadding,
              child: Text(
                '''Meet Tunde, a young man from Delta state, Nigeria, whose passion and interest lie in football.
                 Tunde love for football started when he was just a child, and he would gather his friends 
                in their neighborhood to play football with makeshift balls. As he grew older, he became more and more passionate about the sport and started playing in local tournaments.''',
                style: TextStyle(fontSize: 13, fontFamily: 'ProductSans'),
              )),
          SizedBox(
            height: 20,
          ),
          Center(
            // padding: kDefaultPadding,
            child: Text('Your Phone Number is ${UserProfile.phone} } ',
                style: TextStyle(fontSize: 14, fontFamily: 'ProductSans')),
          ),
          SizedBox(
            height: 20,
          ),
          Text('Your interest is Football ',
              style: TextStyle(fontSize: 14, fontFamily: 'ProductSans'))
        ],
      )),
    );
  }
}
