import 'package:flutter/material.dart';
import 'package:customer_app/utils/color.dart';

final lightTheme = ThemeData(
  backgroundColor: kBgColor,
  fontFamily: 'Lato',
  primarySwatch: kPrimaryColor,
  accentColor: kAccentColor,
  appBarTheme: AppBarTheme(
    backgroundColor: kBgColor,
    iconTheme: IconThemeData(color: kBlack),
    centerTitle: true,
    actionsIconTheme: IconThemeData(color: kBlack),
    textTheme: TextTheme(
      headline1: TextStyle(color: kBlack),
    ),
  ),
);
