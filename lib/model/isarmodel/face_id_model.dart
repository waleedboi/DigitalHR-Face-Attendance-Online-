import 'package:cnfaceattendance/model/getusermodel.dart';
import 'package:isar/isar.dart';

part 'face_id_model.g.dart'; 
@collection
class FaceIdModel {
  Id id = Isar.autoIncrement;
  int userId;
  String faceId;
  FaceIdModel(this.userId, this.faceId);
}

// @embedded
// class ShiftsModel {
 
//   int? shiftId;
//   String? shiftType;
//   String? shiftName;

//   ShiftsModel({
//     this.shiftId,
//     this.shiftType,
//     this.shiftName,
//   });
// }
