import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:omnifit/app/components/signupdesign.dart';

import '../controllers/signup_controller.dart';

class SignupView extends GetView<SignupController> {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      builder: () => SafeArea(
        child: Scaffold(
            body: Column(
          children: [
            Container(
                height: 690,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        colors: [Colors.teal[100], Colors.cyan[100]])),
                child: TextFormFieldDemo()),
          ],
        )),
      ),
    );
  }
}
