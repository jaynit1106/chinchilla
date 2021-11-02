import 'dart:convert';
import 'dart:math';
import 'package:crypto/crypto.dart';
import 'package:customer_app/views/widgets/snackbar.dart';
import 'package:flutter_payu_unofficial/flutter_payu_unofficial.dart';
import 'package:flutter_payu_unofficial/models/payment_result.dart';
import 'package:get/get.dart';
import 'package:flutter_payu_unofficial/models/payment_params_model.dart';
import 'package:customer_app/controllers/user_controller.dart';
import 'package:customer_app/services/remote_config.dart';

class PayumoneyController extends GetxController {
  final RemoteConfigService _remoteConfigService = Get.find();
  final UserController _userController = Get.find();
  RxString amount = '0'.obs;
  Future<String?> payuMoney() async {
    PaymentParams _paymentParam = PaymentParams(
      phone: _userController.user.value.phone,
      amount: amount.value,
      merchantID: 'Shree surbhi Jadkhor Godham',
      merchantKey: _remoteConfigService.payuMoneyMerchantKey,
      salt: _remoteConfigService.payuMoneySalt,
      email: _userController.user.value.email,
      firstName: _userController.user.value.firstName,
      productName: 'Milkton app wallet',
      transactionID: DateTime.now().toString() + Random().nextInt(9).toString(),
      fURL: "https://www.payumoney.com/mobileapp/payumoney/failure.php",
      sURL: "https://www.payumoney.com/mobileapp/payumoney/success.php",
      udf1: "udf1",
      udf2: "udf2",
      udf3: "udf3",
      udf4: "udf4",
      udf5: "udf5",
      udf6: "",
      udf7: "",
      udf8: "",
      udf9: "",
      udf10: "",
      hash: "",
      isDebug: false,
    );
    //Generating local hash
    var bytes = utf8.encode(
        "${_paymentParam.merchantKey}|${_paymentParam.transactionID}|${_paymentParam.amount}|${_paymentParam.productName}|${_paymentParam.firstName}|${_paymentParam.email}|udf1|udf2|udf3|udf4|udf5||||||${_paymentParam.salt}");
    String localHash = sha512.convert(bytes).toString();
    _paymentParam.hash = localHash;

    try {
      PayuPaymentResult _paymentResult =
          await FlutterPayuUnofficial.initiatePayment(
              paymentParams: _paymentParam, showCompletionScreen: true);

      //Checks for success and prints result

      if (_paymentResult != null) {
        return _paymentResult.status;
        //_paymentResult.status is String of course. Directly fetched from payU's Payment response. More statuses can be compared manually
      } else {
        launchSnack('Error', 'Something went wrong');
      }
    } catch (e) {
      print(e);
    }
  }
}
