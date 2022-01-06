import 'package:customer_app/services/FCM.dart';
import 'package:customer_app/views/widgets/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:customer_app/controllers/bottom_nav_controller.dart';
import 'package:customer_app/views/widgets/home/shared/home_widget_options.dart';
import 'package:customer_app/views/widgets/home/shared/main_drawer.dart';
import 'package:customer_app/views/screens/home/notifications.dart';
import 'package:customer_app/views/widgets/home/shared/bottom_nav_bar.dart';

class CustomerApp extends StatelessWidget {
  final BottomNavController _bottomNavController = Get.find();
  String notificationTitle="Gepton";
  _showNotification(String msg){
    launchSnack(notificationTitle, msg);
  }
  _changeTitle(String msg){
    notificationTitle=msg;
  }

  Widget build(BuildContext context) {

    final firebaseMessaging=FCM();
    firebaseMessaging.setNotifications();
    firebaseMessaging.titleCtrl.stream.listen(_changeTitle);
    firebaseMessaging.bodyCtrl.stream.listen(_showNotification);

    return Scaffold(
      drawer: sideDrawer,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Shree Surbhi',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
              onPressed: () {
                Get.to(() => NotificationsPage());
              },
              icon: Icon(
                Icons.notifications,
              ))
        ],
      ),
      body: Obx(() =>
          (homeWidgetOptions.elementAt(_bottomNavController.index.value))),
      bottomNavigationBar: Obx(() => bottomNavigationBar),
    );
  }
}
