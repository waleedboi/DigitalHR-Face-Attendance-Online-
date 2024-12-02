import 'package:cnfaceattendance/model/departmentmodel.dart';
import 'package:cnfaceattendance/model/getusermodel.dart';
import 'package:cnfaceattendance/model/isarmodel/usermodel.dart';
import 'package:cnfaceattendance/repository/departmentrepository.dart';
import 'package:cnfaceattendance/repository/userrepositiory.dart';
import 'package:cnfaceattendance/utils/alertbox.dart';
import 'package:cnfaceattendance/view/home_screen/homescreen_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../repository/shiftrepositiory.dart';

class NewEmployeeRegisterController extends GetxController {
  final formkey = GlobalKey<FormState>();
  final repositiory = ShiftRepositiory();
  final userrepository = UserRepositiory();
  final departmentrepository = DepartmentRepository();
  List<ShiftsModel> getshift = <ShiftsModel>[];
  final getDepartment = <DepartmentModel>[].obs;

  // RxString selectedValue = ''.obs;
  RxList<int> selectedValue = RxList<int>();
  RxString selectedDepartmentValue = ''.obs;
  RxString image = ''.obs;
  final picker = ImagePicker();

  Future getImageFromCamera() async {
    var pickedFile = await picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      image.value = pickedFile.path.toString();
    }
  }

  void saveDetailCliked(
    String name,
    String dob,
    String email,
    String mobile,
    String address,
  ) {
    if (!formkey.currentState!.validate()) {
      return;
    }
    saveUserApi(
      name,
      dob,
      email,
      mobile,
      address,
    );
  }

  @override
  void onInit() {
    getshift = List.from(HomeScreenController.to.shift);
    getAllDepartment();
    super.onInit();
  }

  void saveUserApi(String name, String dob, String email, String mobile,
      String address) async {
    try {
      // int? shiftid = getshift
      //     .where((element) {
      //       return element.title == selectedValue.value;
      //     })
      //     .firstOrNull
      //     ?.id;
      if (selectedValue.isEmpty) {
        showAlert('shift is empty');
        return;
      }
      int? departmentId = getDepartment
          .where((element) {
            return element.departmentname == selectedDepartmentValue.value;
          })
          .firstOrNull
          ?.id;

      if (departmentId == null) {
        showAlert('Department is empty');
        return;
      }

      customLoader();
      var response = await userrepository.saveUser(
        image.value,
        name,
        dob,
        email,
        mobile,
        address,
        selectedValue,
        departmentId,
      );
      Get.back();
      userrepository.addUser(User(
          response!.data.userId,
          name,
          dob,
          email,
          mobile,
          getshift
              .where(
                (p0) => selectedValue.any(
                  (element) => element == p0.shiftId!,
                ),
              )
              .toList(),
          address,
          image.value,
          departmentId));
      Get.back();
    } catch (e) {
      showAlert(e.toString());
      Get.back();
    }
  }

  // Future<void> getAllShift() async {
  //   try {
  //     var response = await repositiory.getAllShift( );
  //     // final shift = <ShiftsModel>[];
  //     // shift.addAll(shift);
  //     // for (var data in response!.data) {
  //     //   shift.add(ShiftsModel(data.id, data.title));
  //     // }

  //     getshift = response!.data;

  //     log("get shift ${getshift.length}");
  //     // selectedValue.value = getshift.first.title;
  //   } catch (e) {
  //     showAlert(e.toString());
  //   }
  //   update(['shifts']);
  // }

  Future<void> getAllDepartment() async {
    try {
      var response = await departmentrepository.getAllDepartment();
      final department = <DepartmentModel>[];
      department.addAll(department);
      for (var data in response!.data) {
        department.add(DepartmentModel(data.id, data.title));
      }
      getDepartment.value = department;
      selectedDepartmentValue.value = getDepartment.first.departmentname;
    } catch (e) {
      showAlert(e.toString());
    }
  }
}
