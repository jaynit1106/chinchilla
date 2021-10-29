import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:intl/intl.dart';
import 'package:customer_app/services/graphql_services.dart';
import 'package:customer_app/controllers/addSubsController.dart';
import 'package:customer_app/controllers/user_controller.dart';
import 'package:customer_app/graphQL/query.dart';
import 'package:customer_app/utils/dates.dart';
import 'package:customer_app/dataModels/product_model.dart';
import 'package:customer_app/graphQL/mutation.dart';
import 'package:customer_app/views/screens/side_nav/address.dart';
import 'package:customer_app/views/screens/success.dart';
import 'package:customer_app/views/widgets/snackbar.dart';

class SubscriptionPage extends StatelessWidget {
  final UserController _userController = Get.find();
  final GraphQLService _graphQLService = Get.find();
  final AddSubsController _addSubsController = Get.find();
  final TextEditingController _frequency = TextEditingController();
  final Product product;
  SubscriptionPage({required this.product});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Subscription'),
      ),
      body: GraphQLProvider(
        client: _graphQLService.client,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: SingleChildScrollView(
              child: Obx(
            () => Column(
              children: [
                Text(
                  'Product',
                  style: Get.textTheme.headline6,
                ),
                ListTile(
                  leading: Image.network(
                    product.photoURL,
                  ),
                  title: Text(product.name),
                  subtitle: Text(
                    '₹ ${product.price.toString()}',
                  ),
                  trailing: Container(
                    width: Get.width * 0.32,
                    child: Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            _addSubsController.subtractQuantity();
                          },
                          icon: Icon(Icons.remove),
                        ),
                        Text(_addSubsController.quantity.value.toString()),
                        IconButton(
                          onPressed: () {
                            _addSubsController.addQuantity();
                          },
                          icon: Icon(Icons.add),
                        ),
                      ],
                    ),
                  ),
                ),
                Text(
                  'Select address',
                  style: Get.textTheme.headline6,
                ),
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
                      if (result.data!['customer']['addresses'].length == 0) {
                        return TextButton(
                            onPressed: () {
                              Get.to(() => AddressScreen());
                            },
                            child: Text('Please add a delivery address'));
                      }
                      if (result.data!['customer']['addresses'].length > 0) {
                        _addSubsController.selectAddressID(
                            result.data!['customer']['addresses'][0]['id']);
                        return Container(
                          child: ListView.builder(
                              shrinkWrap: true,
                              itemCount:
                                  result.data!['customer']['addresses'].length,
                              itemBuilder: (context, index) {
                                return Obx(() => RadioListTile<String>(
                                      groupValue:
                                          _addSubsController.addressID.value,
                                      value: result.data!['customer']
                                          ['addresses'][index]['id'],
                                      title: Text(result.data!['customer']
                                          ['addresses'][index]['name']),
                                      onChanged: (String? value) {
                                        _addSubsController
                                            .selectAddressID(value!);
                                      },
                                    ));
                              }),
                        );
                      }
                      return Center(
                        child: Text('No address found.'),
                      );
                    }),
                Text(
                  'Delivery days',
                  style: Get.textTheme.headline6,
                ),
                RadioListTile(
                  groupValue: _addSubsController.selectedRadio.value,
                  value: 1,
                  onChanged: (int? value) {
                    _addSubsController.selectRadio(value!);
                  },
                  title: Text('Everyday'),
                ),
                RadioListTile(
                  groupValue: _addSubsController.selectedRadio.value,
                  value: -1,
                  onChanged: (int? value) {
                    _addSubsController.selectRadio(value!);
                  },
                  title: Text('One day'),
                ),
                RadioListTile(
                  groupValue: _addSubsController.selectedRadio.value,
                  value: 2,
                  onChanged: (int? value) {
                    _addSubsController.selectRadio(value!);
                  },
                  title: Text('Alternate day'),
                ),
                RadioListTile(
                  groupValue: _addSubsController.selectedRadio.value,
                  value: 0,
                  onChanged: (int? value) {
                    _addSubsController.selectRadio(value!);
                  },
                  title: Text('On interval'),
                  subtitle: _addSubsController.selectedRadio.value == 0
                      ? TextField(
                          keyboardType: TextInputType.number,
                          controller: _frequency,
                          decoration: InputDecoration(
                            hintText: 'n',
                            labelText: 'After every \'n\' days',
                          ),
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          onChanged: (value) {
                            _addSubsController.setFrequency(int.parse(value));
                          },
                        )
                      : Container(),
                ),
                ListTile(
                  leading: Icon(Icons.calendar_today),
                  title: Text(_addSubsController.selectedRadio.value != -1
                      ? 'Start from:'
                      : 'Delivery date:'),
                  subtitle: Text(DateFormat.yMMMMd('en_US')
                      .format(_addSubsController.startDate.value)
                      .toString()),
                  trailing: TextButton(
                      onPressed: () async {
                        final DateTime? picked = await showDatePicker(
                          context: context,
                          initialDate: _addSubsController.startDate.value,
                          firstDate: leastPermittedDate,
                          lastDate: DateTime(today.year + 2),
                        );
                        if (picked != null) {
                          _addSubsController.selectStartDate(picked);
                        }
                      },
                      child: Text('SELECT')),
                ),
                _addSubsController.selectedRadio.value != -1
                    ? ListTile(
                        leading: Icon(Icons.calendar_today),
                        title: Text('Ends'),
                        subtitle: Text(
                            _addSubsController.endDate.value != current
                                ? DateFormat.yMMMMd('en_US')
                                    .format(_addSubsController.endDate.value)
                                : 'NEVER'),
                        trailing: Container(
                          width: Get.height * 0.133,
                          child: Row(
                            children: [
                              IconButton(
                                  onPressed: () {
                                    _addSubsController.removeEndDate();
                                  },
                                  icon: Icon(Icons.delete)),
                              TextButton(
                                  onPressed: () async {
                                    final DateTime? picked =
                                        await showDatePicker(
                                      context: context,
                                      initialDate: _addSubsController
                                                  .endDate.value !=
                                              current
                                          ? _addSubsController.endDate.value
                                          : _addSubsController.startDate.value,
                                      firstDate:
                                          _addSubsController.startDate.value,
                                      lastDate: DateTime(today.year + 2),
                                    );
                                    if (picked != null) {
                                      _addSubsController.endDate(picked);
                                    }
                                  },
                                  child: Text('SELECT')),
                            ],
                          ),
                        ),
                      )
                    : Container(),
                SizedBox(
                  height: 10.0,
                ),
                Text(
                  'Order before 07:30 pm to get items delivered next day.',
                  style: TextStyle(
                      color: Colors.blueGrey, fontStyle: FontStyle.italic),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Mutation(
                  options: MutationOptions(
                    document: gql(addOrder),
                    update: (GraphQLDataProxy orderCache,
                            QueryResult? orderResult) =>
                        orderCache,
                    onError: (orderError) {
                      Get.to(() => Success(
                          isSuccess: false, message: 'Please try again later'));
                    },
                    onCompleted: (dynamic orderData) {
                      Get.to(() => Success(
                          isSuccess: true,
                          message: 'Your order has been placed successfully.'));
                    },
                  ),
                  builder: (
                    RunMutation addOrder,
                    QueryResult? orderRes,
                  ) {
                    return Mutation(
                        options: MutationOptions(
                          document: gql(addSubs),
                          update:
                              (GraphQLDataProxy cache, QueryResult? result) =>
                                  cache,
                          onError: (subsError) => Get.to(() => Success(
                              isSuccess: false,
                              message: 'Please try again later')),
                          onCompleted: (dynamic subsData) {
                            Get.to(() => Success(
                                isSuccess: true,
                                message: 'Your subscription has been added.'));
                          },
                        ),
                        builder: (
                          RunMutation addSubs,
                          QueryResult? subsResult,
                        ) {
                          return ElevatedButton(
                              onPressed: () {
                                if (_addSubsController.addressID.value != '') {
                                  if (_addSubsController.selectedRadio.value !=
                                      -1) {
                                    if (_addSubsController.endDate.value !=
                                        current) {
                                      addSubs({
                                        "customerID":
                                            _userController.user.value.id,
                                        "items": _addSubsController
                                            .getCartItems(product.id),
                                        "startDate": _addSubsController
                                            .startDate.value
                                            .toUtc()
                                            .toIso8601String(),
                                        "endDate": _addSubsController
                                            .endDate.value
                                            .toUtc()
                                            .toIso8601String(),
                                        "addressID":
                                            _addSubsController.addressID.value,
                                        "frequency":
                                            _addSubsController.getFrequency(),
                                      });
                                    } else {
                                      addSubs({
                                        "customerID":
                                            _userController.user.value.id,
                                        "items": _addSubsController
                                            .getCartItems(product.id),
                                        "startDate": _addSubsController
                                            .startDate.value
                                            .toUtc()
                                            .toIso8601String(),
                                        "addressID":
                                            _addSubsController.addressID.value,
                                        "frequency":
                                            _addSubsController.getFrequency(),
                                      });
                                    }
                                  } else {
                                    addOrder({
                                      "customerID":
                                          _userController.user.value.id,
                                      "routeID":
                                          _userController.user.value.routeID,
                                      "items": _addSubsController
                                          .getCartItems(product.id),
                                      "deliveryDate": _addSubsController
                                          .startDate.value
                                          .toUtc()
                                          .toIso8601String(),
                                      "addressID":
                                          _addSubsController.addressID.value,
                                    });
                                  }
                                } else {
                                  launchSnack('No address',
                                      'Please select your delivery address');
                                }
                              },
                              child: Text('Confirm'));
                        });
                  },
                ),
              ],
            ),
          )),
        ),
      ),
    );
  }
}
