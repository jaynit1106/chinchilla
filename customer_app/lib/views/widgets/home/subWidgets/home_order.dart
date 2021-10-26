import 'package:customer_app/controllers/productController.dart';
import 'package:customer_app/dataModels/item_model.dart';
import 'package:customer_app/utils/enums/enums.dart';
import 'package:customer_app/views/widgets/order_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeOrder extends StatelessWidget {
  const HomeOrder({
    Key? key,
    required this.productController,
    required this.ordersForToday,
  }) : super(key: key);

  final ProductController productController;
  final List ordersForToday;

  @override
  Widget build(BuildContext context) {
    return Column(
        children: ordersForToday.length > 0
            ? [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Text(
                    'For Today (${ordersForToday.length})',
                    style: Get.textTheme.headline1,
                  ),
                ),
                Container(
                  height: Get.height * 0.2,
                  child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: ordersForToday.length,
                      itemBuilder: (context, index) {
                        return OrderCard(
                          price: productController
                              .calculateTotal(ordersForToday[index]['items']),
                          status: parseOrderStatusEnum(
                            ordersForToday[index]['status'],
                          ),
                          date: ordersForToday[index]['deliveryDate'],
                          items: ordersForToday[index]['items']
                              .map(
                                (item) => Item(
                                    name: productController
                                        .getProductName(item['productID']),
                                    quantity: item['quantity']),
                              )
                              .toList(),
                        );
                      }),
                ),
              ]
            : [Container()]);
  }
}
