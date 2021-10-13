// To parse this JSON data, do
//
//     final editProfile = editProfileFromJson(jsonString);

import 'dart:convert';

EditProfile editProfileFromJson(String str) =>
    EditProfile.fromJson(json.decode(str));

String editProfileToJson(EditProfile data) => json.encode(data.toJson());

class EditProfile {
  EditProfile({
    this.success,
    this.data,
    this.message,
  });

  bool success;
  Data data;
  Message message;

  factory EditProfile.fromJson(Map<String, dynamic> json) => EditProfile(
        success: json["success"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
        message:
            json["message"] == null ? null : Message.fromJson(json["message"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "data": data == null ? null : data.toJson(),
        "message": message == null ? null : message.toJson(),
      };
}

class Data {
  Data({
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

  factory Data.fromJson(Map<String, dynamic> json) => Data(
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

class Message {
  Message({
    this.ok,
    this.code,
    this.codeName,
    this.keyPattern,
    this.keyValue,
    this.name,
  });

  int ok;
  int code;
  String codeName;
  KeyPattern keyPattern;
  KeyValue keyValue;
  String name;

  factory Message.fromJson(Map<String, dynamic> json) => Message(
        ok: json["ok"],
        code: json["code"],
        codeName: json["codeName"],
        keyPattern: KeyPattern.fromJson(json["keyPattern"]),
        keyValue: KeyValue.fromJson(json["keyValue"]),
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "ok": ok,
        "code": code,
        "codeName": codeName,
        "keyPattern": keyPattern.toJson(),
        "keyValue": keyValue.toJson(),
        "name": name,
      };
}

class KeyPattern {
  KeyPattern({
    this.email,
  });

  int email;

  factory KeyPattern.fromJson(Map<String, dynamic> json) => KeyPattern(
        email: json["email"],
      );

  Map<String, dynamic> toJson() => {
        "email": email,
      };
}

class KeyValue {
  KeyValue({
    this.email,
  });

  String email;

  factory KeyValue.fromJson(Map<String, dynamic> json) => KeyValue(
        email: json["email"],
      );

  Map<String, dynamic> toJson() => {
        "email": email,
      };
}
