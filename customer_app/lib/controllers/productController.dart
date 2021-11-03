import 'package:customer_app/dataModels/product_model.dart';
import 'package:get/get.dart';

class ProductController extends GetxController {
  RxList products = [].obs;
  RxBool productsAdded = false.obs;

  void addProducts(List fetchedProduct) {
    fetchedProduct.forEach((product) => {
          products.add(
            Product(
                id: product['id'],
                name: product['name'],
                photoURL: product['photoURL'],
                price: product['price']),
          )
        });
  }

  String getProductName(String id) {
    Product _product = products.firstWhere((element) => element.id == id);
    return _product.name;
  }

  int getProductPrice(String id) {
    Product _product = products.firstWhere((element) => element.id == id);
    return _product.price;
  }

  String getProductUrl(String id) {
    Product _product = products.firstWhere((element) => element.id == id);
    return _product.photoURL;
  }

  int calculateTotal(List items) {
    int total = 0;
    items.forEach((item) {
      Product _product =
          products.firstWhere((element) => element.id == item['productID']);
      total = total + _product.price * int.parse(item['quantity'].toString());
    });
    return total;
  }
}
