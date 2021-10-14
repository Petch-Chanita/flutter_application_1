// To parse this JSON data, do
//
//     final UserLogin = UserLoginFromJson(jsonString);

import 'dart:convert';

UserLogin UserLoginFromJson(String str) => UserLogin.fromJson(json.decode(str));

String UserLoginToJson(UserLogin data) => json.encode(data.toJson());

class UserLogin {
  UserLogin({
    this.success,
    this.id,
    this.data,
    this.status,
    this.error,
    this.username,
    this.password,
  });

  int success;
  String id;
  String data;
  String status;
  String error;
  String username;
  String password;

  factory UserLogin.fromJson(Map<String, dynamic> json) => UserLogin(
        success: json["success"],
        id: json["_id"] == null ? null : json["_id"],
        data: json["data"] == null ? null : json["data"],
        status: json["status"] == null ? null : json["status"],
        error: json["error"] == null ? null : json["error"],
        username: json["username"] == null ? null : json["username"],
        password: json["password"] == null ? null : json["password"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "_id": id == null ? null : id,
        "data": data == null ? null : data,
        "status": status == null ? null : status,
        "error": error == null ? null : error,
        "username": username == null ? null : username,
        "password": password == null ? null : password,
      };
}
