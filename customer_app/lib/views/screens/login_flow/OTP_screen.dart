import 'package:customer_app/views/screens/login_flow/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:customer_app/controllers/authController.dart';
import 'package:get/get.dart';

class OtpScreen extends StatelessWidget {
  final String phoneNumber;
  final String verID;
  OtpScreen(this.phoneNumber,this.verID);
  TextEditingController firstDigit = TextEditingController();
  TextEditingController secondDigit = TextEditingController();
  TextEditingController thirdDigit = TextEditingController();
  TextEditingController fourthDigit = TextEditingController();
  TextEditingController fifthDigit = TextEditingController();
  TextEditingController sixthDigit = TextEditingController();
  final AuthController _authController = Get.find();

  FocusNode firstFocusNode=FocusNode();
  FocusNode secondFocusNode=FocusNode();
  FocusNode thirdFocusNode=FocusNode();
  FocusNode fourthFocusNode=FocusNode();
  FocusNode fifthFocusNode=FocusNode();
  FocusNode sixthFocusNode=FocusNode();

  void nextField({required FocusNode focusNode}) {
    focusNode.requestFocus();
  }

  Widget _getTextField(TextEditingController val,FocusNode focusNode,FocusNode next){
    return new ConstrainedBox(
      constraints: BoxConstraints(
          maxHeight: Get.height*0.06,
          maxWidth: Get.width*0.1
      ),
      child: Container(
        child: TextFormField(
          focusNode: focusNode,
          onChanged:(value){
            if(val.text.length==1) {
              nextField(focusNode:next);
            }
          },
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
            Text("My OTP is",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: Get.height*0.065
              ),
            ),
            Row(
              children: <Widget>[
                Text(phoneNumber,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: Get.height*0.032,
                      color: Colors.grey
                  ),
                ),
                SizedBox(width: Get.width*0.04),
                ElevatedButton(
                  child: Text("CHANGE",
                    style: TextStyle(color: Colors.grey,fontWeight: FontWeight.bold),
                  ),
                  onPressed: (){
                    Get.to(()=>LoginScreen());
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
                    shape: MaterialStateProperty.all<OutlinedBorder>(RoundedRectangleBorder(borderRadius: BorderRadius.circular(Get.height*0.065)),),
                    side: MaterialStateProperty.all<BorderSide>(BorderSide(color: Colors.grey))
                  ),
                )
              ],
            ),

            SizedBox(height: Get.height*0.02,),
            Row(
              children:<Widget> [
                _getTextField(firstDigit,firstFocusNode,secondFocusNode),
                SizedBox(width: Get.width*0.03),
                _getTextField(secondDigit,secondFocusNode,thirdFocusNode),
                SizedBox(width: Get.width*0.03),
                _getTextField(thirdDigit,thirdFocusNode,fourthFocusNode),
                SizedBox(width: Get.width*0.03),
                _getTextField(fourthDigit,fourthFocusNode,fifthFocusNode),
                SizedBox(width: Get.width*0.03),
                _getTextField(fifthDigit,fifthFocusNode,sixthFocusNode),
                SizedBox(width: Get.width*0.03),
                _getTextField(sixthDigit,sixthFocusNode,firstFocusNode),

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