

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tika/Model/booking_model.dart';
import 'package:tika/Model/notification_model.dart';
import 'package:tika/services/firebase_service.dart';
final FirebaseAuth auth = FirebaseAuth.instance;
final currentUserId = auth.currentUser.uid;
final CollectionReference mainCollection = FirebaseFirestore.instance.collection(currentUserId);
final documentId = "info";
final DocumentReference documentReference = mainCollection.doc(documentId);
final collectionAppointment = 'appointment';

final collectionNotification = "notification";
DatabaseManager databaseManager= DatabaseManager();
NotificationModel notificationModel = NotificationModel();

class Storage {
  Future<void> storeEventData(EventInfo eventInfo) async {

    DocumentReference documentReferencer = documentReference.collection(collectionAppointment).doc(eventInfo.id);

    Map<String, dynamic> data = eventInfo.toJson();

    print('DATA:\n$data');

    await documentReferencer.set(data).whenComplete(() {
      print("Event added to the database, id: {${eventInfo.id}}");
      notificationModel.title="New Appointment";
      notificationModel.desc ="${eventInfo.name} has been booked, Start at ${DateTime.fromMillisecondsSinceEpoch(eventInfo.startTimeInEpoch)}";
      storeNotification(notificationModel);

    }).catchError((e) => print(e));
  }


  Future<void> storeNotification(NotificationModel notification)async{
    DocumentReference documentReferencer = documentReference.collection(collectionNotification).doc(notification.notificationId);

    Map<String, dynamic> data = notification.toJson();

    print('DATA:\n$data');

    await documentReferencer.set(data).whenComplete(() {
      databaseManager.setNotifier();
      print("Event added to the database, id: {${notification.notificationId}}");

    }).catchError((e) => print(e));
  }



  Future<void> updateEventData(EventInfo eventInfo) async {
    DocumentReference documentReferencer = documentReference.collection(collectionAppointment).doc(eventInfo.id);

    print(documentReferencer.toString());

    Map<String, dynamic> data = eventInfo.toJson();

    print('DATA:\n$data');

    await documentReferencer.update(data).whenComplete(() {
      print("Event updated in the database, id: {${eventInfo.id}}");
      notificationModel.title="${eventInfo.name} updated";
      notificationModel.desc ="${eventInfo.name} has been changed, Start at ${DateTime.fromMillisecondsSinceEpoch(eventInfo.startTimeInEpoch)}";
      storeNotification(notificationModel);
    }).catchError((e) => print(e));
  }

  Future<void> deleteEvent({@required String id}) async {
    DocumentReference documentReferencer = documentReference.collection(collectionAppointment).doc(id);

    await documentReferencer.delete().catchError((e) => print(e));
    notificationModel.title="Your Event has been Canceled";
    notificationModel.desc ="${auth.currentUser.displayName} your event has been canceled :(";
    storeNotification(notificationModel);

    print('Event deleted, id: $id');
  }

  Stream<QuerySnapshot> retrieveEvents() {
    Stream<QuerySnapshot> myClasses = documentReference.collection(collectionAppointment).orderBy('start').snapshots();

    return myClasses;
  }

  Stream<QuerySnapshot> retrieveNotification() {
    Stream<QuerySnapshot> myNotification = documentReference.collection(collectionNotification).orderBy('createdAt').snapshots();

    return myNotification;
  }
}


