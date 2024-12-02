// ignore_for_file: public_member_api_docs, sort_constructors_first
// To parse this JSON data, do
//
//     final userListResponse = userListResponseFromJson(jsonString);

import 'dart:convert';

import 'package:cnfaceattendance/model/getusermodel.dart';
import 'package:flutter/foundation.dart';

GetUserResponse userListResponseFromJson(String str) =>
    GetUserResponse.fromJson(json.decode(str));

class GetUserResponse {
  int status;
  int statusCode;
  String message;
  List<Datum> data;

  GetUserResponse({
    required this.status,
    required this.statusCode,
    required this.message,
    required this.data,
  });

  factory GetUserResponse.fromJson(Map<String, dynamic> json) =>
      GetUserResponse(
        status: json["status"],
        statusCode: json["status_code"],
        message: json["message"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromMap(x))),
      );
}

class Datum {
  int? id;
  String? name;
  String? dob;
  String? email;
  String? mobile;
  String? address;
  String? shiftId;
  String? image;
  String? shifttype;
  String? departmentId;
  List<ShiftsModel>? shifts;
  Datum({
    this.id,
    this.name,
    this.dob,
    this.email,
    this.mobile,
    this.address,
    this.shiftId,
    this.image,
    this.shifttype,
    this.departmentId,
    this.shifts,
  });

  Datum copyWith({
    int? id,
    String? name,
    String? dob,
    String? email,
    String? mobile,
    String? address,
    String? shiftId,
    String? image,
    String? shifttype,
    String? departmentId,
    List<ShiftsModel>? shifts,
  }) {
    return Datum(
      id: id ?? this.id,
      name: name ?? this.name,
      dob: dob ?? this.dob,
      email: email ?? this.email,
      mobile: mobile ?? this.mobile,
      address: address ?? this.address,
      shiftId: shiftId ?? this.shiftId,
      image: image ?? this.image,
      shifttype: shifttype ?? this.shifttype,
      departmentId: departmentId ?? this.departmentId,
      shifts: shifts ?? this.shifts,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'dob': dob,
      'email': email,
      'mobile': mobile,
      'address': address,
      'shiftId': shiftId,
      'image': image,
      'shifttype': shifttype,
      'departmentId': departmentId,
      'shifts': shifts!.map((x) => x.toMap()).toList(),
    };
  }

  factory Datum.fromMap(Map<String, dynamic> map) { 
    return Datum(
      id: map['id'] != null ? map['id'] as int : null,
      name: map['name'] != null ? map['name'] as String : null,
      dob: map['dob'] != null ? map['dob'] as String : null,
      email: map['email'] != null ? map['email'] as String : null,
      mobile: map['mobile'] != null ? map['mobile'] as String : null,
      address: map['address'] != null ? map['address'] as String : null,
      // shiftId: map['shiftId'] != null ? map['shiftId'] as String : null,
      image: map['image'] != null ? map['image'] as String : null,
      // shifttype: map['shifttype'] != null ? map['shifttype'] as String : null,
      departmentId:
          map['department_id']?.toString(),
      shifts: map['shifts'] != null
          ? List<ShiftsModel>.from(
              (map['shifts'] as List<dynamic>).map<ShiftsModel?>(
                (x) => ShiftsModel.fromMap(x as Map<String, dynamic>),
              ),
            )
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Datum.fromJson(String source) =>
      Datum.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Datum(id: $id, name: $name, dob: $dob, email: $email, mobile: $mobile, address: $address, shiftId: $shiftId, image: $image, shifttype: $shifttype, departmentId: $departmentId, shifts: $shifts)';
  }

  @override
  bool operator ==(covariant Datum other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        other.dob == dob &&
        other.email == email &&
        other.mobile == mobile &&
        other.address == address &&
        other.shiftId == shiftId &&
        other.image == image &&
        other.shifttype == shifttype &&
        other.departmentId == departmentId &&
        listEquals(other.shifts, shifts);
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        dob.hashCode ^
        email.hashCode ^
        mobile.hashCode ^
        address.hashCode ^
        shiftId.hashCode ^
        image.hashCode ^
        shifttype.hashCode ^
        departmentId.hashCode ^
        shifts.hashCode;
  }
}
