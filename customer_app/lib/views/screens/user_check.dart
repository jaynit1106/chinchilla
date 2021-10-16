import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:customer_app/controllers/authController.dart';
import 'package:customer_app/controllers/user_controller.dart';
import 'package:customer_app/graphQL/query.dart';
import 'package:customer_app/views/screens/bottom_nav/customer_app.dart';
import 'package:customer_app/views/screens/login_flow/data_entry_screen.dart';

class UserCheck extends StatelessWidget {
  final AuthController _authController = Get.find();
  final UserController _userController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Query(
        options: QueryOptions(
            document: gql(userByPhone),
            variables: {'phone': _authController.getCurrentUserPhone()}),
        builder: (QueryResult result,
            {VoidCallback? refetch, FetchMore? fetchMore}) {
          if (result.hasException) {
            return Text(result.exception.toString());
          }
          if (result.isLoading) {
            return CircularProgressIndicator();
          }
          if (result.data!['customerByPhone'] != null) {
            _userController.user.value.id =
                result.data!['customerByPhone']['id'];
            _userController.user.value.firstName =
                result.data!['customerByPhone']['firstName'];
            _userController.user.value.lastName =
                result.data!['customerByPhone']['lastName'];
            _userController.user.value.phone =
                result.data!['customerByPhone']['phone'];
            _userController.user.value.wallet =
                result.data!['customerByPhone']['wallet'];
            _userController.user.value.routeID =
                result.data!['customerByPhone']['location']['routeID'];
            _userController.user.value.hubID =
                result.data!['customerByPhone']['location']['region']['hubID'];
            return CustomerApp();
          }
          return DataEntryScreen();
        });
  }
}
