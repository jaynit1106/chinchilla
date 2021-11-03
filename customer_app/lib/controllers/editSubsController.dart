import 'package:get/get.dart';
import 'package:customer_app/utils/dates.dart';

class EditSubsController extends GetxController {
  RxInt quantity = 1.obs;
  RxInt frequency = 1.obs;
  Rx<DateTime> nextDeliveryDate = leastPermittedDate.obs;
  Rx<DateTime> endDate = current.obs;

  removeEndDate() {
    endDate.value = current;
  }

  setDates(String nextDate, String? lastDate) {
    nextDeliveryDate.value = DateTime.parse(nextDate);
    endDate.value = DateTime.parse(lastDate!);
  }

  selectStartDate(DateTime date) {
    nextDeliveryDate.value = date;
  }
}
