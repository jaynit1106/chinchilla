import 'package:get/get.dart';

class AddressController extends GetxController {
  RxString name = ''.obs;
  RxString edittedName = ''.obs;

  void setEdittedName(String value) {
    edittedName.value = value;
  }

  void handleAddressChange(String add) {
    name.value = add;
  }
}
