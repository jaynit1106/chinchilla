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
}
