import 'package:flutter/material.dart';

// Colors
const Color kDarkRedColor = Color(0xFFD21F3C);
const Color kLightRedColor = Color(0xFFEA3C53);
const Color kLightBlueColor = Color(0xFFD4F1F4);
const Color kOffWhiteColor = Color(0xFFFFFAF0);

// Text Styles
const TextStyle kHeadlineOneTextStyle = TextStyle(
  fontWeight: FontWeight.w900,
  fontSize: 64.0,
  color: Colors.black,
);

const TextStyle kHeadlineTwoTextStyle = TextStyle(
  fontWeight: FontWeight.w800,
  fontSize: 48.0,
  color: Colors.black,
);

const TextStyle kHeadlineThreeTextStyle = TextStyle(
  fontWeight: FontWeight.w700,
  fontSize: 32.0,
  color: Colors.black,
);

const TextStyle kHeadlineSixTextStyle = TextStyle(
  fontWeight: FontWeight.w300,
  fontSize: 20.0,
  color: Colors.black,
);

const TextStyle kButtonTextStyle = TextStyle(
  fontSize: 32.0,
  color: Colors.white,
  fontWeight: FontWeight.w700,
);

const TextStyle kLabelTextStyle = TextStyle(
  fontWeight: FontWeight.w700,
  fontSize: 28.0,
  color: kDarkRedColor,
);

const InputDecoration kTextFieldInputDecoration = InputDecoration(
  labelStyle: kLabelTextStyle,
  contentPadding: EdgeInsets.all(16.0),
  border: InputBorder.none,
  disabledBorder: InputBorder.none,
  enabledBorder: InputBorder.none,
  focusedBorder: InputBorder.none,
  errorBorder: InputBorder.none,
  focusedErrorBorder: InputBorder.none,
);
