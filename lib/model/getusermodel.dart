// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:isar/isar.dart';

// class GetUserModel{
//   int id;
//   String name;
//   String dob;
//   String email;
//   String mobile;
//   String address;
//   GetUserModel(this.id,this.name,this.dob,this.email,this.mobile,this.address);
// }

class UserModel {
  int? status;
  int? statusCode;
  String? message;
  Data? data;

  UserModel({this.status, this.statusCode, this.message, this.data});

  UserModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    statusCode = json['status_code'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['status_code'] = this.statusCode;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  int? id;
  String? name;
  String? dob;
  String? email;
  String? mobile;
  String? address;
  String? shiftId;
  int? departmentId;
  String? image;
  List<ShiftsModel>? shifts;

  Data(
      {this.id,
      this.name,
      this.dob,
      this.email,
      this.mobile,
      this.address,
      this.shiftId,
      this.departmentId,
      this.image,
      this.shifts});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    dob = json['dob'];
    email = json['email'];
    mobile = json['mobile'];
    address = json['address'];
    shiftId = json['shift_id'];
    departmentId = json['department_id'];
    image = json['image'];
    if (json['shifts'] != null) {
      shifts = <ShiftsModel>[];
      json['shifts'].forEach((v) {
        shifts!.add(new ShiftsModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['dob'] = this.dob;
    data['email'] = this.email;
    data['mobile'] = this.mobile;
    data['address'] = this.address;
    data['shift_id'] = this.shiftId;
    data['department_id'] = this.departmentId;
    data['image'] = this.image;
    if (this.shifts != null) {
      data['shifts'] = this.shifts!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
@collection
class ShiftsModel {
  Id id = Isar.autoIncrement;
  int? shiftId;
  String? shiftType;
  String? shiftName;
  ShiftsModel({
    this.shiftId,
    this.shiftType,
    this.shiftName,
  });

  ShiftsModel copyWith({
    int? shiftId,
    String? shiftType,
    String? shiftName,
  }) {
    return ShiftsModel(
      shiftId: shiftId ?? this.shiftId,
      shiftType: shiftType ?? this.shiftType,
      shiftName: shiftName ?? this.shiftName,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'shiftId': shiftId,
      'shiftType': shiftType,
      'shiftName': shiftName,
    };
  }

  factory ShiftsModel.fromMap(Map<String, dynamic> map) {
    return ShiftsModel(
      shiftId: map['shift_id'] != null ? map['shift_id'] as int : null,
      shiftType: map['shift_type'] != null ? map['shift_type'] as String : null,
      shiftName: map['shift_name'] != null ? map['shift_name'] as String : null,
    );
  }
  factory ShiftsModel.fromMaphome(Map<String, dynamic> map) {
    return ShiftsModel(
      shiftId: map['id'] != null ? map['id'] as int : null,
      shiftType: map['type'] != null ? map['type'] as String : null,
      shiftName: map['title'] != null ? map['title'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ShiftsModel.fromJson(String source) =>
      ShiftsModel.fromMaphome(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'ShiftsModel(shiftId: $shiftId, shiftType: $shiftType, shiftName: $shiftName)';

  @override
  bool operator ==(covariant ShiftsModel other) {
    if (identical(this, other)) return true;

    return other.shiftId == shiftId &&
        other.shiftType == shiftType &&
        other.shiftName == shiftName;
  }

  @override
  int get hashCode =>
      shiftId.hashCode ^ shiftType.hashCode ^ shiftName.hashCode;
}
