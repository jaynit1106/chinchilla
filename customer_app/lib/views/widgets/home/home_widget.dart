import 'package:flutter/material.dart';

class HomeWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.only(right: 6),
            child: Image.asset(
              'assets/images/ss-cover.png',
            ),
          ),
        ],
      ),
    );
  }
}
