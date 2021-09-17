import 'package:customer_app/utils/color.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:customer_app/views/widgets/snackbar.dart';

class AuthController extends GetxController {
  FirebaseAuth _auth = FirebaseAuth.instance;

  String verificationId = '';
  RxString smsCode = ''.obs;

  void login(String phone) async {
    final PhoneCodeAutoRetrievalTimeout codeAutoRetrievalTimeout =
        (String verId) {
      verificationId = verId;
    };

    final PhoneVerificationCompleted verificationCompleted =
        (PhoneAuthCredential credential) async {
      await _auth.signInWithCredential(credential);
    };

    final PhoneVerificationFailed verificationFailed =
        (FirebaseAuthException e) {
      launchSnack('Oops!!', e.toString());
    };

    final PhoneCodeSent codeSent =
        (String verificationId, int? resendToken) async {
      // Todo: Navigate to OTP Screen
      Get.defaultDialog(
        title: 'Please enter your otp',
        content: Column(children: [
          TextFormField(
            keyboardType: TextInputType.number,
            autofocus: true,
          ),
          SizedBox(
            height: 10.0,
          ),
          ElevatedButton(onPressed: () {}, child: Text('Verify')),
        ]),
      );
    };

    _auth.verifyPhoneNumber(
        phoneNumber: '+91' + phone,
        verificationCompleted: verificationCompleted,
        verificationFailed: verificationFailed,
        codeSent: codeSent,
        codeAutoRetrievalTimeout: codeAutoRetrievalTimeout);
  }

  void submitOtp() async {
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId, smsCode: smsCode.value);
    await _auth.signInWithCredential(credential);
  }
}
