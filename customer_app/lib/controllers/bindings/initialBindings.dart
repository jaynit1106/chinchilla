import 'package:get/get.dart';
import 'package:customer_app/controllers/productController.dart';
import 'package:customer_app/controllers/user_controller.dart';
import 'package:customer_app/controllers/bottom_nav_controller.dart';
import 'package:customer_app/controllers/select_location_controller.dart';
import 'package:customer_app/services/graphql_services.dart';
import 'package:customer_app/services/remote_config.dart';
import 'package:customer_app/controllers/authController.dart';
import 'package:customer_app/controllers/addSubsController.dart';
import 'package:customer_app/controllers/addressController.dart';
import 'package:customer_app/controllers/payumoneyController.dart';
import 'package:customer_app/controllers/dataEntryController.dart';
import 'package:customer_app/controllers/profileController.dart';
import 'package:customer_app/controllers/editOrderController.dart';
import 'package:customer_app/controllers/editSubsController.dart';

class InitialBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => RemoteConfigService(), fenix: true);
    Get.lazyPut(() => GraphQLService(), fenix: true);
    Get.lazyPut(() => AuthController(), fenix: true);
    Get.lazyPut(() => BottomNavController(), fenix: true);
    Get.lazyPut(() => SelectLocationController(), fenix: true);
    Get.lazyPut(() => UserController(), fenix: true);
    Get.lazyPut(() => ProductController(), fenix: true);
    Get.lazyPut(() => AddSubsController(), fenix: true);
    Get.lazyPut(() => AddressController(), fenix: true);
    Get.lazyPut(() => PayumoneyController(), fenix: true);
    Get.lazyPut(() => DataEntryController(), fenix: true);
    Get.lazyPut(() => ProfileController(), fenix: true);
    Get.lazyPut(() => EditOrderController(), fenix: true);
    Get.lazyPut(() => EditSubsController(), fenix: true);
  }
}
