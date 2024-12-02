import 'package:cnfaceattendance/utils/backgrounddecoration.dart';
import 'package:cnfaceattendance/view/holidayscreen/holidayscreencontroller.dart';
import 'package:cnfaceattendance/view/holidayscreen/widget/customtabbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HolidayScreen extends StatelessWidget {
  const HolidayScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(HolidayScreenController());
    return Container(
      decoration: backgroundDecoration(),
      child: const Scaffold(
        body:CustomTabBar()
      ),
    );
  }
}
