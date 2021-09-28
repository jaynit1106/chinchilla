import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:customer_app/services/graphql_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:customer_app/views/screens/customer_app.dart';
import 'package:customer_app/views/screens/login_screen.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class RootCheck extends StatelessWidget {
  final GraphQLService _graphQLService = Get.find();
  @override
  Widget build(BuildContext context) {
    return (FirebaseAuth.instance.currentUser != null)
        ? GraphQLProvider(
            client: _graphQLService.client,
            child: CustomerApp(),
          )
        : GraphQLProvider(
            client: _graphQLService.client,
            child: LoginScreen(),
          );
  }
}
