import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:omnifit/app/routes/app_pages.dart';

class OtpVerifyController extends GetxController {
  dynamic phone = Get.arguments;
  String _verificationCode;
  final box = GetStorage();
  @override
  void onInit() {
    super.onInit();
    _verifyPhone();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}

  void _verifyPhone() async {
    print("Calling Verify Phone For Phone No : $phone");
    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: '+91$phone',
        verificationCompleted: (PhoneAuthCredential credential) async {
          await FirebaseAuth.instance
              .signInWithCredential(credential)
              .then((value) async {
            if (value.user != null) {
              print("Calling Home From Verify Phone");
              Get.offAndToNamed(Routes.HOME);
            } else {
              Get.snackbar(
                  "Invalid Otp", "Entered Otp Don't Match Please Try Again",
                  snackPosition: SnackPosition.BOTTOM);
            }
          });
        },
        verificationFailed: (FirebaseAuthException e) {
          print(e.message);
        },
        codeSent: (String verficationID, int resendToken) {
          _verificationCode = verficationID;
        },
        codeAutoRetrievalTimeout: (String verificationID) {
          _verificationCode = verificationID;
        },
        timeout: Duration(seconds: 120));
  }

  Future<bool> verifyOtp(dynamic otp) async {
    print("verificationCode : $_verificationCode And Otp : $otp");
    try {
      await FirebaseAuth.instance
          .signInWithCredential(PhoneAuthProvider.credential(
              verificationId: _verificationCode, smsCode: otp))
          .then((value) async {
        print("User Value :$value");
        if (value.user != null) {
          box.write("fuid", value.user.uid);
          Get.offAndToNamed(Routes.SIGNUP);
          return true;
        } else
          return false;
      });
    } catch (e) {
      return false;
    }
  }
}
