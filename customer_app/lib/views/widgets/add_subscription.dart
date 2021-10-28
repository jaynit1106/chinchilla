import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:customer_app/dataModels/product_model.dart';

class SubscriptionPage extends StatelessWidget {
  final Product product;
  SubscriptionPage({required this.product});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Subscription'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              'Product',
              style: Get.textTheme.headline6,
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
            ),
            Text(
              'Delivery days',
              style: Get.textTheme.headline6,
            ),
            RadioListTile(
              groupValue: 0,
              value: 0,
              onChanged: (value) {
                print(value);
              },
              title: Text('One day'),
            ),
            RadioListTile(
              groupValue: 0,
              value: 0,
              onChanged: (value) {
                print(value);
              },
              title: Text('Alternate day'),
            ),
            RadioListTile(
              groupValue: 0,
              value: 0,
              onChanged: (value) {
                print(value);
              },
              title: Text('Everyday'),
            ),
            RadioListTile(
              groupValue: 0,
              value: 0,
              onChanged: (value) {
                print(value);
              },
              title: Text('On interval'),
            ),
            ListTile(
              leading: Icon(Icons.calendar_today),
              title: Text('Start from:'),
              subtitle: Text('Oct 31, 2021'),
              trailing: TextButton(onPressed: () {}, child: Text('SELECT')),
            ),
            ListTile(
              leading: Icon(Icons.calendar_today),
              title: Text('Ends'),
              subtitle: Text('NEVER'),
              trailing: TextButton(onPressed: () {}, child: Text('SELECT')),
            ),
            Text(
              'Order before 07:30 pm to get items delivered next day.',
              style: TextStyle(
                  color: Colors.blueGrey, fontStyle: FontStyle.italic),
            ),
            ElevatedButton(onPressed: () {}, child: Text('Confirm'))
          ],
        ),
      ),
    );
  }
}
