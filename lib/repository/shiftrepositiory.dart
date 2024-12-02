import 'dart:developer';

import 'package:cnfaceattendance/data/remote/network_url/network_url.dart';
import 'package:cnfaceattendance/data/remote/response/shift_response.dart';
import 'package:cnfaceattendance/model/getusermodel.dart';
import 'package:cnfaceattendance/view/home_screen/homescreen_controller.dart';
import 'package:dio/dio.dart';

import '../data/local/preferences.dart';
import '../data/remote/dio_client/dio_client.dart';
import '../utils/exceptionhandler.dart';

class ShiftRepositiory {
  final DioClient dioClient = DioClient();
  final Preferences preferences = Preferences();

  Future<ShiftResponse?> getAllShift( ) async {
    HomeScreenController.to.name = await preferences.getName();
    HomeScreenController.to.update(['name']);
    final token = await preferences.getToken();

    try {
      var response = await dioClient
          .get(getallshifturl, {"Authorization": "Bearer $token"}, {});
      return ShiftResponse.fromJson(
        response.data,
      );
    } on DioException catch (e) {
      throw exceptionHandler(e);
    } catch (e) {
      rethrow;
    }
  }

  Future<UserModel?> getuser() async {
    final token = await preferences.getToken();
    final id = await preferences.getid();

    log("get user ---------------------------- ${id}");
    try {
      var response = await dioClient.get(
          '$baseurl/api/1.0v/$id/get-user-detail',
          {"Authorization": "Bearer $token"},
          {});
      log("reponse is ${response.data}");
      return UserModel.fromJson(response.data);
    } on DioException catch (e) {
      throw exceptionHandler(e);
    } catch (e) {
      rethrow;
    }
  }
}
