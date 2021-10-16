import 'package:customer_app/dataModels/transaction_model.dart';
import 'package:customer_app/utils/dates.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:customer_app/services/graphql_services.dart';
import 'package:customer_app/graphQL/query.dart';
import 'package:customer_app/controllers/user_controller.dart';
import 'package:customer_app/views/widgets/snackbar.dart';
import 'package:customer_app/views/widgets/transaction_card.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class WalletScreen extends StatelessWidget {
  final GraphQLService _graphQLService = Get.find();
  final UserController _userController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Wallet'),
      ),
      body: GraphQLProvider(
        client: _graphQLService.client,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Column(
              children: [
                Container(
                  height: Get.height * 0.25,
                  width: double.infinity,
                  child: Card(
                    elevation: 5,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Wallet Balance',
                            style: Theme.of(context).textTheme.headline6,
                          ),
                          Text(
                            '₹ ${_userController.user.value.wallet}',
                            style: TextStyle(
                              fontSize: Get.height * 0.06,
                              fontWeight: FontWeight.w700,
                              color: Colors.green,
                            ),
                          ),
                          ElevatedButton(
                              onPressed: () {
                                launchSnack('Coming Soon',
                                    'Payment gateway coming soon');
                              },
                              child: Text('Add Money'))
                        ],
                      ),
                    ),
                  ),
                ),
                Query(
                  options: QueryOptions(
                      document: gql(last7Transactions),
                      variables: {
                        "customerID": _userController.user.value.id,
                        "startDate": before7DaysFormat,
                        "endDate": todayFormat,
                      }),
                  builder: (QueryResult result,
                      {VoidCallback? refetch, FetchMore? fetchMore}) {
                    if (result.hasException) {
                      return Text(result.exception.toString());
                    }
                    if (result.isLoading) {
                      return CircularProgressIndicator();
                    }
                    if (result.data!['transactionsByCustomerIDAndDate'].length >
                        0) {
                      return Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10.0),
                            child: Text(
                              'Last 7 Days',
                              style: Get.textTheme.headline1,
                            ),
                          ),
                          Container(
                            height: Get.height * 0.47,
                            child: ListView.builder(
                                itemCount: result
                                    .data!['transactionsByCustomerIDAndDate']
                                    .length,
                                itemBuilder: (context, index) {
                                  final Transaction _transaction = Transaction(
                                      isDebit: result.data!['transactionsByCustomerIDAndDate']
                                          [index]['isDebit'],
                                      subTotal: result.data!['transactionsByCustomerIDAndDate']
                                          [index]['subTotal'],
                                      date: DateTime.parse(
                                          result.data!['transactionsByCustomerIDAndDate']
                                              [index]['date']),
                                      comment: result.data!['transactionsByCustomerIDAndDate']
                                                  [index]['comment'] !=
                                              null
                                          ? result.data!['transactionsByCustomerIDAndDate']
                                              [index]['comment']
                                          : '');
                                  return TransactionCard(_transaction);
                                }),
                          ),
                        ],
                      );
                    }
                    return Container();
                  },
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: OutlinedButton(
                      onPressed: () {
                        launchSnack('Coming next',
                            'Monthly transaction views coming soon');
                      },
                      child: Text('Past transactions')),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
