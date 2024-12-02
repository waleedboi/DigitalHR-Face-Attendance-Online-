import 'dart:async';

import 'package:cnfaceattendance/model/getusermodel.dart';
import 'package:cnfaceattendance/utils/appconstants.dart';
import 'package:cnfaceattendance/view/home_screen/widget/custombox.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:marquee/marquee.dart';
// import 'package:slide_digital_clock/slide_digital_clock.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../utils/customborderradius.dart';
import '../homescreen_controller.dart';

class HomeScreenWidget extends StatelessWidget {
  const HomeScreenWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final model = Get.put(HomeScreenController());
    return RefreshIndicator(
      onRefresh: () async {
        await model.getDashboardFromApi();
      },
      child: Padding(
        padding: const EdgeInsets.only(
          left: 20,
          right: 20,
          top: 18,
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const CustomDigitalClock(
                is24HourTimeFormat: false,
              ),

              // DigitalClock(
              //   is24HourTimeFormat: false,
              //   hourMinuteDigitTextStyle:
              //       const TextStyle(fontSize: 55, color: Colors.white),
              //   secondDigitTextStyle:
              //       const TextStyle(color: Colors.white, fontSize: 24),
              //   amPmDigitTextStyle:
              //       const TextStyle(color: Colors.grey, fontSize: 24),
              // ),
              Text(
                DateFormat('EEEE , MMMM d , yyyy').format(DateTime.now()),
                style: const TextStyle(color: Colors.white, fontSize: 15),
              ),
              const SizedBox(
                height: 10,
              ),
              GetBuilder<HomeScreenController>(
                id: 'name',
                builder: (obj) {
                  return HomeScreenController.to.name == null
                      ? const SizedBox()
                      : Text(
                          'Welcome ${HomeScreenController.to.name ?? ""}',
                          style: const TextStyle(
                              color: Colors.white, fontSize: 24),
                        );
                },
              ),
              const SizedBox(
                height: 10,
              ),

              GetBuilder<HomeScreenController>(
                  id: 'shift',
                  builder: (obj) {
                    return DropdownButtonHideUnderline(
                      child: DropdownButton2<ShiftsModel>(
                        isExpanded: true,
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.white,
                        ),
                        isDense: true,
                        customButton: Container(
                          height: 50,
                          width: 200,
                          decoration: const BoxDecoration(
                            color: Colors.blue,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  width: 130,
                                  child: Text(
                                    obj.selectshift == null
                                        ? "Select Shift"
                                        : obj.selectshift!.shiftName!,
                                    style: TextStyle(
                                      overflow: TextOverflow.ellipsis,
                                      fontSize: 14,
                                      color: obj.selectshift == null
                                          ? Colors.grey
                                          : Colors.white,
                                    ),
                                  ),
                                ),
                                const Icon(
                                  Icons.arrow_drop_down_circle,
                                  color: Colors.black,
                                ),
                              ],
                            ),
                          ),
                        ),
                        value: obj.selectshift,
                        items: obj.shift.map((ShiftsModel type) {
                          return DropdownMenuItem<ShiftsModel>(
                            value: type,
                            child: Text(
                              type.shiftName!,
                              style: const TextStyle(color: Colors.black),
                            ),
                          );
                        }).toList(),
                        onChanged: (ShiftsModel? newValue) {
                          obj.selectshift = newValue;
                          obj.update(['shift']);
                        },
                      ),
                    );
                  }),

              Obx(
                () => model.noticeString.isNotEmpty
                    ? Container(
                        height: 50,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 15),
                        decoration: BoxDecoration(
                          borderRadius: borderRadius(),
                          color: Colors.white12,
                        ),
                        child: Center(
                          child: Marquee(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            key: Key(model.noticeString.value),
                            text: model.noticeString.value,
                            style: const TextStyle(
                                color: Colors.white, fontSize: 16),
                            velocity: 20,
                            scrollAxis: Axis.horizontal,
                            accelerationDuration: const Duration(seconds: 0),
                            accelerationCurve: Curves.linear,
                            decelerationDuration:
                                const Duration(milliseconds: 0),
                            decelerationCurve: Curves.easeOut,
                          ),
                        ))
                    : Container(),
              ),
              const SizedBox(
                height: 30,
              ),

              Center(
                child: CustomBox(
                  image: checkInImage,
                  mainText: 'Check In',
                  subText: 'Check-in for your\nattendance',
                  color: Colors.blueAccent.withOpacity(.5),
                  onpressed: () {
                    model.onCheckInClicked();
                  },
                ),
              ),
              // Row(
              //   children: [
              //     CustomBox(
              //       image: checkInImage,
              //       mainText: 'Check In',
              //       subText: 'Check-in for your\nattendance',
              //       color: Colors.blueAccent.withOpacity(.5),
              //       onpressed: () {
              //         model.onCheckInClicked();
              //       },
              //     ),
              //     const SizedBox(
              //       width: 15,
              //     ),
              //     CustomBox(
              //         image: checkInImage,
              //         mainText: 'Check Out',
              //         subText: 'Check out for your\nattendance',
              //         color: Colors.lightBlueAccent.withOpacity(.4),
              //         onpressed: () {
              //           model.onCheckOutClicked();
              //         }),
              //   ],
              // ),
              // Row(
              //   children: [
              //     CustomBox(
              //         image: breakActive,
              //         mainText: 'Break In',
              //         subText: 'Break-in for your\nattendance',
              //         color: Colors.lightGreenAccent.withOpacity(.4),
              //         onpressed: () {
              //           model.onBreakInClicked();
              //         }),
              //     const SizedBox(
              //       width: 15,
              //     ),
              //     CustomBox(
              //         image: breakInactive,
              //         mainText: 'Break Out',
              //         subText: 'Break-out for your\nattendance',
              //         color: Colors.yellowAccent.withOpacity(.5),
              //         onpressed: () {
              //           model.onBreakOutClicked();
              //         }),
              //   ],
              // ),

              Obx(
                () => model.bannerImage.value == ""
                    ? const SizedBox.shrink()
                    : Padding(
                        padding: const EdgeInsets.only(top: 15, bottom: 100),
                        child: InkWell(
                          onTap: () {
                            launchUrl(
                              Uri.parse(model.bannerUrl.value),
                              mode: LaunchMode.platformDefault,
                            );
                          },
                          child: ClipRRect(
                            borderRadius: borderRadius(),
                            child: Image.network(
                              model.bannerImage.value,
                              errorBuilder: (context, error, stackTrace) {
                                return Container();
                              },
                              height: 200,
                              width: Get.size.width,
                              fit: BoxFit.cover,
                            ),
                          ),
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

class CustomDigitalClock extends StatefulWidget {
  final bool is24HourTimeFormat;

  const CustomDigitalClock({
    Key? key,
    this.is24HourTimeFormat = false,
  }) : super(key: key);

  @override
  _CustomDigitalClockState createState() => _CustomDigitalClockState();
}

class _CustomDigitalClockState extends State<CustomDigitalClock> {
  late Timer _timer;
  late DateTime _currentTime;

  @override
  void initState() {
    super.initState();
    _currentTime = DateTime.now();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _currentTime = DateTime.now();
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  String get formattedTime {
    final hours = widget.is24HourTimeFormat
        ? _currentTime.hour
        : (_currentTime.hour % 12 == 0 ? 12 : _currentTime.hour % 12);
    final minutes = _currentTime.minute.toString().padLeft(2, '0');
    final seconds = _currentTime.second.toString().padLeft(2, '0');
    final amPm = _currentTime.hour >= 12 ? 'PM' : 'AM';
    return widget.is24HourTimeFormat
        ? '$hours:$minutes:$seconds'
        : '$hours:$minutes:$seconds $amPm';
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          '${_currentTime.hour.toString().padLeft(2, '0')}:${_currentTime.minute.toString().padLeft(2, '0')}',
          style: const TextStyle(fontSize: 55, color: Colors.white),
        ),
        const SizedBox(width: 5),
        Text(
          ':${_currentTime.second.toString().padLeft(2, '0')}',
          style: const TextStyle(color: Colors.white, fontSize: 24),
        ),
        if (!widget.is24HourTimeFormat)
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Text(
              _currentTime.hour >= 12 ? 'PM' : 'AM',
              style: const TextStyle(color: Colors.grey, fontSize: 24),
            ),
          ),
      ],
    );
  }
}
