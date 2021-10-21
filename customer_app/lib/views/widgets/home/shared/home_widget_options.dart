import 'package:customer_app/views/widgets/home/home_widget.dart';
import 'package:customer_app/views/widgets/home/orders_widget.dart';
import 'package:customer_app/views/widgets/home/shop_widget.dart';
import 'package:flutter/material.dart';

List<Widget> homeWidgetOptions = [
  HomeWidget(),
  ShopView(),
  OrdersView(),
];
