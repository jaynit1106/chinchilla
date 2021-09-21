import 'package:get/get.dart';

class BottomNavController extends GetxController {
  var index = 0.obs;
  void handleTap(int currentIndex) => index.value = currentIndex;
}
