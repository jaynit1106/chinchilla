import 'package:customer_app/graphQL/query.dart';
import 'package:customer_app/views/screens/bottom_nav/customer_app.dart';
import 'package:customer_app/views/screens/login_flow/data_entry_screen.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class UserCheck extends StatelessWidget {
  final String phone;
  UserCheck(this.phone);
  @override
  Widget build(BuildContext context) {
    return Query(
        options: QueryOptions(
            document: gql(userByPhone), variables: {'phone': phone}),
        builder: (QueryResult result,
            {VoidCallback? refetch, FetchMore? fetchMore}) {
          if (result.hasException) {
            return Text(result.exception.toString());
          }
          if (result.isLoading) {
            return CircularProgressIndicator();
          }
          if (result.data!['customerByPhone'] != null) {
            return CustomerApp();
          }
          return DataEntryScreen();
        });
  }
}
