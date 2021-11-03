import 'package:get/get.dart';

class DataEntryController extends GetxController {
  RxString firstName = ''.obs;
  RxString lastName = ''.obs;
  RxString email = ''.obs;

  firstNameChange(String value) {
    firstName.value = value;
  }

  lastNameChange(String value) {
    lastName.value = value;
  }

  emailChange(String value) {
    email.value = value;
  }
}
