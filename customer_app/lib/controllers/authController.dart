import 'package:customer_app/views/screens/login_flow/OTP_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:customer_app/views/widgets/snackbar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:customer_app/views/screens/root.dart';
import 'package:customer_app/views/screens/splash_screen.dart';

class AuthController extends GetxController {
  FirebaseAuth _auth = FirebaseAuth.instance;

  String verificationId = '';

  void login(String phone) async {
    final PhoneCodeAutoRetrievalTimeout codeAutoRetrievalTimeout =
        (String verId) {
      verificationId = verId;
    };

    final PhoneVerificationCompleted verificationCompleted =
        (PhoneAuthCredential credential) async {
      await _auth.signInWithCredential(credential);
      Get.offAll(() => RootCheck());
    };

    final PhoneVerificationFailed verificationFailed =
        (FirebaseAuthException e) {
      launchSnack('Oops!!', e.toString());
    };

    final PhoneCodeSent codeSent =
        (String verificationId, int? resendToken) async {
        Get.to(()=>OtpScreen(phone, verificationId));
    };


    _auth.verifyPhoneNumber(
        phoneNumber: '+91' + phone,
        verificationCompleted: verificationCompleted,
        verificationFailed: verificationFailed,
        codeSent: codeSent,
        codeAutoRetrievalTimeout: codeAutoRetrievalTimeout);

  }

  void submitOtp(String otp, String verID) async {
    try {
      PhoneAuthCredential credential =
          PhoneAuthProvider.credential(verificationId: verID, smsCode: otp);
      await _auth.signInWithCredential(credential);
      Get.offAll(() => RootCheck());
    } catch (e) {
      launchSnack('Error',"Invalid OTP");
    }
  }

  getCurrentUserPhone() {
    return _auth.currentUser != null
        ? _auth.currentUser?.phoneNumber?.substring(3)
        : 'No user found';
  }

  void signOut() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    await _prefs.clear();
    await _auth.signOut();
    Get.offAll(() => SplashView());
  }
}
