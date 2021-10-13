// To parse this JSON data, do
//
//     final search = searchFromJson(jsonString);

import 'dart:convert';

List<Search> searchFromJson(String str) =>
    List<Search>.from(json.decode(str).map((x) => Search.fromJson(x)));

String searchToJson(List<Search> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Search {
  Search({
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
  String roomNumber;
  String status;
  dynamic temperature;
  dynamic motion;
  dynamic luminance;
  dynamic people;
  int v;

  factory Search.fromJson(Map<String, dynamic> json) => Search(
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
