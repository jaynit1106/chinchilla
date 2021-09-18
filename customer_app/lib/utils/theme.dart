import 'package:flutter/material.dart';
import 'package:customer_app/utils/color.dart';

final lightTheme = ThemeData(
  backgroundColor: kBgColor,
  fontFamily: 'Lato',
  primarySwatch: kPrimaryColor,
  textTheme: TextTheme(
    headline1:
        TextStyle(color: kBlack, fontSize: 24, fontWeight: FontWeight.w500),
  ),
  accentColor: kAccentColor,
  primaryTextTheme: TextTheme(
    headline6: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
  ),
  appBarTheme: AppBarTheme(
    backgroundColor: kBgColor,
    iconTheme: IconThemeData(color: kBlack),
    titleTextStyle: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
    actionsIconTheme: IconThemeData(color: kBlack),
    textTheme: TextTheme(
      headline1: TextStyle(color: kBlack),
    ),
  ),
);
