import 'dart:developer';

import 'package:cnfaceattendance/model/getusermodel.dart';
import 'package:cnfaceattendance/model/isarmodel/usermodel.dart';
import 'package:cnfaceattendance/repository/updateuserrepository.dart';
import 'package:cnfaceattendance/view/home_screen/homescreen_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multi_dropdown/multi_dropdown.dart';

import '../../../model/departmentModel.dart';
import '../../../repository/departmentrepository.dart';
import '../../../repository/shiftrepositiory.dart';
import '../../../utils/alertbox.dart';

class EditEmployeeController extends GetxController {
  static EditEmployeeController get to => Get.find();
  final formkey1 = GlobalKey<FormState>();
  final repositiory = ShiftRepositiory();
  final updaterepository = UpdateUserRepositiory();
  final departmentrepository = DepartmentRepository();
  List<ShiftsModel> getshift = <ShiftsModel>[];
  final getDepartment = <DepartmentModel>[].obs;

  User? user;
  RxString cameraImage = ''.obs;
  RxString image = ''.obs;
  final picker = ImagePicker();
  RxList<int> selectedValue = RxList<int>();
  RxString selectedDepartmentValue = ''.obs;

  final nameController = TextEditingController();
  final dobController = TextEditingController();
  final emailController = TextEditingController();
  final mobileNoController = TextEditingController();
  final addressController = TextEditingController();

  Future getImageFromCamera() async {
    var pickedFile = await picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      cameraImage.value = pickedFile.path.toString();
    }
  }

  void saveEditCliked(
      String name, String dob, String email, String mobile, String address) {
    if (!formkey1.currentState!.validate()) {
      return;
    }
    updateUserApi(name, dob, email, mobile, address);
  }

  @override
  void onInit() async {
    user = await Get.arguments["userId"];

    getshift = List.from(HomeScreenController.to.shift);
    getAllDepartment().then(
      (value) {
        getUserByuserId();
      },
    );

    super.onInit();
  }

  void getUserByuserId() async {
    // user = await updaterepository.getUserFromuserId(userId);
    if (user == null) {
      return;
    }

    image.value = user!.image;
    nameController.text = user!.name;
    dobController.text = user!.dob;
    emailController.text = user!.email;
    mobileNoController.text = user!.mobile;
    addressController.text = user!.address;

    selectedDepartmentValue.value = getDepartment
        .where((element) => element.id == user!.departmentId)
        .first
        .departmentname;
    try {
      controller.addItems(getshift
          .map((item) => DropdownItem(label: item.shiftName!, value: item))
          .toList());
      controller.selectWhere(
        (item) => user!.shifts.any(
          (element) => element.shiftId == item.value.shiftId,
        ),
      );
      selectedValue.value = controller.selectedItems
          .map(
            (e) => e.value.shiftId!,
          )
          .toList();
      log("OnSelectionChange: ${selectedValue.length}");
    } catch (e) {
      log("ajsdhiash ${e} ${user!.shifts}");
    }
  }

  MultiSelectController<ShiftsModel> controller =
      MultiSelectController<ShiftsModel>();
  void updateUserApi(String name, String dob, String email, String mobile,
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
      await updaterepository.updateUser(cameraImage.value, name, dob, email,
          mobile, address, selectedValue, user!.id, departmentId);
      user!.shifts.clear();
      user!
        ..shifts.addAll(getshift
            .where(
              (element) => selectedValue.any(
                (e) => e == element.shiftId,
              ),
            )
            .toList())
        ..departmentId = departmentId
        ..address = address
        ..dob = dob
        ..email = email
        ..name = name
        ..mobile = mobile
        ..image = cameraImage.value;

      // updaterepository.createUser(user!);
      showAlert('Employee has been edited');

      Get.back(closeOverlays: true);
    } catch (e) {
      showAlert(e.toString());
      Get.back();
    }
  }

  // Future<void> getAllShift() async {
  //   try {
  //     var response = await repositiory.getAllShift();
  //     // final shift = <ShiftsModel>[];
  //     // shift.addAll(shift);
  //     // for (var data in response!.data) {
  //     //   shift.add(ShiftsModel(data.id, data.title));
  //     // }
  //     getshift = response!.data;
  //     // selectedValue.value =
  //     //     getshift.where((element) => element.shiftId == user!.shiftId).first.title;
  //   } catch (e) {
  //     showAlert(e.toString());
  //   }
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
    } catch (e) {
      showAlert(e.toString());
    }
  }
}
