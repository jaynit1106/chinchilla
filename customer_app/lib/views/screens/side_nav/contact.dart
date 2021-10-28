import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:customer_app/services/graphql_services.dart';
import 'package:customer_app/controllers/user_controller.dart';
import 'package:customer_app/graphQL/query.dart';
import 'package:customer_app/services/url_launcher.dart';
import 'package:customer_app/views/widgets/icon_card.dart';

class Contact extends StatelessWidget {
  final GraphQLService _graphQLService = Get.find();
  final UserController _userController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contact'),
      ),
      body: GraphQLProvider(
        client: _graphQLService.client,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: SingleChildScrollView(
            child: Query(
              options: QueryOptions(
                  document: gql(contactQuery),
                  variables: {"customerID": _userController.user.value.id}),
              builder: (QueryResult result,
                  {VoidCallback? refetch, FetchMore? fetchMore}) {
                if (result.hasException) {
                  return Text(result.exception.toString());
                }
                if (result.isLoading) {
                  return CircularProgressIndicator();
                }
                if (result.data!['customer']['location'] != null) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Image.network(
                          'https://www.shreesurbhi.com/wp-content/uploads/2021/02/Shree_Surbhi_Logo.png'),
                      SizedBox(
                        height: 10.0,
                      ),
                      Icon(Icons.home),
                      SizedBox(
                        height: 10.0,
                      ),
                      Text(
                        result.data!['customer']['location']['region']['hub']
                            ['hubName'],
                        style: Get.textTheme.headline5,
                      ),
                      Text(
                        '📍 ${result.data!['customer']['location']['region']['hub']['address']}',
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      SingleChildScrollView(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            IconCard(
                              icon: Icons.email_outlined,
                              text: result.data!['customer']['location']
                                  ['region']['hub']['email'],
                              onTap: () => launchUrl(
                                  'mailto:${result.data!['customer']['location']['region']['hub']['email']}'),
                            ),
                            IconCard(
                              icon: Icons.phone,
                              text: result.data!['customer']['location']
                                  ['region']['hub']['mobileNo'],
                              onTap: () => launchUrl(
                                  'tel:${result.data!['customer']['location']['region']['hub']['mobileNo']}'),
                            ),
                          ],
                        ),
                      ),
                      Divider(),
                      SizedBox(
                        height: 10.0,
                      ),
                      Text(
                        'Delivery Executive',
                        style: Get.textTheme.headline1,
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      ListView.builder(
                          shrinkWrap: true,
                          itemCount: result
                              .data!['customer']['location']['route']
                                  ['executive']
                              .length,
                          itemBuilder: (context, index) {
                            return Card(
                              child: ListTile(
                                trailing: Icon(Icons.call),
                                onTap: () => launchUrl(
                                    'tel:${result.data!['customer']['location']['route']['executive'][index]['phone']}'),
                                title: Text(
                                    '${result.data!['customer']['location']['route']['executive'][index]['firstName']} ${result.data!['customer']['location']['route']['executive'][index]['lastName']}'),
                                subtitle: Text(result.data!['customer']
                                        ['location']['route']['executive']
                                    [index]['phone']),
                                leading: Image.network(
                                  result.data!['customer']['location']['route']
                                      ['executive'][index]['photoURL'],
                                  fit: BoxFit.contain,
                                ),
                              ),
                            );
                          }),
                    ],
                  );
                }

                return Center(
                  child: Text('Couldn\'t fetch the data.'),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
