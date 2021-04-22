import 'package:flutter/material.dart';

class EventInfo {
  final String id;
  final String name;
  final String description;
  final String location;
  final String link;
  final List<dynamic> attendeeEmails;
  bool shouldNotifyAttendees=true;
  final bool hasConfereningSupport;
  final int startTimeInEpoch;
  final int endTimeInEpoch;
  bool hasMarked=false;

  EventInfo({
    @required this.id,
    @required this.name,
    @required this.description,
    @required this.location,
    @required this.link,
    @required this.attendeeEmails,
    @required this.shouldNotifyAttendees,
    @required this.hasConfereningSupport,
    @required this.startTimeInEpoch,
    @required this.endTimeInEpoch,
    this.hasMarked
  });

  EventInfo.fromMap(Map snapshot)
      : id = snapshot['id'] ?? '',
        name = snapshot['name'] ?? '',
        description = snapshot['desc'],
        location = snapshot['hospital'],
        link = snapshot['link'],
        attendeeEmails = snapshot['emails'] ?? '',
        shouldNotifyAttendees = snapshot['should_notify'],
        hasConfereningSupport = snapshot['has_conferencing'],
        startTimeInEpoch = snapshot['start'],
        endTimeInEpoch = snapshot['end'],
        hasMarked = snapshot['hasMarked'];


  toJson() {
    return {
      'id': id,
      'name': name,
      'desc': description,
      'hospital': location,
      'link': link,
      'emails': attendeeEmails,
      'should_notify': shouldNotifyAttendees==false?true:true,
      'has_conferencing': hasConfereningSupport,
      'start': startTimeInEpoch,
      'end': endTimeInEpoch,
      'hasMarked': hasMarked==null? false : true
    };
  }
}