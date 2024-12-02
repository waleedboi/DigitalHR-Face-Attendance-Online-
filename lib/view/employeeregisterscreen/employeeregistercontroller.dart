import 'package:cnfaceattendance/model/isarmodel/usermodel.dart';
import 'package:cnfaceattendance/repository/delete_face_id_repository.dart';
import 'package:cnfaceattendance/repository/deleteuserrepository.dart';
import 'package:cnfaceattendance/repository/getuserrepository.dart';
import 'package:cnfaceattendance/utils/alertbox.dart';
import 'package:cnfaceattendance/view/employeeregisterscreen/editemployeescreen/editemployeescreen.dart';
import 'package:cnfaceattendance/view/scanscreen/scanscreen.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import 'newemployeescreen/newemployeeregisterscreen.dart';

class EmployeeRegisterController extends GetxController {
  final repositiory = GetUserRepositiory();
  final deleteUserrepository = DeleteUserRepository();
  final deleteFaceIDrepository = DeleteFaceIDRepository();
  RxString image = ''.obs;

  final picker = ImagePicker();
  final userlist = <User>[].obs;

  void goToEditEmployee(User userId) {
    Get.to(const EditEmployeeScreen(), arguments: {"userId": userId});
  }

  Future<int> getFaceIdCountUser(int userId) async {
    return await repositiory.getAllFaceIdByUserId(userId);
  }

  void goToNewEmployee() {
    Get.to(NewEmployeeRegisterScreen());
  }

  void scanFaceId(int id, String name) async {
    Get.to(const ScanScreen(), arguments: {"userId": id, "username": name});
  }

  @override
  void onInit() {
    getUserListFromApi();
    queryForAllUser();
    super.onInit();
  }

  void queryForAllUser() {
    final queryForAlluser = repositiory.queryForAlluser();
    Stream<List<User>> queryChanged =
        queryForAlluser.watch(fireImmediately: true);

    queryChanged.listen((users) {
      userlist.value = users;
    });
  }

  Future<void> getUserListFromApi() async {
    try {
      userlist.clear();
      userlist.addAll(await repositiory.getAlluser());

      // var response = await repositiory.getUserListFromApi();
      // userlist.addAll(response!.data.map((e) {
      //   User user = User(
      //     e.id!,
      //     e.name!,
      //     e.shifts!,
      //     e.dob!,
      //     e.email!,
      //     e.mobile!,
      //     e.address!,
      //     e.image!,
      //     int.parse(e.departmentId!),
      //   );
      //   user.id = e.id!;
      //   log("user id is ${user.id}");
      //   return user;
      // }));

      final users = <User>[];
      var response = await repositiory.getUserListFromApi();
      for (var data in response!.data) {
        final user =
            userlist.where((element) => element.userId == data.id).firstOrNull;
        if (user != null) {
          user.userId = data.id!;
          user.address = data.address!;
          user.name = data.name!;
          user.dob = data.dob!;
          user.email = data.email!;
          user.mobile = data.mobile!;
          user.image = data.image!;
          user.shifts = data.shifts!;
          // user.shiftId = int.parse(data.shiftId);
          // user.shifttype = data.shifttype;
          user.departmentId = int.parse(data.departmentId!);
          users.add(user);
        } else {
          final newuser = User(
              data.id!,
              data.name!,
            
              data.dob!,
              data.email!,
              data.mobile!,
                data.shifts!,
              data.address!,
              data.image!,
              // int.parse(data.shiftId),
              int.parse(data.departmentId!));
          users.add(
            newuser,
          );
        }
      }
      deleteUserrepository.deleteAlluser();
      repositiory.createAlluser(users);
    } catch (e) {
      showAlert(e.toString());
    }
  }

  Future<void> deleteUserFromApi(int userid) async {
    try {
      customLoader();
      await deleteUserrepository.deleteUserFromApi(userid);
      await deleteUserrepository.deleteUserFromDbbyId(userid);
      deleteFaceIDrepository.deleteFaceIdByID(userid);
      Get.back();
      showAlert('User Deleted');
    } catch (e) {
      Get.back();
      showAlert(e.toString());
    }
  }

  Future<void> deleteFaceIDFromApi(int userid) async {
    try {
      customLoader();
      await deleteFaceIDrepository.deleteUserFromApi(userid);
      deleteFaceIDrepository.deleteFaceIdByID(userid);
      Get.back();
      showAlert(' User FaceIds Deleted');
    } catch (e) {
      Get.back();
      showAlert(e.toString());
    }
  }
}
