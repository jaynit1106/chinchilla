import 'package:customer_app/views/screens/select_location.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:customer_app/controllers/authController.dart';

final AuthController _authController = Get.find();

Widget sideDrawer = Drawer(
  elevation: 5,
  child: ListView(
    children: [
      DrawerHeader(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(100),
              child: Image.network(
                'https://avatars.githubusercontent.com/u/39991296?v=4',
                fit: BoxFit.contain,
              ),
            ),
          ),
          Text(
            _authController.getCurrentUserPhone(),
            style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
          ),
        ],
      )),
      ListTile(
        leading: Icon(Icons.wallet_giftcard),
        title: Text('Wallet'),
        onTap: () {
          Get.to(SelectLocation());
        },
      ),
      ListTile(
        leading: Icon(Icons.logout),
        title: Text('Log Out'),
        onTap: _authController.signOut,
      )
    ],
  ),
);
