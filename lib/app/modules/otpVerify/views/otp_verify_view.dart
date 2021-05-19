import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:omnifit/app/components/otpDesigns.dart';
import 'package:omnifit/app/routes/app_pages.dart';

import '../controllers/otp_verify_controller.dart';
import 'package:pinput/pin_put/pin_put.dart';

class OtpVerifyView extends GetView<OtpVerifyController> {
  final TextEditingController _pinPutController = TextEditingController();
  final FocusNode _pinPutFocusNode = FocusNode();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('OTP Verification'),
      ),
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.only(top: 40),
            child: Center(
              child: Text(
                'Verify +91-${controller.phone}',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 26),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(30.0),
            child: PinPut(
              fieldsCount: 6,
              textStyle: const TextStyle(fontSize: 25.0, color: Colors.white),
              eachFieldWidth: 40.0,
              eachFieldHeight: 55.0,
              focusNode: _pinPutFocusNode,
              controller: _pinPutController,
              submittedFieldDecoration: pinPutDecoration,
              selectedFieldDecoration: pinPutDecoration,
              followingFieldDecoration: pinPutDecoration,
              pinAnimationType: PinAnimationType.fade,
              onSubmit: (otp) async {
                if (await controller.verifyOtp(otp)) {
                  Get.toNamed(Routes.HOME);
                } else {
                  FocusScope.of(context).unfocus();
                  SnackBar(
                    content: Text('Invalid Otp'),
                  );
                }
              },
            ),
          )
        ],
      ),
    );
  }
}
