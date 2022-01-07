import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:customer_app/controllers/authController.dart';
import 'package:get/get.dart';

class otpScreen extends StatelessWidget {
  final String phoneNumber;
  final String verID;
  otpScreen(this.phoneNumber,this.verID);
  TextEditingController firstDigit = TextEditingController();
  TextEditingController secondDigit = TextEditingController();
  TextEditingController thirdDigit = TextEditingController();
  TextEditingController fourthDigit = TextEditingController();
  TextEditingController fifthDigit = TextEditingController();
  TextEditingController sixthDigit = TextEditingController();
  final AuthController _authController = Get.find();
  Widget _getTextField(TextEditingController val){
    return new ConstrainedBox(
      constraints: BoxConstraints(
          maxHeight: Get.height*0.06,
          maxWidth: Get.width*0.1
      ),
      child: Container(
        child: TextFormField(
          autofocus: true,
          inputFormatters: [new LengthLimitingTextInputFormatter(1)],
          controller: val,
          textInputAction: TextInputAction.next,
          keyboardType: TextInputType.number,
          style: TextStyle(
            height: 1.3,
          ),
          decoration: InputDecoration(
            hintText: "1",
            isDense: true,
            contentPadding: EdgeInsets.only(
                bottom: 10, top: 8, left: 14, right: 10),

          ),
        ),
      ),
    );
  }

  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            'Shree Surbhi',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),

        ),
        body: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.only(left: Get.width*0.09,top: Get.height*0.18),
          children: <Widget>[
            Text("My Code is",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 35
              ),
            ),
            Row(
              children: <Widget>[
                Text(phoneNumber,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Colors.grey
                  ),
                ),
                SizedBox(width: Get.width*0.05),
                ElevatedButton(
                  child: Text("RESEND",
                    style: TextStyle(color: Colors.grey,fontWeight: FontWeight.bold),
                  ),
                  onPressed: (){},
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
                    shape: MaterialStateProperty.all<OutlinedBorder>(RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),),
                    side: MaterialStateProperty.all<BorderSide>(BorderSide(color: Colors.grey))
                  ),
                )
              ],
            ),

            SizedBox(height: Get.height*0.02,),
            Row(
              children:<Widget> [
                _getTextField(firstDigit),
                SizedBox(width: Get.width*0.03),
                _getTextField(secondDigit),
                SizedBox(width: Get.width*0.03),
                _getTextField(thirdDigit),
                SizedBox(width: Get.width*0.03),
                _getTextField(fourthDigit),
                SizedBox(width: Get.width*0.03),
                _getTextField(fifthDigit),
                SizedBox(width: Get.width*0.03),
                _getTextField(sixthDigit),

              ],
            ),
            SizedBox(height:Get.height*0.02),
            Row(
              children: <Widget>[
                ElevatedButton(
                  child: Text("Verify"),
                  onPressed: (){
                    String otp=firstDigit.text+secondDigit.text+thirdDigit.text+fourthDigit.text+fifthDigit.text+sixthDigit.text;
                    _authController.submitOtp(otp,verID);
                  },
                )
              ],
            )

          ],
        )
    );
  }
}