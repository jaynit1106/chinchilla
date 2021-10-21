import 'package:customer_app/dataModels/item_model.dart';
import 'package:customer_app/utils/enums/enums.dart';
import 'package:customer_app/views/widgets/order_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrdersView extends StatelessWidget {
  const OrdersView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Text(
              'Past 30 days orders',
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
          OrderCard(
            price: 200,
            status: OrderStatus.DELIVERED,
            date: DateTime.now(),
            items: [
              Item(name: "Laptop", quantity: 2),
              Item(name: "Headphones", quantity: 5),
            ],
          ),
          OrderCard(
            price: 200,
            status: OrderStatus.ACTIVE,
            date: DateTime.now(),
            items: [
              Item(name: "Laptop", quantity: 2),
              Item(name: "Headphones", quantity: 5),
            ],
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
          OrderCard(
            price: 200,
            status: OrderStatus.DELIVERED,
            date: DateTime.now(),
            items: [
              Item(name: "Laptop", quantity: 2),
              Item(name: "Headphones", quantity: 5),
            ],
          ),
          OrderCard(
            price: 200,
            status: OrderStatus.ACTIVE,
            date: DateTime.now(),
            items: [
              Item(name: "Laptop", quantity: 2),
              Item(name: "Headphones", quantity: 5),
            ],
          ),
          OrderCard(
            price: 200,
            status: OrderStatus.DELIVERED,
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
