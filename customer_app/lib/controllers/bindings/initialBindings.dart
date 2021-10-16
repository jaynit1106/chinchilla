import 'package:get/get.dart';
import 'package:customer_app/controllers/bottom_nav_controller.dart';
import 'package:customer_app/controllers/select_location_controller.dart';
import 'package:customer_app/services/graphql_services.dart';
import 'package:customer_app/services/remote_config.dart';
import 'package:customer_app/controllers/authController.dart';

class InitialBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => RemoteConfigService(), fenix: true);
    Get.lazyPut(() => GraphQLService(), fenix: true);
    Get.lazyPut(() => AuthController(), fenix: true);
    Get.lazyPut(() => BottomNavController(), fenix: true);
    Get.lazyPut(() => SelectLocationController(), fenix: true);
  }
}
