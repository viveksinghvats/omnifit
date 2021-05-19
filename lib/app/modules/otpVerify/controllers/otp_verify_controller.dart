import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:omnifit/app/routes/app_pages.dart';

class OtpVerifyController extends GetxController {
  final count = 0.obs;
  final phone = Get.arguments.obs;
  RxString _verificationCode = "".obs;

  @override
  void onInit() {
    _verifyPhone();
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
  void increment() => count.value++;

  void _verifyPhone() async {
    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: '+91$phone',
        verificationCompleted: (PhoneAuthCredential credential) async {
          await FirebaseAuth.instance
              .signInWithCredential(credential)
              .then((value) async {
            if (value.user != null) {
              Get.toNamed(Routes.HOME);
            }
          });
        },
        verificationFailed: (FirebaseAuthException e) {
          print(e.message);
        },
        codeSent: (String verficationID, int resendToken) {
          _verificationCode = verficationID as RxString;
        },
        codeAutoRetrievalTimeout: (String verificationID) {
          _verificationCode = verificationID as RxString;
        },
        timeout: Duration(seconds: 300));
  }

  Future<bool> verifyOtp(dynamic otp) async {
    try {
      await FirebaseAuth.instance
          .signInWithCredential(PhoneAuthProvider.credential(
              verificationId: _verificationCode.toString(), smsCode: otp))
          .then((value) async {
        if (value.user != null) {
          return true;
        }
      });
      return false;
    } catch (e) {
      return false;
    }
  }
}
