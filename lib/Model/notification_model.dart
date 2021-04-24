// To parse this JSON data, do
//
//     final notificationModel = notificationModelFromJson(jsonString);

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

NotificationModel notificationModelFromJson(String str) => NotificationModel.fromJson(json.decode(str));

String notificationModelToJson(NotificationModel data) => json.encode(data.toJson());

class NotificationModel {
  NotificationModel({
    this.notificationId,
    this.title,
    this.desc,
    this.createdAt,
  });

  String notificationId;
  @required String title;
  @required String desc;
  Timestamp createdAt;
  var uuid = Uuid();

  factory NotificationModel.fromJson(Map<String, dynamic> json) => NotificationModel(
    notificationId: json["notification_id"] == null ? null : json["notification_id"],
    title: json["title"] == null ? null : json["title"],
    desc: json["desc"] == null ? null : json["desc"],
    createdAt: json["createdAt"] == null ? null : json["createdAt"],
  );

  Map<String, dynamic> toJson() => {
    "notification_id": notificationId == null ? uuid.v1() : notificationId,
    "title": title == null ? null : title,
    "desc": desc == null ? null : desc,
    "createdAt": createdAt == null ? FieldValue.serverTimestamp() : createdAt,
  };
}
