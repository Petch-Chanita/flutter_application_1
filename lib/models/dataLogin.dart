// To parse this JSON data, do
//
//     final dataLogin = dataLoginFromJson(jsonString);

import 'dart:convert';

DataLogin dataLoginFromJson(String str) => DataLogin.fromJson(json.decode(str));

String dataLoginToJson(DataLogin data) => json.encode(data.toJson());

class DataLogin {
  DataLogin({
    this.id,
    this.data,
  });

  String id;
  String data;

  factory DataLogin.fromJson(Map<String, dynamic> json) => DataLogin(
        id: json["_id"],
        data: json["data"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "data": data,
      };
}
