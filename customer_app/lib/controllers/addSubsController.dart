import 'package:get/get.dart';

class AddSubsController extends GetxController {
  RxInt selectedRadio = 1.obs;
  RxInt quantity = 1.obs;
  RxInt frequency = 1.obs;

  selectRadio(int value) {
    selectedRadio.value = value;
  }

  setFrequency(int value) {
    frequency.value = value;
  }

  addQuantity() {
    quantity.value++;
  }

  subtractQuantity() {
    if (quantity.value > 1) quantity.value--;
  }
}
