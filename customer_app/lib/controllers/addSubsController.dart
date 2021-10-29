import 'package:customer_app/utils/dates.dart';
import 'package:get/get.dart';

class AddSubsController extends GetxController {
  RxInt selectedRadio = 1.obs;
  RxInt quantity = 1.obs;
  RxInt frequency = 1.obs;
  Rx<DateTime> startDate = leastPermittedDate.obs;
  Rx<DateTime> endDate = current.obs;

  selectRadio(int value) {
    selectedRadio.value = value;
  }

  selectStartDate(DateTime date) {
    startDate.value = date;
  }

  selectEndDate(DateTime date) {
    endDate.value = date;
  }

  removeEndDate() {
    endDate.value = current;
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
