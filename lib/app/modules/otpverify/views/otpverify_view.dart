import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/otpverify_controller.dart';

class OtpverifyView extends GetView<OtpverifyController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('OtpverifyView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'OtpverifyView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
