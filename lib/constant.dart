import 'package:flutter/material.dart';

const kDefaultPadding = EdgeInsets.symmetric(horizontal: 30);
const kmainPadding = EdgeInsets.symmetric(horizontal: 20);

const kPrimaryColor = Color.fromRGBO(0, 87, 193, 1);
const kTextFieldColor = Color(0xFF979797);

const ktextfieldinputDecoration = InputDecoration(
    hintText: ' ',
    fillColor: Colors.black,
    contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
    border: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.black, width: 2)));
const kTextfieldcode = InputDecoration(
  hintText: 'Input the code here',
  fillColor: Colors.black,
  border: UnderlineInputBorder(
    borderSide: BorderSide(color: Color(0xff0057C1)),
  ),
  enabledBorder: UnderlineInputBorder(
    borderSide: BorderSide(
      color: Color(0xff0057C1),
    ),
  ),
  focusedBorder: UnderlineInputBorder(
    borderSide: BorderSide(
      color: Color(0xff0057C1),
    ),
  ),
);
const kTextfieldsignup = InputDecoration(
  hintText: 'Input the code here',
  fillColor: Colors.black,
  border: UnderlineInputBorder(
    borderSide: BorderSide(color: Colors.grey),
  ),
  enabledBorder: UnderlineInputBorder(
    borderSide: BorderSide(color: Colors.grey),
  ),
  focusedBorder: UnderlineInputBorder(
    borderSide: BorderSide(color: Colors.grey),
  ),
);
const ktextfieldinputDecoration1 = InputDecoration(
  hintText: 'Enter your email',
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Color(0xffA2A0A8), width: 1.0),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Color(0xffA2A0A8), width: 2.0),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
);

const ktextfieldinputDecoration2 = InputDecoration(
  hintText: 'Enter the amount you want to transfer',
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Color(0xffA2A0A8), width: 1.0),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Color(0xffA2A0A8), width: 2.0),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
);
