import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
                  Get.bottomSheet(
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Column(
                          children: [
                            Text(
                              'SUBSCRIBE',
                              style: Get.textTheme.headline1,
                            ),
                            ListTile(
                              leading: Image.network(
                                product.photoURL,
                              ),
                              title: Text(product.name),
                              subtitle: Text(
                                product.price.toString(),
                              ),
                              trailing: Container(
                                width: Get.width * 0.3,
                                child: Row(
                                  children: [
                                    IconButton(
                                      onPressed: () {},
                                      icon: Icon(Icons.remove),
                                    ),
                                    Text('2'),
                                    IconButton(
                                      onPressed: () {},
                                      icon: Icon(Icons.add),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      backgroundColor: Get.theme.backgroundColor);
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
