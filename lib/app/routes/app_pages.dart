import 'package:get/get.dart';

import 'package:omnifit/app/modules/otplogin/bindings/otplogin_binding.dart';
import 'package:omnifit/app/modules/otplogin/views/otplogin_view.dart';
import 'package:omnifit/app/modules/register/bindings/register_binding.dart';
import 'package:omnifit/app/modules/register/views/register_view.dart';

part 'app_routes.dart';

class AppPages {
  static const INITIAL = Routes.OTPLOGIN;

  static final routes = [
    GetPage(
      name: _Paths.OTPLOGIN,
      page: () => OtpLoginView(),
      binding: OtploginBinding(),
    ),
    GetPage(
      name: _Paths.REGISTER,
      page: () => RegisterView(),
      binding: RegisterBinding(),
    ),
    GetPage(
        name: _Paths.OTPVERIFY,
        page: () => OtpLoginView(),
        binding: OtploginBinding())
  ];
}
