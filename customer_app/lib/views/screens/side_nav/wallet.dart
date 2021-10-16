import 'package:customer_app/views/widgets/transaction_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WalletScreen extends StatelessWidget {
  const WalletScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Wallet'),
      ),
      body: SingleChildScrollView(
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
                          '₹ 200',
                          style: TextStyle(
                            fontSize: Get.height * 0.06,
                            fontWeight: FontWeight.w700,
                            color: Colors.green,
                          ),
                        ),
                        ElevatedButton(
                            onPressed: () {}, child: Text('Add Money'))
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: Text(
                  'Last 7 Days',
                  style: Get.textTheme.headline1,
                ),
              ),
              TransactionCard(),
              TransactionCard(),
              TransactionCard(),
              TransactionCard(),
              TransactionCard(),
              TransactionCard(),
              TransactionCard(),
              TransactionCard(),
              TransactionCard(),
              TransactionCard(),
              TransactionCard(),
              TransactionCard(),
              TransactionCard(),
              TransactionCard(),
              TransactionCard(),
              TransactionCard(),
              TransactionCard(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: OutlinedButton(
                    onPressed: () {}, child: Text('Past transactions')),
              )
            ],
          ),
        ),
      ),
    );
  }
}
