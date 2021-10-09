import 'package:get/get.dart';
import 'package:flutter/material.dart';

class SelectLocationController extends GetxController {
  List<DropdownMenuItem<String>> regionOptions = [
    DropdownMenuItem(value: "0", child: Text('Select')),
  ].obs;

  DropdownMenuItem<String> defaultLocation =
      DropdownMenuItem(value: "0", child: Text('No location'));

  List<DropdownMenuItem<String>> locationOptions = [
    DropdownMenuItem(value: "0", child: Text('No location')),
  ].obs;

  Rx<String?> regionValue = "0".obs;

  Rx<String?> locationValue = "0".obs;

  void addRegion(String value, String text) {
    regionOptions.add(DropdownMenuItem(value: value, child: Text(text)));
  }

  void addLocation(List locations) {
    locationOptions = [];
    locations.length > 0
        ? locations.forEach((location) {
            locationOptions.add(
              DropdownMenuItem(
                  value: location['id'], child: Text(location['name'])),
            );
          })
        : locationOptions.add(defaultLocation);
  }

  void removeDemoRegion() {
    regionOptions.removeWhere((e) => e.value == "0");
    regionValue.value = regionOptions[0].value;
  }

  void removeDemoLocation() {
    locationOptions.removeWhere((e) => e.value == "0");
    locationValue.value = locationOptions[0].value;
  }

  void selectRegion(String? val) {
    regionValue.value = val;
  }

  void selectLocation(String? val) {
    locationValue.value = val;
  }
}
