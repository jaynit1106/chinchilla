import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: EdgeInsets.all(15),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/images/cicon.png',
            width: Get.width * 0.55,
          ),
          SizedBox(
            height: 25.0,
          ),
          TextFormField(
            autofocus: true,
            keyboardType: TextInputType.phone,
            decoration: InputDecoration(
              hintText: 'Your 10 digit mobile number?',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
          ),
          SizedBox(
            height: 15.0,
          ),
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () {},
                  child: Text('Login'),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 8.0,
          ),
          Text('Trouble login?')
        ],
      ),
    ));
  }
}
