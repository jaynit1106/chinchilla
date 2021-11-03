import 'package:get/get.dart';
import 'package:customer_app/utils/dates.dart';

class EditSubsController extends GetxController {
  RxInt quantity = 1.obs;
  RxInt frequency = 1.obs;
  Rx<DateTime> startDate = leastPermittedDate.obs;
  Rx<DateTime> endDate = current.obs;

  removeEndDate() {
    endDate.value = current;
  }
}
