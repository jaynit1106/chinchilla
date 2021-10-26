import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:customer_app/services/graphql_services.dart';
import 'package:customer_app/controllers/user_controller.dart';
import 'package:customer_app/dataModels/transaction_model.dart';
import 'package:customer_app/utils/dates.dart';
import 'package:customer_app/views/widgets/transaction_card.dart';
import 'package:customer_app/graphQL/query.dart';

class PastTransactions extends StatelessWidget {
  final GraphQLService _graphQLService = Get.find();
  final UserController _userController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Transactions'),
      ),
      body: GraphQLProvider(
        client: _graphQLService.client,
        child: Query(
          options: QueryOptions(document: gql(transactionByDate), variables: {
            "customerID": _userController.user.value.id,
            "startDate": before90DaysFormat,
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
            if (result.data!['transactionsByCustomerIDAndDate'].length > 0) {
              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: Text(
                      'Last 90 Days',
                      style: Get.textTheme.headline1,
                    ),
                  ),
                  Container(
                    height: Get.height * 0.82,
                    child: ListView.builder(
                        itemCount: result
                            .data!['transactionsByCustomerIDAndDate'].length,
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
            return Center(
              child: Text('No transaction found in last 90 days'),
            );
          },
        ),
      ),
    );
  }
}
