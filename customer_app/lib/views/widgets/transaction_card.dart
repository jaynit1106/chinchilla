import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class TransactionCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: ListTile(
        leading: FaIcon(FontAwesomeIcons.piggyBank),
        title: Text('25-01-2021'),
        subtitle: Text('for order'),
        trailing: Text('+ 200'),
      ),
    );
  }
}
