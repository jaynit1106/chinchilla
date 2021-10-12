import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:customer_app/services/graphql_services.dart';
import 'package:customer_app/views/screens/root.dart';

class SplashView extends StatefulWidget {
  @override
  _SplashViewState createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  GraphQLService _graphQLService = Get.find();

  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3), () => Get.off(() => RootCheck()));
    _graphQLService.setupGraphQL();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Lottie.asset(
        'assets/splash/splash.json',
        repeat: false,
        reverse: false,
        animate: true,
        fit: BoxFit.fill,
      )),
    );
  }
}
