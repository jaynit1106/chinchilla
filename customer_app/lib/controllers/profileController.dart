import 'package:get/get.dart';
import 'package:customer_app/controllers/user_controller.dart';

UserController _userController = Get.find();

class ProfileController extends GetxController {
  RxString firstName = _userController.user.value.firstName.obs;
  RxString lastName = _userController.user.value.lastName.obs;
  RxString email = _userController.user.value.email.obs;

  firstNameChange(String value) {
    firstName.value = value;
  }

  lastNameChange(String value) {
    lastName.value = value;
  }

  emailChange(String value) {
    email.value = value;
  }

  updateUserController() {
    _userController.user.value.firstName = firstName.value;
    _userController.user.value.lastName = lastName.value;
    _userController.user.value.email = email.value;
  }
}
