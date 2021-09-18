import 'package:customer_app/views/widgets/main_drawer.dart';
import 'package:customer_app/views/widgets/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:customer_app/views/widgets/product_card.dart';

class CustomerApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: sideDrawer,
      appBar: AppBar(
        title: Text(
          'Shree Surbhi',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
              onPressed: () {
                launchSnack('Notification',
                    'This feature will be coming soon. Please keep your app updated.');
              },
              icon: Icon(
                Icons.notifications,
              ))
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.only(right: 6),
              child: Image.asset(
                'assets/images/ss-cover.png',
              ),
            ),
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
            ProductCard(),
            ProductCard(),
            ProductCard(),
          ],
        ),
      ),
    );
  }
}
