import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:customer_app/graphQL/query.dart';
import 'package:customer_app/controllers/user_controller.dart';
import 'package:customer_app/controllers/productController.dart';
import 'package:customer_app/views/widgets/home/subWidgets/home_order.dart';
import 'package:customer_app/views/widgets/home/subWidgets/home_subscription.dart';

class HomeWidget extends StatelessWidget {
  final UserController _userController = Get.find();
  final ProductController _productController = Get.find();
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          // Home Banner [Image]
          // Displays on top
          Container(
            height: Get.height * 0.22,
            padding: EdgeInsets.only(right: 6),
            child: Image.asset(
              'assets/images/ss-cover.png',
            ),
          ),
          // Query to store products in state
          // Fetched [Products] according to your hub
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
          // Query to fetch ordersFor Today and subscriptions for customer
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
                  return result.data!['customer']['ordersForToday'].length >
                              0 ||
                          result.data!['customer']['subscriptions'].length > 0
                      ? Column(
                          children: [
                            HomeOrder(
                              productController: _productController,
                              ordersForToday: result.data!['customer']
                                  ['ordersForToday'],
                            ),
                            HomeSubscription(
                                productController: _productController,
                                subscription: result.data!['customer']
                                    ['subscriptions']),
                          ],
                        )
                      : Center(
                          child: Text('You haven\'t ordered anything yet'));
                }
                return Center(child: Text('Something went wrong!!'));
              }),
        ],
      ),
    );
  }
}
