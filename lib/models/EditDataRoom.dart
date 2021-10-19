// To parse this JSON data, do
//
//     final editDataRoom = editDataRoomFromJson(jsonString);

import 'dart:convert';

EditDataRoom editDataRoomFromJson(String str) =>
    EditDataRoom.fromJson(json.decode(str));

String editDataRoomToJson(EditDataRoom data) => json.encode(data.toJson());

class EditDataRoom {
  EditDataRoom({
    this.success,
    this.data,
  });

  bool success;
  Data data;

  factory EditDataRoom.fromJson(Map<String, dynamic> json) => EditDataRoom(
        success: json["success"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "data": data.toJson(),
      };
}

class Data {
  Data({
    this.id,
    this.roomNumber,
    this.status,
    this.temperature,
    this.motion,
    this.luminance,
    this.people,
    this.v,
  });

  String id;
  dynamic roomNumber;
  String status;
  dynamic temperature;
  dynamic motion;
  dynamic luminance;
  dynamic people;
  int v;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["_id"],
        roomNumber: json["Room_number"],
        status: json["status"],
        temperature: json["temperature"],
        motion: json["motion"],
        luminance: json["luminance"],
        people: json["people"],
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "Room_number": roomNumber,
        "status": status,
        "temperature": temperature,
        "motion": motion,
        "luminance": luminance,
        "people": people,
        "__v": v,
      };
}
