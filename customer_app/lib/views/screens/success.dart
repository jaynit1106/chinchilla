import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class Success extends StatelessWidget {
  final bool isSuccess;
  final String message;
  const Success({Key? key, required this.isSuccess, required this.message})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            isSuccess
                ? FaIcon(
                    FontAwesomeIcons.check,
                    color: Colors.green,
                    size: Get.width * 0.4,
                  )
                : FaIcon(
                    FontAwesomeIcons.times,
                    color: Colors.red,
                    size: Get.width * 0.4,
                  ),
            SizedBox(height: 5.0),
            isSuccess
                ? Text(
                    'Success',
                    style: Get.textTheme.headline4,
                  )
                : Text(
                    'Something went wrong',
                    style: Get.textTheme.headline4,
                  ),
            SizedBox(height: 15.0),
            Text(
              message,
              style: Get.textTheme.headline6,
            ),
            SizedBox(height: 25.0),
            ElevatedButton(
                onPressed: () {
                  Get.back();
                  Get.back();
                },
                child: Text('BACK TO HOME'))
          ],
        ),
      ),
    );
  }
}
