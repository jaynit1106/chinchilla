import 'package:customer_app/utils/dates.dart';
import 'package:get/get.dart';

class AddSubsController extends GetxController {
  RxInt selectedRadio = 1.obs;
  RxInt quantity = 1.obs;
  RxInt frequency = 1.obs;
  Rx<DateTime> startDate = leastPermittedDate.obs;
  Rx<DateTime> endDate = current.obs;
  RxString addressID = ''.obs;

  selectRadio(int value) {
    selectedRadio.value = value;
  }

  getCartItems(String id) {
    return [
      {"productID": id, "quantity": quantity.value}
    ];
  }

  int getFrequency() {
    if (selectedRadio.value == 1)
      return 1;
    else if (selectedRadio.value == 2) return 2;
    return frequency.value;
  }

  selectAddressID(String address) {
    addressID.value = address;
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
