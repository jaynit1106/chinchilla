import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:customer_app/views/screens/splash_screen.dart';
import 'package:customer_app/views/widgets/snackbar.dart';

class SelectLocationController extends GetxController {
  List<DropdownMenuItem<String>> regionOptions = [
    DropdownMenuItem(value: "0", child: Text('Select')),
  ].obs;

  List<DropdownMenuItem<String>> locationOptions = [
    DropdownMenuItem(value: "0", child: Text('No location')),
  ].obs;

  Rx<String?> regionValue = "0".obs;

  Rx<String?> locationValue = "0".obs;

  void addRegion(String value, String text) {
    regionOptions.add(DropdownMenuItem(value: value, child: Text(text)));
  }

  void addLocation(List locations) {
    if (locations.length > 0) {
      locationOptions = [];
      locations.forEach(
        (location) {
          locationOptions.add(
            DropdownMenuItem(
                value: location['id'], child: Text(location['name'])),
          );
        },
      );
    } else {
      locationOptions = [];
      locationOptions.add(
        DropdownMenuItem(value: "0", child: Text('No location')),
      );
    }
  }

  void removeDemoRegion() {
    regionOptions.removeWhere((e) => e.value == "0");
    regionValue.value = regionOptions[0].value;
  }

  void removeDemoLocation() {
    locationValue.value = locationOptions[0].value;
  }

  void selectRegion(String? val) {
    regionValue.value = val;
  }

  void selectLocation(String? val) {
    locationValue.value = val;
  }

  void submitLocation() async {
    if (locationValue.value != "0" && locationValue.value != null) {
      SharedPreferences _prefs = await SharedPreferences.getInstance();
      await _prefs.setString('locationID', locationValue.value.toString());
      Get.offAll(() => SplashView());
    } else {
      launchSnack('Wrong Location', 'Please select your delivery location');
    }
  }
}
