import 'package:get/get.dart';

import '../controllers/otplogin_controller.dart';

class OtploginBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OtploginController>(
      () => OtploginController(),
    );
  }
}
