import 'package:flutter/material.dart';
import 'package:customer_app/utils/color.dart';

final lightTheme = ThemeData(
  backgroundColor: kBgColor,
  fontFamily: 'Lato',
  textTheme: TextTheme(
    headline1:
        TextStyle(color: kBlack, fontSize: 24, fontWeight: FontWeight.w500),
  ),
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
  bottomNavigationBarTheme: BottomNavigationBarThemeData().copyWith(
    elevation: 10,
    type: BottomNavigationBarType.fixed,
  ),
  colorScheme: ColorScheme.fromSwatch(primarySwatch: kPrimaryColor)
      .copyWith(secondary: kAccentColor),
);
