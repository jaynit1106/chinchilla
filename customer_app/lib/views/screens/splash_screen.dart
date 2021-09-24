import 'dart:async';

import 'package:customer_app/services/graphql_services.dart';
import 'package:customer_app/views/screens/root.dart';
import 'package:customer_app/views/screens/select_location.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashView extends StatefulWidget {
  @override
  _SplashViewState createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  GraphQLService _graphQLService = Get.find();
  locationCheck() async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    if (_pref.getBool('locationStatus') == null ||
        _pref.getBool('locationStatus') != true) {
      Get.off(SelectLocation());
    } else {
      Get.off(RootCheck());
    }
  }

  @override
  void initState() {
    super.initState();
    _graphQLService.setupGraphQL();
    Timer(Duration(seconds: 3), () => locationCheck());
  }

  @override
  Widget build(BuildContext context) {
    return GraphQLProvider(
      client: _graphQLService.client,
      child: Scaffold(
        body: Center(
            child: Lottie.asset(
          'assets/splash/splash.json',
          repeat: false,
          reverse: false,
          animate: true,
          fit: BoxFit.fill,
        )),
      ),
    );
  }
}
