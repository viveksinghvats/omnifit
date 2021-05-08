import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

import 'controllers/home.controller.dart';

class HomeScreen extends GetView<HomeController> {
  
  var brightness = SchedulerBinding.instance.window.platformBrightness;
  @override
  Widget build(BuildContext context) {
    bool isDarkModeOn = (brightness == Brightness.dark);
    return Scaffold(
        body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: isDarkModeOn
          ? SystemUiOverlayStyle.dark.copyWith(
              statusBarColor: Theme.of(context).primaryColor,
            )
          : SystemUiOverlayStyle.light.copyWith(
              statusBarColor: Theme.of(context).primaryColor,
            ),
      child: SafeArea(
        child: ScreenUtilInit(
            designSize: Size(360, 690),
            builder: () => Container(
                  child: Column(
                    children: [commingSoonScreen(context)],
                  ),
                )),
      ),
    ));
  }
}

commingSoonScreen(BuildContext context) {
  if (context.isPhone) {}
  return Container(
    height: 690.h,
    width: 360.w,
    color: Colors.teal,
  );
}
