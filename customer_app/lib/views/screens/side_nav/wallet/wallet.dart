import 'package:customer_app/graphQL/mutation.dart';
import 'package:customer_app/views/screens/success.dart';
import 'package:customer_app/views/widgets/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_payu_unofficial/models/payment_status.dart';
import 'package:get/get.dart';
import 'package:customer_app/services/graphql_services.dart';
import 'package:customer_app/graphQL/query.dart';
import 'package:customer_app/controllers/payumoneyController.dart';
import 'package:customer_app/dataModels/transaction_model.dart';
import 'package:customer_app/utils/dates.dart';
import 'package:customer_app/views/screens/side_nav/wallet/past_transactions.dart';
import 'package:customer_app/controllers/user_controller.dart';
import 'package:customer_app/views/widgets/transaction_card.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class WalletScreen extends StatelessWidget {
  final GraphQLService _graphQLService = Get.find();
  final UserController _userController = Get.find();
  final PayumoneyController _payumoneyController = Get.find();
  final TextEditingController _walletController = TextEditingController();

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
                          Mutation(
                            options: MutationOptions(
                              document: gql(addTransaction),
                              update: (GraphQLDataProxy transactionCache,
                                      QueryResult? transactionResult) =>
                                  transactionCache,
                              onError: (transactionError) {
                                Get.to(() => Success(
                                      isSuccess: false,
                                      message: 'Something went wrong',
                                      popCount: 3,
                                    ));
                              },
                              onCompleted: (dynamic transactionData) {
                                print(transactionData);
                                Get.to(() => Success(
                                    isSuccess: true,
                                    popCount: 3,
                                    message:
                                        'Amount has been added successfully'));
                              },
                            ),
                            builder: (
                              RunMutation addTransaction,
                              QueryResult? transactionRes,
                            ) {
                              return ElevatedButton(
                                  onPressed: () {
                                    Get.bottomSheet(
                                      Column(
                                        children: [
                                          Text('Add money'),
                                          TextField(
                                            keyboardType: TextInputType.number,
                                            decoration: InputDecoration(
                                              hintText: '2000',
                                              labelText:
                                                  'Enter the recharge amount',
                                            ),
                                            inputFormatters: [
                                              FilteringTextInputFormatter
                                                  .digitsOnly
                                            ],
                                            controller: _walletController,
                                            onChanged: (value) {
                                              _payumoneyController
                                                  .amount.value = value;
                                            },
                                          ),
                                          ElevatedButton(
                                              onPressed: () {
                                                if (_payumoneyController
                                                            .amount.value ==
                                                        '' ||
                                                    _payumoneyController
                                                            .amount.value ==
                                                        '0') {
                                                  launchSnack('Error',
                                                      'Amount can\'t be null');
                                                } else {
                                                  Future<String?>
                                                      paymentStatus =
                                                      _payumoneyController
                                                          .payuMoney();
                                                  if (paymentStatus
                                                          .toString() ==
                                                      PayuPaymentStatus
                                                          .success) {
                                                    addTransaction({
                                                      "customerID":
                                                          _userController
                                                              .user.value.id,
                                                      "subTotal": int.parse(
                                                          _payumoneyController
                                                              .amount.value),
                                                      "date": today,
                                                      "isDebit": false,
                                                      "comment":
                                                          "Wallet money added through app",
                                                    });
                                                  } else if (paymentStatus
                                                          .toString() ==
                                                      PayuPaymentStatus
                                                          .failed) {
                                                    Get.to(() => Success(
                                                        isSuccess: false,
                                                        message: paymentStatus
                                                            .toString(),
                                                        popCount: 3));
                                                  } else if (paymentStatus
                                                          .toString() ==
                                                      PayuPaymentStatus
                                                          .cancelled) {
                                                    Get.to(() => Success(
                                                        isSuccess: false,
                                                        message: paymentStatus
                                                            .toString(),
                                                        popCount: 3));
                                                  } else {
                                                    launchSnack(
                                                        'Error',
                                                        paymentStatus
                                                            .toString());
                                                  }
                                                }
                                              },
                                              child: Text('Proceed to pay'))
                                        ],
                                      ),
                                      backgroundColor:
                                          Get.theme.backgroundColor,
                                    );
                                  },
                                  child: Text('Add Money'));
                            },
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                Query(
                  options: QueryOptions(
                      document: gql(transactionByDate),
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
                        Get.to(() => PastTransactions());
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
