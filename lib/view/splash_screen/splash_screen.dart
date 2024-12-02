import 'package:cnfaceattendance/utils/backgrounddecoration.dart';
import 'package:cnfaceattendance/view/splash_screen/splash_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/isarcontroller.dart';
import '../../utils/appconstants.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(SplashController());
    Get.put(IsarController());
    return Container(
      decoration: backgroundDecoration(),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Center(
              child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                appIcon,
                height: 100,
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "AI Attendance System",
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold),
              ),
            ],
          )),
        ),
      ),
    );
  }
}
