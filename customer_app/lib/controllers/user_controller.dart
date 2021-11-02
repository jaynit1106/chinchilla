import 'package:customer_app/dataModels/user_model.dart';
import 'package:get/get.dart';

class UserController extends GetxController {
  Rx<User> user = User(
    id: '',
    firstName: '',
    lastName: '',
    phone: '',
    routeID: '',
    hubID: '',
    email: 'app@shreesurbhi.com',
  ).obs;
}
