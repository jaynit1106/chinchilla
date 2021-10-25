import 'package:customer_app/controllers/user_controller.dart';
import 'package:customer_app/graphQL/query.dart';
import 'package:customer_app/views/widgets/subs_card.dart';
import 'package:flutter/material.dart';
import 'package:customer_app/views/widgets/order_card.dart';
import 'package:customer_app/dataModels/item_model.dart';
import 'package:customer_app/utils/enums/enums.dart';
import 'package:get/get.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class HomeWidget extends StatelessWidget {
  final UserController _userController = Get.find();
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.only(right: 6),
            child: Image.asset(
              'assets/images/ss-cover.png',
            ),
          ),
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
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Text(
                          'Order for Today',
                          style: Get.textTheme.headline1,
                        ),
                      ),
                      OrderCard(
                        price: 200,
                        status: OrderStatus.UNDELIVERED,
                        date: DateTime.now(),
                        items: [
                          Item(name: "Laptop", quantity: 2),
                          Item(name: "Headphones", quantity: 5),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Text(
                          'Subscriptions',
                          style: Get.textTheme.headline1,
                        ),
                      ),
                      SubsCard(
                        price: 200,
                        frequency: 1,
                        status: SubStatus.COMPLETED,
                        nextDeliveryDate: "2021-10-25T20:31:00.120Z",
                        items: [
                          Item(name: "Laptop", quantity: 2),
                          Item(name: "Headphones", quantity: 5),
                        ],
                      ),
                      SubsCard(
                        price: 200,
                        frequency: 2,
                        status: SubStatus.ACTIVE,
                        nextDeliveryDate: "2021-10-25T20:31:00.120Z",
                        items: [
                          Item(name: "Laptop", quantity: 2),
                          Item(name: "Headphones", quantity: 5),
                        ],
                      ),
                      SubsCard(
                        price: 200,
                        frequency: 2,
                        status: SubStatus.PENDING,
                        nextDeliveryDate: "2021-10-25T20:31:00.120Z",
                        items: [
                          Item(name: "Laptop", quantity: 2),
                          Item(name: "Headphones", quantity: 5),
                        ],
                      ),
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
