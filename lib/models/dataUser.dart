// To parse this JSON data, do
//
//     final dataUser = dataUserFromJson(jsonString);

import 'dart:convert';

DataUser dataUserFromJson(String str) => DataUser.fromJson(json.decode(str));

String dataUserToJson(DataUser data) => json.encode(data.toJson());

class DataUser {
  DataUser({
    this.id,
    this.email,
    this.password,
    this.username,
    this.image,
    this.v,
  });

  String id;
  String email;
  String password;
  String username;
  String image;
  int v;

  factory DataUser.fromJson(Map<String, dynamic> json) => DataUser(
        id: json["_id"],
        email: json["email"],
        password: json["password"],
        username: json["username"],
        image: json["Image"],
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "email": email,
        "password": password,
        "username": username,
        "Image": image,
        "__v": v,
      };
}
