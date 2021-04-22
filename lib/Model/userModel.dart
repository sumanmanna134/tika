// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'dart:convert';

UserModel userFromJson(String str) => UserModel.fromJson(json.decode(str));

String userToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  UserModel({
    this.name,
    this.email,
    this.phone,
    this.age,
    this.vaccinePhase,
    this.gender,
    this.hasVerified

  });

  String name;
  String email;
  String phone;
  String age;
  String gender;
  String vaccinePhase;
  bool hasVerified;

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    name: json["name"] == null ? null : json["name"],
    email: json["email"] == null ? null : json["email"],
    phone: json["phone"] == null ? null : json["phone"],
    age: json["age"] == null ? null : json["age"],
    vaccinePhase: json["vaccinePhase"] == null ? null : json["vaccinePhase"],
    gender: json["gender"] == null ? null : json["gender"],


  );

  Map<String, dynamic> toJson() => {
    "name": name == null ? null : name,
    "email": email == null ? null : email,
    "phone": phone == null ? null : phone,
    "age": age == null ? null : age,
    "vaccinePhase": vaccinePhase == null? null : vaccinePhase,
    "hasVerified" : hasVerified == null ? false : hasVerified,
    "gender" : gender == null ? null : gender,


  };
}
