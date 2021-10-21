import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:customer_app/dataModels/item_model.dart';
import 'package:customer_app/utils/enums/enums.dart';

class OrderCard extends StatelessWidget {
  final int price;
  final OrderStatus status;
  final DateTime date;
  final List<Item> items;
  const OrderCard({
    Key? key,
    required this.price,
    required this.status,
    required this.date,
    required this.items,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: ListTile(
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text('\$ $price'),
            Text(
              parseEnum(status.toString()),
            ),
          ],
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Items'),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: items
                  .map((item) => Text('${item.quantity} x ${item.name}'))
                  .toList(),
            ),
            Text('Order for:'),
            Text(DateFormat.yMMMMd('en_US').format(date).toString()),
          ],
        ),
      ),
    );
  }
}
