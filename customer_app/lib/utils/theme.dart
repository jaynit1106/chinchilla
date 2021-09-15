import 'package:flutter/material.dart';
import 'package:customer_app/utils/color.dart';

final lightTheme = ThemeData(
  backgroundColor: kBgColor,
  fontFamily: 'Lato',
  primarySwatch: kPrimaryColor,
  accentColor: Colors.amber,
  appBarTheme: AppBarTheme(
    backgroundColor: kBgColor,
    iconTheme: IconThemeData(color: Colors.black),
    centerTitle: true,
    actionsIconTheme: IconThemeData(color: Colors.black),
    textTheme: TextTheme(
      headline1: TextStyle(color: kBlack),
    ),
  ),
);
