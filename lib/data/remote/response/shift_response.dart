import 'dart:convert';

import 'package:cnfaceattendance/model/getusermodel.dart';

// ShiftResponse shiftResponseFromJson(String str) =>
//     ShiftResponse.fromJson(json.decode(str));

String shiftResponseToJson(ShiftResponse data) => json.encode(data.toJson());

class ShiftResponse {
  int status;
  int statusCode;
  String message;
  List<ShiftsModel> data;

  ShiftResponse({
    required this.status,
    required this.statusCode,
    required this.message,
    required this.data,
  });

  factory ShiftResponse.fromJson(
    Map<String, dynamic> json,
  ) {
    return ShiftResponse(
      status: json["status"],
      statusCode: json["status_code"],
      message: json["message"],
      data: List<ShiftsModel>.from(
          json["data"].map((x) => ShiftsModel.fromMaphome(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "status": status,
        "status_code": statusCode,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class ShiftResponseEmploye {
  int status;
  int statusCode;
  String message;
  List<ShiftsModel> data;

  ShiftResponseEmploye({
    required this.status,
    required this.statusCode,
    required this.message,
    required this.data,
  });

  factory ShiftResponseEmploye.fromJson(
    Map<String, dynamic> json,
  ) {
    return ShiftResponseEmploye(
      status: json["status"],
      statusCode: json["status_code"],
      message: json["message"],
      data: List<ShiftsModel>.from(
          json["data"].map((x) => ShiftsModel.fromMap(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "status": status,
        "status_code": statusCode,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}
