import 'package:get/get.dart';
import 'package:customer_app/utils/color.dart';

void launchSnack(String title, String message) {
  Get.snackbar(
    title,
    message,
    backgroundColor: kBlack,
    colorText: kBgColor,
  );
}
