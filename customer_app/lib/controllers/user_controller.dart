import 'package:customer_app/dataModels/user_model.dart';
import 'package:get/get.dart';

class UserController extends GetxController {
  Rx<User> user = User(
    firstName: '',
    lastName: '',
    phone: '',
    wallet: 0,
    routeID: '',
    hubID: '',
  ).obs;
}
