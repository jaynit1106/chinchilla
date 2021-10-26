import 'package:customer_app/controllers/productController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:customer_app/controllers/user_controller.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:customer_app/graphQL/query.dart';
import 'package:customer_app/views/widgets/subs_card.dart';
import 'package:customer_app/views/widgets/order_card.dart';
import 'package:customer_app/dataModels/item_model.dart';
import 'package:customer_app/utils/enums/enums.dart';

class HomeWidget extends StatelessWidget {
  final UserController _userController = Get.find();
  final ProductController _productController = Get.find();
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            height: Get.height * 0.22,
            padding: EdgeInsets.only(right: 6),
            child: Image.asset(
              'assets/images/ss-cover.png',
            ),
          ),
          Query(
              options: QueryOptions(
                document: gql(products),
                variables: {'hubID': _userController.user.value.hubID},
              ),
              builder: (QueryResult result,
                  {VoidCallback? refetch, FetchMore? fetchMore}) {
                if (result.hasException) {
                  return Text(result.exception.toString());
                }
                if (result.isLoading) {
                  return Center(child: CircularProgressIndicator());
                }
                if (result.data!['hub']['products'].length > 0) {
                  if (!_productController.productsAdded.value) {
                    _productController
                        .addProducts(result.data!['hub']['products']);
                    _productController.productsAdded.value = true;
                  }
                }
                return Container();
              }),
          Query(
              options: QueryOptions(
                document: gql(customerHome),
                variables: {'id': _userController.user.value.id},
              ),
              builder: (QueryResult result,
                  {VoidCallback? refetch, FetchMore? fetchMore}) {
                if (result.hasException) {
                  return Text(result.exception.toString());
                }
                if (result.isLoading) {
                  return Center(child: CircularProgressIndicator());
                }
                if (result.data!['customer'] != null) {
                  return Column(
                    children: [
                      Column(
                          children: result.data!['customer']['ordersForToday']
                                      .length >
                                  0
                              ? [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 8.0),
                                    child: Text(
                                      'Order for Today',
                                      style: Get.textTheme.headline1,
                                    ),
                                  ),
                                  Container(
                                    height: Get.height * 0.2,
                                    child: ListView.builder(
                                        scrollDirection: Axis.vertical,
                                        shrinkWrap: true,
                                        itemCount: result
                                            .data!['customer']['ordersForToday']
                                            .length,
                                        itemBuilder: (context, index) {
                                          return OrderCard(
                                            price: 200,
                                            status: parseOrderStatusEnum(
                                              result.data!['customer']
                                                      ['ordersForToday'][index]
                                                  ['status'],
                                            ),
                                            date: result.data!['customer']
                                                    ['ordersForToday'][index]
                                                ['deliveryDate'],
                                            items: result.data!['customer']
                                                    ['ordersForToday'][index]
                                                    ['items']
                                                .map(
                                                  (item) => Item(
                                                      name: _productController
                                                          .getProductName(item[
                                                              'productID']),
                                                      quantity:
                                                          item['quantity']),
                                                )
                                                .toList(),
                                          );
                                        }),
                                  ),
                                ]
                              : [Container()]),
                      Column(
                          children: result.data!['customer']['subscriptions']
                                      .length >
                                  0
                              ? [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 8.0),
                                    child: Text(
                                      'Subscriptions',
                                      style: Get.textTheme.headline1,
                                    ),
                                  ),
                                  Container(
                                    height: Get.height * 0.30,
                                    child: ListView.builder(
                                        scrollDirection: Axis.vertical,
                                        shrinkWrap: true,
                                        itemCount: result
                                            .data!['customer']['subscriptions']
                                            .length,
                                        itemBuilder: (context, index) {
                                          return SubsCard(
                                              price: 200,
                                              status: parseSubsStatusEnum(
                                                  result.data!['customer']
                                                          ['subscriptions']
                                                      [index]['status']),
                                              nextDeliveryDate:
                                                  result.data!['customer']
                                                          ['subscriptions'][index]
                                                      ['nextDeliveryDate'],
                                              items: result.data!['customer']
                                                      ['subscriptions'][index]
                                                      ['items']
                                                  .map(
                                                    (item) => Item(
                                                        name: _productController
                                                            .getProductName(item[
                                                                'productID']),
                                                        quantity:
                                                            item['quantity']),
                                                  )
                                                  .toList(),
                                              frequency: result.data!['customer']
                                                      ['subscriptions'][index]
                                                  ['frequency']);
                                        }),
                                  ),
                                ]
                              : [Container()]),
                    ],
                  );
                }
                return Center(
                  child: Text('Something went wrong!!'),
                );
              }),
        ],
      ),
    );
  }
}
