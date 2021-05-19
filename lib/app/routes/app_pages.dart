import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:omnifit/app/modules/home/bindings/home_binding.dart';
import 'package:omnifit/app/modules/home/views/home_view.dart';
import 'package:omnifit/app/modules/otpLogin/bindings/otp_login_binding.dart';
import 'package:omnifit/app/modules/otpLogin/views/otp_login_view.dart';
import 'package:omnifit/app/modules/otpVerify/bindings/otp_verify_binding.dart';
import 'package:omnifit/app/modules/otpVerify/views/otp_verify_view.dart';

part 'app_routes.dart';

class AppPages {
  static const INITIAL = Routes.OTP_LOGIN;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
        name: _Paths.OTP_LOGIN,
        page: () => OtpLoginView(),
        binding: OtpLoginBinding(),
        transition: Transition.cupertino,
        curve: Curves.easeInOut),
    GetPage(
      name: _Paths.OTP_VERIFY,
      page: () => OtpVerifyView(),
      binding: OtpVerifyBinding(),
    ),
  ];
}
