import 'package:customer_app/views/screens/customer_app.dart';
import 'package:customer_app/views/screens/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RootCheck extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return (FirebaseAuth.instance.currentUser != null)
        ? CustomerApp()
        : LoginScreen();
  }
}
