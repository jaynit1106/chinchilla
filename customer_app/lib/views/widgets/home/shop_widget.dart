import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:customer_app/controllers/user_controller.dart';
import 'package:customer_app/dataModels/product_model.dart';
import 'package:customer_app/graphQL/query.dart';
import 'package:customer_app/views/widgets/product_card.dart';

class ShopView extends StatelessWidget {
  final UserController _userController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Query(
      options: QueryOptions(
          document: gql(products),
          variables: {'hubID': _userController.user.value.hubID}),
      builder: (QueryResult result,
          {VoidCallback? refetch, FetchMore? fetchMore}) {
        if (result.hasException) {
          return Text(result.exception.toString());
        }
        if (result.isLoading) {
          return CircularProgressIndicator();
        }
        if (result.data!['hub']['products'].length > 0) {
          return ListView.builder(
              itemCount: result.data!['hub']['products'].length,
              itemBuilder: (context, index) {
                final Product _product = Product(
                    id: result.data!['hub']['products'][index]['id'],
                    name: result.data!['hub']['products'][index]['name'],
                    photoURL: result.data!['hub']['products'][index]
                        ['photoURL'],
                    price: result.data!['hub']['products'][index]['price']);
                return ProductCard(product: _product);
              });
        }
        return Center(
          child: Text('No products available at your location'),
        );
      },
    );
  }
}
