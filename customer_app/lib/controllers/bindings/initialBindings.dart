import 'package:customer_app/controllers/bottom_nav_controller.dart';
import 'package:customer_app/services/graphql_services.dart';
import 'package:get/get.dart';
import 'package:customer_app/services/remote_config.dart';
import 'package:customer_app/controllers/authController.dart';

class InitialBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => RemoteConfigService());
    Get.lazyPut(() => GraphQLService());
    Get.lazyPut(() => AuthController());
    Get.lazyPut(() => BottomNavController());
  }
}
