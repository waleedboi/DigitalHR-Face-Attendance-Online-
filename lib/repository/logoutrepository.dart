import 'package:cnfaceattendance/data/local/preferences.dart';
import 'package:cnfaceattendance/data/remote/dio_client/dio_client.dart';
import 'package:cnfaceattendance/data/remote/network_url/network_url.dart';
import 'package:cnfaceattendance/data/remote/response/generalresponse.dart';
import 'package:cnfaceattendance/utils/exceptionhandler.dart';
import 'package:dio/dio.dart';

class LogoutRepository {
  final dioClient = DioClient();
  final Preferences preferences = Preferences();

 void clearToken(){
    preferences.clearToken();
  }

  Future<String> getCompanyName() async {
    return await preferences.getCompanyName();
  }

  Future<String> getAddress() async {
    return await preferences.getAddress();
  }

  Future<String> getCompanyImage() async {
    return await preferences.getCompanyImage();
  }

 Future<GeneralResponse?> logOutApi() async {
    var token = await preferences.getToken();
    try {
      var response = await dioClient.post(
          logouturl, {}, {}, {"Authorization": "Bearer $token"});
      return GeneralResponse.fromJson(response.data);
    }
    on DioException catch (e) {
      throw exceptionHandler(e);
    }catch(e){
      rethrow;
    }
  }

}

