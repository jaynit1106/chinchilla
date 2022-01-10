import 'package:customer_app/views/widgets/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:customer_app/controllers/authController.dart';

class LoginScreen extends StatelessWidget {
  final AuthController _authController = Get.find();
  final TextEditingController _phoneController = TextEditingController();
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
            inputFormatters: [new LengthLimitingTextInputFormatter(10)],
            controller: _phoneController,
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
                  onPressed: () async{
                    if(_phoneController.text.length==10){
                      _authController.login(_phoneController.text);
                    }else{
                      launchSnack("Error", "Invalid Phone Number");
                    }
                  },
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
