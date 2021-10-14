// To parse this JSON data, do
//
//     final userRegister = userRegisterFromJson(jsonString);

import 'dart:convert';

UserRegister userRegisterFromJson(String str) =>
    UserRegister.fromJson(json.decode(str));

String userRegisterToJson(UserRegister data) => json.encode(data.toJson());

class UserRegister {
  UserRegister({
    this.success,
    this.error,
    this.email,
    this.username,
    this.image,
    this.message,
  });
  int success;
  Error error;
  String email;
  String username;
  String image;
  String message;

  factory UserRegister.fromJson(Map<String, dynamic> json) => UserRegister(
        success: json["success"],
        error: json["error"] == null ? null : Error.fromJson(json["error"]),
        email: json["email"] == null ? null : json["email"],
        username: json["username"] == null ? null : json["username"],
        image: json["Image"] == null ? null : json["Image"],
        message: json["message"] == null ? null : json["message"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "error": error == null ? null : error.toJson(),
        "email": email == null ? null : email,
        "username": username == null ? null : username,
        "Image": image == null ? null : image,
        "message": message == null ? null : message,
      };
}

class Error {
  Error({
    this.driver,
    this.name,
    this.index,
    this.code,
    this.keyPattern,
    this.keyValue,
  });

  bool driver;
  String name;
  int index;
  int code;
  KeyPattern keyPattern;
  KeyValue keyValue;

  factory Error.fromJson(Map<String, dynamic> json) => Error(
        driver: json["driver"],
        name: json["name"],
        index: json["index"],
        code: json["code"],
        keyPattern: KeyPattern.fromJson(json["keyPattern"]),
        keyValue: KeyValue.fromJson(json["keyValue"]),
      );

  Map<String, dynamic> toJson() => {
        "driver": driver,
        "name": name,
        "index": index,
        "code": code,
        "keyPattern": keyPattern.toJson(),
        "keyValue": keyValue.toJson(),
      };
}

class KeyPattern {
  KeyPattern({
    this.email,
    this.username,
  });

  int email;
  int username;

  factory KeyPattern.fromJson(Map<String, dynamic> json) => KeyPattern(
        email: json["email"] == null ? null : json["email"],
        username: json["username"] == null ? null : json["username"],
      );

  Map<String, dynamic> toJson() => {
        "email": email == null ? null : email,
        "username": username == null ? null : username,
      };
}

class KeyValue {
  KeyValue({
    this.email,
    this.username,
  });

  String email;
  String username;

  factory KeyValue.fromJson(Map<String, dynamic> json) => KeyValue(
        email: json["email"] == null ? null : json["email"],
        username: json["username"] == null ? null : json["username"],
      );

  Map<String, dynamic> toJson() => {
        "email": email == null ? null : email,
        "username": username == null ? null : username,
      };
}
