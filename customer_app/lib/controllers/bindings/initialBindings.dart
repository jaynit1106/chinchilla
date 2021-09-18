import 'package:get/get.dart';
import 'package:customer_app/controllers/authController.dart';
import 'package:customer_app/services/remote_config.dart';

class InitialBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => RemoteConfigService());
    Get.lazyPut(() => AuthController());
  }
}
