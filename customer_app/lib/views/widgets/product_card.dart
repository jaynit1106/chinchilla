import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:customer_app/views/widgets/add_subscription.dart';
import 'package:customer_app/dataModels/product_model.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  ProductCard({required this.product});
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: ListTile(
        title: Text(product.name),
        subtitle: Text(product.price.toString()),
        trailing: Column(
          children: [
            ElevatedButton(
                onPressed: () {
                  Get.to(() => SubscriptionPage(product: product));
                },
                child: Text('SUBSCRIBE')),
          ],
        ),
        leading: Image.network(
          product.photoURL,
        ),
      ),
    );
  }
}
