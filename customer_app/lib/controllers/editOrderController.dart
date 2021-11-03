import 'package:get/get.dart';

class EditOrderController extends GetxController {
  Rx<DateTime> deliveryDate = DateTime.now().obs;
  RxList items = [].obs;
  increaseQuantity(String id) {
    final _item = items.firstWhere((element) => element["productID"] == id);
    final index = items.indexWhere((element) => element["productID"] == id);

    items[index] = {
      "productID": _item["productID"],
      "quantity": _item["quantity"] + 1,
    };
  }

  void decreaseQuantity(String id) {
    final _item = items.firstWhere((element) => element["productID"] == id);
    final index = items.indexWhere((element) => element["productID"] == id);
    if (_item["quantity"] > 1) {
      items[index] = {
        "productID": _item["productID"],
        "quantity": _item["quantity"] - 1,
      };
    }
  }

  setItem(List<dynamic> initialItems) {
    items.value = initialItems;
  }

  int getQuantity(String id) {
    final _item = items.firstWhere((element) => element["productID"] == id);
    return _item["quantity"];
  }

  setDeliveryDate(DateTime date) {
    deliveryDate.value = date;
  }
}
