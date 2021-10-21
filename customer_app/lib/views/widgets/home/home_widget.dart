import 'package:flutter/material.dart';
import 'package:customer_app/views/widgets/order_card.dart';
import 'package:customer_app/dataModels/item_model.dart';
import 'package:customer_app/utils/enums/enums.dart';

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
