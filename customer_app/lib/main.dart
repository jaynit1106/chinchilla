import 'package:customer_app/views/screens/customer_app.dart';
import 'package:customer_app/utils/theme.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Customer App',
      home: CustomerApp(),
      theme: lightTheme,
    );
  }
}
