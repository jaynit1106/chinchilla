import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:customer_app/controllers/productController.dart';
import 'package:customer_app/dataModels/item_model.dart';
import 'package:customer_app/utils/enums/enums.dart';
import 'package:customer_app/views/widgets/subs_card.dart';

class HomeSubscription extends StatelessWidget {
  const HomeSubscription(
      {Key? key, required this.productController, required this.subscription})
      : super(key: key);

  final ProductController productController;
  final List subscription;

  @override
  Widget build(BuildContext context) {
    return Column(
        children: subscription.length > 0
            ? [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Text(
                    'Subscriptions (${subscription.length})',
                    style: Get.textTheme.headline1,
                  ),
                ),
                Container(
                  height: Get.height * 0.30,
                  child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: subscription.length,
                      itemBuilder: (context, index) {
                        return SubsCard(
                            price: productController
                                .calculateTotal(subscription[index]['items']),
                            status: parseSubsStatusEnum(
                                subscription[index]['status']),
                            nextDeliveryDate: subscription[index]
                                ['nextDeliveryDate'],
                            endDate: subscription[index]['endDate'],
                            items: subscription[index]['items']
                                .map(
                                  (item) => Item(
                                    id: item['productID'],
                                    photoURL: productController
                                        .getProductUrl(item['productID']),
                                    price: productController
                                        .getProductPrice(item['productID']),
                                    name: productController
                                        .getProductName(item['productID']),
                                    quantity: item['quantity'],
                                  ),
                                )
                                .toList(),
                            frequency: subscription[index]['frequency']);
                      }),
                ),
              ]
            : [Container()]);
  }
}
