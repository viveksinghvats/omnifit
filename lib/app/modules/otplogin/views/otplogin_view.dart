import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:omnifit/app/modules/otpverify/views/otpverify_view.dart';
import 'package:omnifit/app/routes/app_pages.dart';

import '../controllers/otplogin_controller.dart';
import 'package:omnifit/components/designs.dart';

class OtpLoginView extends GetView<OtploginController> {
  TextEditingController _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(360, 690),
      builder: () => Scaffold(
        appBar: AppBar(
          title: Text('Phone Login'),
        ),
        drawer: drawerScreen(context),
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
                  margin: EdgeInsets.only(top: 60),
                  child: Center(
                    child: Text(
                      'Sign In',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 40, right: 10, left: 10),
                  child: TextField(
                    decoration: InputDecoration(
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
                margin: EdgeInsets.all(10),
                width: double.infinity,
                child: FlatButton(
                  color: Colors.green[400],
                  onPressed: () {
                    Get.to(OtpverifyView(),
                        arguments: _controller.text,
                        transition: Transition.cupertino,
                        duration: Duration(seconds: 1),
                        curve: Curves.bounceInOut);
                  },
                  child: Text(
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
