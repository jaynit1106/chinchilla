import 'package:customer_app/utils/color.dart';
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
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5.0),
      child: Card(
        elevation: 5,
        child: Column(
          children: [
            ListTile(
              trailing: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    '₹ $price',
                    style: TextStyle(
                      color: kBlack,
                      fontWeight: FontWeight.w600,
                      fontSize: 24.0,
                    ),
                  ),
                  Container(
                    color: status == OrderStatus.DELIVERED
                        ? Colors.green
                        : status == OrderStatus.UNDELIVERED
                            ? Colors.red
                            : status == OrderStatus.ACTIVE
                                ? Colors.blue
                                : Colors.amber,
                    padding: EdgeInsets.all(2.0),
                    child: Text(
                      parseEnum(status.toString()),
                      style: TextStyle(color: kBgColor),
                    ),
                  ),
                ],
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('ITEMS:'),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: items
                        .map((item) => Text(
                              '${item.quantity} x ${item.name}',
                              style: TextStyle(
                                color: kBlack,
                                fontWeight: FontWeight.w600,
                              ),
                            ))
                        .toList(),
                  ),
                  Divider(),
                  Text(
                    'DATED:',
                  ),
                  Text(
                    DateFormat.yMMMMd('en_US').format(date).toString(),
                    style: TextStyle(
                      color: kBlack,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            // Divider(),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //   children: [
            //     TextButton(
            //       onPressed: () {},
            //       child: Text('CANCEL'),
            //     ),
            //     Divider(),
            //     TextButton(
            //       onPressed: () {},
            //       child: Text('EDIT'),
            //     ),
            //   ],
            // ),
          ],
        ),
      ),
    );
  }
}
