import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:customer_app/services/graphql_services.dart';
import 'package:customer_app/views/screens/user_check.dart';
import 'package:customer_app/views/screens/login_flow/login_screen.dart';
import 'package:customer_app/views/screens/login_flow/select_location.dart';

class RootCheck extends StatelessWidget {
  final GraphQLService _graphQLService = Get.find();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: locationCheck(),
        builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
          if (snapshot.hasData) {
            final String? phoneNumber =
                FirebaseAuth.instance.currentUser!.phoneNumber;
            return (FirebaseAuth.instance.currentUser != null)
                ? GraphQLProvider(
                    client: _graphQLService.client,
                    child: UserCheck(
                        phoneNumber!.substring(phoneNumber.length - 10)),
                  )
                : snapshot.data == true
                    ? GraphQLProvider(
                        client: _graphQLService.client,
                        child: LoginScreen(),
                      )
                    : GraphQLProvider(
                        client: _graphQLService.client,
                        child: SelectLocation(),
                      );
          } else if (snapshot.hasError) {
            return Center(
              child: Text("Something went wrong. Please restart the app."),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }
}

Future<bool> locationCheck() async {
  SharedPreferences _pref = await SharedPreferences.getInstance();
  if (_pref.getString('locationID') == null) {
    return false;
  } else {
    return true;
  }
}
