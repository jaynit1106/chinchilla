import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: ListTile(
        title: Text('Shree Surbhi A2 Milk'),
        subtitle: Text('₹ 120.00'),
        trailing: Column(
          children: [
            ElevatedButton(onPressed: () {}, child: Text('BUY')),
          ],
        ),
        leading: Image.network(
          'https://github.com/GEPTON-INFOTECH/GEPTON-INFOTECH/raw/main/branding/no_image.png',
        ),
      ),
    );
  }
}
