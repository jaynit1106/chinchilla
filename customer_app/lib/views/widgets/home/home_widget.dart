import 'package:customer_app/views/widgets/subs_card.dart';
import 'package:flutter/material.dart';
import 'package:customer_app/views/widgets/order_card.dart';
import 'package:customer_app/dataModels/item_model.dart';
import 'package:customer_app/utils/enums/enums.dart';
import 'package:get/get.dart';

class HomeWidget extends StatelessWidget {
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
            date: DateTime.now(),
            items: [
              Item(name: "Laptop", quantity: 2),
              Item(name: "Headphones", quantity: 5),
            ],
          ),
          SubsCard(
            price: 200,
            frequency: 2,
            status: SubStatus.ACTIVE,
            date: DateTime.now(),
            items: [
              Item(name: "Laptop", quantity: 2),
              Item(name: "Headphones", quantity: 5),
            ],
          ),
          SubsCard(
            price: 200,
            frequency: 2,
            status: SubStatus.PENDING,
            date: DateTime.now(),
            items: [
              Item(name: "Laptop", quantity: 2),
              Item(name: "Headphones", quantity: 5),
            ],
          ),
        ],
      ),
    );
  }
}
