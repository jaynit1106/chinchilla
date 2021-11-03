import 'package:customer_app/utils/dates.dart';
import 'package:get/get.dart';

class AddSubsController extends GetxController {
  RxInt selectedRadio = 1.obs;
  RxInt quantity = 1.obs;
  RxInt frequency = 1.obs;
  Rx<DateTime> startDate = leastPermittedDate.obs;
  Rx<DateTime> endDate = current.obs;
  RxString addressID = ''.obs;

  void selectRadio(int value) {
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

  void selectAddressID(String address) {
    addressID.value = address;
  }

  void selectStartDate(DateTime date) {
    if (date.difference(endDate.value).inHours > 0) {
      removeEndDate();
    }
    startDate.value = date;
  }

  void selectEndDate(DateTime date) {
    endDate.value = date;
  }

  void removeEndDate() {
    endDate.value = current;
  }

  void setFrequency(int value) {
    frequency.value = value;
  }

  void addQuantity() {
    quantity.value++;
  }

  void subtractQuantity() {
    if (quantity.value > 1) quantity.value--;
  }
}
