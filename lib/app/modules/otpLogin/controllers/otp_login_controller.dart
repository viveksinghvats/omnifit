import 'package:get/get.dart';

class OtpLoginController extends GetxController {
  //TODO: Implement OtpLoginController

  final count = 0.obs;
  @override
  void onInit() {
    print("In Login Controller");
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
  void increment() => count.value++;
}
