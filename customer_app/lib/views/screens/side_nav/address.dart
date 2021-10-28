import 'package:customer_app/views/widgets/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:customer_app/controllers/user_controller.dart';
import 'package:customer_app/graphQL/query.dart';
import 'package:customer_app/services/graphql_services.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class AddressScreen extends StatelessWidget {
  final GraphQLService _graphQLService = Get.find();
  final UserController _userController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Addresses'),
      ),
      body: GraphQLProvider(
        client: _graphQLService.client,
        child: Column(
          children: [
            Query(
                options: QueryOptions(
                    document: gql(addressQuery),
                    variables: {"id": _userController.user.value.id}),
                builder: (QueryResult result,
                    {VoidCallback? refetch, FetchMore? fetchMore}) {
                  if (result.hasException) {
                    return Text(result.exception.toString());
                  }
                  if (result.isLoading) {
                    return CircularProgressIndicator();
                  }
                  if (result.data!['customer']['addresses'].length > 0) {
                    return ListView.builder(
                        shrinkWrap: true,
                        itemCount: result.data!['customer']['addresses'].length,
                        itemBuilder: (context, index) {
                          return Card(
                            elevation: 5,
                            child: ListTile(
                              title: Text(result.data!['customer']['addresses']
                                  [index]['name']),
                            ),
                          );
                        });
                  }
                  return Center(
                    child: Text('No address found.'),
                  );
                }),
            ElevatedButton(
                onPressed: () {
                  launchSnack('Coming Soon', 'Feature coming with next update');
                },
                child: Text(' Add new address'))
          ],
        ),
      ),
    );
  }
}
