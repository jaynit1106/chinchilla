import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:customer_app/controllers/bottom_nav_controller.dart';

BottomNavController _bottomNavController = Get.find();

BottomNavigationBar bottomNavigationBar = BottomNavigationBar(
  currentIndex: _bottomNavController.index.value,
  onTap: (int currentIndex) => _bottomNavController.handleTap(currentIndex),
  items: [
    BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
    BottomNavigationBarItem(icon: Icon(Icons.shopping_bag), label: 'Shop'),
    BottomNavigationBarItem(icon: Icon(Icons.subscriptions), label: 'Orders'),
  ],
);
