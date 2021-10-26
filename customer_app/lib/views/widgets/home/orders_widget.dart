import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:customer_app/controllers/productController.dart';
import 'package:customer_app/controllers/user_controller.dart';
import 'package:customer_app/dataModels/item_model.dart';
import 'package:customer_app/graphQL/query.dart';
import 'package:customer_app/utils/dates.dart';
import 'package:customer_app/utils/enums/enums.dart';
import 'package:customer_app/views/widgets/order_card.dart';

class OrdersView extends StatelessWidget {
  final UserController _userController = Get.find();
  final ProductController _productController = Get.find();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Text(
              'Past 30 days one time orders',
              style: Get.textTheme.headline1,
            ),
          ),
          Query(
              options: QueryOptions(
                  document: gql(past30DaysOneTimeOrders),
                  variables: {
                    "customerID": _userController.user.value.id,
                    "startDate": before30DaysFormat,
                    "endDate": past1000DaysFormat,
                  }),
              builder: (QueryResult result,
                  {VoidCallback? refetch, FetchMore? fetchMore}) {
                if (result.hasException) {
                  return Text(result.exception.toString());
                }
                if (result.isLoading) {
                  return CircularProgressIndicator();
                }
                if (result.data!['OneTimeOrdersByCustomerIDAndDate'].length >
                    0) {
                  return Container(
                    height: Get.height * 0.8,
                    child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        itemCount: result
                            .data!['OneTimeOrdersByCustomerIDAndDate'].length,
                        itemBuilder: (context, index) {
                          return OrderCard(
                            price: _productController.calculateTotal(
                                result.data!['OneTimeOrdersByCustomerIDAndDate']
                                    [index]['items']),
                            status: parseOrderStatusEnum(
                              result.data!['OneTimeOrdersByCustomerIDAndDate']
                                  [index]['status'],
                            ),
                            date:
                                result.data!['OneTimeOrdersByCustomerIDAndDate']
                                    [index]['deliveryDate'],
                            items: result
                                .data!['OneTimeOrdersByCustomerIDAndDate']
                                    [index]['items']
                                .map(
                                  (item) => Item(
                                      name: _productController
                                          .getProductName(item['productID']),
                                      quantity: item['quantity']),
                                )
                                .toList(),
                          );
                        }),
                  );
                }
                return Center(child: Text('No orders found'));
              })
        ],
      ),
    );
  }
}
