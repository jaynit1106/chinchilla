import 'package:flutter/material.dart';
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
            ElevatedButton(onPressed: () {}, child: Text('SUBSCRIBE')),
          ],
        ),
        leading: Image.network(
          product.photoURL,
        ),
      ),
    );
  }
}
