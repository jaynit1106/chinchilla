import 'package:get/get.dart';

class AddressController extends GetxController {
  RxString name = ''.obs;

  handleAddressChange(String add) {
    name.value = add;
  }
}
