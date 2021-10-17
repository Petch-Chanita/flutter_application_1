// To parse this JSON data, do
//
//     final dataRoom = dataRoomFromJson(jsonString);

import 'dart:convert';

List<DataRoom> dataRoomFromJson(String str) =>
    List<DataRoom>.from(json.decode(str).map((x) => DataRoom.fromJson(x)));

String dataRoomToJson(List<DataRoom> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class DataRoom {
  DataRoom({
    this.id,
    this.roomNumber,
    this.status,
    this.temperature,
    this.motion,
    this.luminance,
    this.people,
    this.v,
    this.datetime,
  });

  String id;
  String roomNumber;
  String status;
  dynamic temperature;
  dynamic motion;
  dynamic luminance;
  dynamic people;
  int v;
  String datetime;

  factory DataRoom.fromJson(Map<String, dynamic> json) => DataRoom(
        id: json["_id"],
        roomNumber: json["Room_number"],
        status: json["status"],
        temperature: json["temperature"],
        motion: json["motion"],
        luminance: json["luminance"],
        people: json["people"],
        v: json["__v"],
        datetime: json["datetime"],
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
        "datetime": datetime,
      };
}
