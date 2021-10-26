import 'package:customer_app/controllers/productController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:customer_app/dataModels/product_model.dart';
import 'package:customer_app/views/widgets/product_card.dart';

class ShopView extends StatelessWidget {
  final ProductController _productController = Get.find();
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: _productController.products.length,
        itemBuilder: (context, index) {
          final Product _product = Product(
            id: _productController.products[index].id,
            name: _productController.products[index].name,
            photoURL: _productController.products[index].photoURL,
            price: _productController.products[index].price,
          );
          return ProductCard(product: _product);
        });
  }
}
