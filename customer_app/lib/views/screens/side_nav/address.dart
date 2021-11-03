import 'package:customer_app/controllers/addressController.dart';
import 'package:customer_app/graphQL/mutation.dart';
import 'package:customer_app/utils/color.dart';
import 'package:customer_app/views/screens/success.dart';
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
  final AddressController _addressController = Get.find();
  final TextEditingController _address = TextEditingController();
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
                            child: Mutation(
                              options: MutationOptions(
                                document: gql(addAddress),
                                update: (GraphQLDataProxy addressCache,
                                        QueryResult? addressResult) =>
                                    addressCache,
                                onError: (addressError) {
                                  Get.to(() => Success(
                                        isSuccess: false,
                                        message: 'Please try again later',
                                        popCount: 3,
                                      ));
                                },
                                onCompleted: (dynamic addressData) {
                                  Get.to(() => Success(
                                      isSuccess: true,
                                      popCount: 3,
                                      message:
                                          'Address has been added successfully'));
                                },
                              ),
                              builder: (
                                RunMutation addAddress,
                                QueryResult? addressRes,
                              ) {
                                return ListTile(
                                  title: Text(result.data!['customer']
                                      ['addresses'][index]['name']),
                                  trailing: IconButton(
                                    onPressed: () {
                                      launchSnack('Coming soon',
                                          'Editing address coming soon with next version');
                                      // Todo: Add edit address option
                                      // Get.bottomSheet(
                                      //     Padding(
                                      //       padding: const EdgeInsets.all(16.0),
                                      //       child: Column(
                                      //         mainAxisAlignment:
                                      //             MainAxisAlignment
                                      //                 .spaceBetween,
                                      //         crossAxisAlignment:
                                      //             CrossAxisAlignment.center,
                                      //         children: [
                                      //           Text(
                                      //             'Add new address',
                                      //             style:
                                      //                 Get.textTheme.headline1,
                                      //           ),
                                      //           TextField(
                                      //             controller: _address,
                                      //             decoration: InputDecoration(
                                      //               hintText:
                                      //                   'HN 1, Tech block, Gepton city - 123456',
                                      //               labelText:
                                      //                   'Please enter your complete address',
                                      //             ),
                                      //             onChanged: (String value) {
                                      //               _addressController
                                      //                   .name.value = value;
                                      //             },
                                      //           ),
                                      //           ElevatedButton(
                                      //             onPressed: () {
                                      //               if (_addressController
                                      //                       .name.value !=
                                      //                   '') {
                                      //                 addAddress({
                                      //                   "customerID":
                                      //                       _userController
                                      //                           .user.value.id,
                                      //                   "name":
                                      //                       _addressController
                                      //                           .name.value,
                                      //                 });
                                      //               } else {
                                      //                 launchSnack('Error',
                                      //                     'Address can\'t be null');
                                      //               }
                                      //             },
                                      //             child: Text('Add address'),
                                      //           ),
                                      //         ],
                                      //       ),
                                      //     ),
                                      //     backgroundColor: kBgColor);
                                    },
                                    icon: Icon(Icons.edit),
                                  ),
                                );
                              },
                            ),
                          );
                        });
                  }
                  return Center(
                    child: Text('No address found.'),
                  );
                }),
            Mutation(
              options: MutationOptions(
                document: gql(addAddress),
                update: (GraphQLDataProxy addressCache,
                        QueryResult? addressResult) =>
                    addressCache,
                onError: (addressError) {
                  Get.to(() => Success(
                        isSuccess: false,
                        message: 'Please try again later',
                        popCount: 3,
                      ));
                },
                onCompleted: (dynamic addressData) {
                  Get.to(() => Success(
                      isSuccess: true,
                      popCount: 3,
                      message: 'Address has been added successfully'));
                },
              ),
              builder: (
                RunMutation addAddress,
                QueryResult? addressRes,
              ) {
                return ElevatedButton(
                    onPressed: () {
                      Get.bottomSheet(
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  'Add new address',
                                  style: Get.textTheme.headline1,
                                ),
                                TextField(
                                  controller: _address,
                                  decoration: InputDecoration(
                                    hintText:
                                        'HN 1, Tech block, Gepton city - 123456',
                                    labelText:
                                        'Please enter your complete address',
                                  ),
                                  onChanged: (String value) {
                                    _addressController.name.value = value;
                                  },
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    if (_addressController.name.value != '') {
                                      addAddress({
                                        "customerID":
                                            _userController.user.value.id,
                                        "name": _addressController.name.value,
                                      });
                                    } else {
                                      launchSnack(
                                          'Error', 'Address can\'t be null');
                                    }
                                  },
                                  child: Text('Add address'),
                                ),
                              ],
                            ),
                          ),
                          backgroundColor: kBgColor);
                    },
                    child: Text(' Add new address'));
              },
            )
          ],
        ),
      ),
    );
  }
}
