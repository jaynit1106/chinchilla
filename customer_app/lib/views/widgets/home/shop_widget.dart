import 'package:customer_app/views/widgets/product_card.dart';
import 'package:flutter/material.dart';

class ShopView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          ProductCard(),
          ProductCard(),
          ProductCard(),
          ProductCard(),
          ProductCard(),
          ProductCard(),
          ProductCard(),
          ProductCard(),
          ProductCard(),
          ProductCard(),
        ],
      ),
    );
  }
}
