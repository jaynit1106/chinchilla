import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:customer_app/dataModels/transaction_model.dart';
import 'package:intl/intl.dart';

class TransactionCard extends StatelessWidget {
  final Transaction transaction;
  TransactionCard(this.transaction);
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: ListTile(
        leading: FaIcon(FontAwesomeIcons.piggyBank),
        title: Text(DateFormat.yMMMMEEEEd().format(transaction.date)),
        subtitle: Text(transaction.comment),
        trailing:
            Text('${transaction.isDebit ? '-' : '+'} ${transaction.subTotal}'),
      ),
    );
  }
}
