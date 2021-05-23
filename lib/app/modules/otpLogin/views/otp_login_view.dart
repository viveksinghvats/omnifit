import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:omnifit/app/resources/constant.dart';
import 'package:omnifit/app/routes/app_pages.dart';

import '../../otpverify/views/otp_verify_view.dart';
import '../controllers/otp_login_controller.dart';

class OtpLoginView extends GetView<OtpLoginController> {
  final TextEditingController _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      builder: () => Scaffold(
        appBar: AppBar(
          title: const Text('Phone Login'),
        ),
        drawer: const Drawer(),
        body: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [Colors.teal[200], Colors.orange[200]],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter),
              backgroundBlendMode: BlendMode.darken),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(children: [
                Container(
                  margin: const EdgeInsets.only(top: 60),
                  child: const Center(
                    child: Text(
                      'Sign In',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 40, right: 10, left: 10),
                  child: TextField(
                    decoration: const InputDecoration(
                      hintText: 'Phone Number',
                      prefix: Padding(
                        padding: EdgeInsets.all(4),
                        child: Text('+91'),
                      ),
                    ),
                    maxLength: 10,
                    keyboardType: TextInputType.number,
                    controller: _controller,
                  ),
                )
              ]),
              Container(
                margin: const EdgeInsets.all(10),
                width: double.infinity,
                child: FlatButton(
                  color: Colors.green[400],
                  onPressed: () {
                    Get.toNamed(
                      Routes.OTP_VERIFY,
                      arguments: _controller.text,
                    );
                  },
                  child: const Text(
                    'Next',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
