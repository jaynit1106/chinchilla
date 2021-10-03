import 'package:get/get.dart';
import 'package:flutter/material.dart';

class SelectLocationController extends GetxController {
  List<DropdownMenuItem<String>> regionOptions = [
    DropdownMenuItem(value: "0", child: Text('Select')),
  ].obs;

  Rx<String?> regionValue = "0".obs;

  void addRegion(String value, String text) {
    regionOptions.add(DropdownMenuItem(value: value, child: Text(text)));
  }

  void removeDemoRegion() {
    regionOptions.removeWhere((e) => e.value == "0");
    regionValue.value = regionOptions[0].value;
  }

  void selectRegion(String? val) {
    regionValue.value = val;
  }
}
