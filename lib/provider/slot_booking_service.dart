import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tika/Model/booking_model.dart';
final FirebaseAuth auth = FirebaseAuth.instance;
final currentUserId = auth.currentUser.uid;
final CollectionReference mainCollection = FirebaseFirestore.instance.collection(currentUserId);
final documentId = "info";
final DocumentReference documentReference = mainCollection.doc(documentId);
final collectionAppointment = 'appointment';

class Storage {
  Future<void> storeEventData(EventInfo eventInfo) async {
    DocumentReference documentReferencer = documentReference.collection(collectionAppointment).doc(eventInfo.id);

    Map<String, dynamic> data = eventInfo.toJson();

    print('DATA:\n$data');

    await documentReferencer.set(data).whenComplete(() {
      print("Event added to the database, id: {${eventInfo.id}}");
    }).catchError((e) => print(e));
  }

  Future<void> updateEventData(EventInfo eventInfo) async {
    DocumentReference documentReferencer = documentReference.collection(collectionAppointment).doc(eventInfo.id);

    Map<String, dynamic> data = eventInfo.toJson();

    print('DATA:\n$data');

    await documentReferencer.update(data).whenComplete(() {
      print("Event updated in the database, id: {${eventInfo.id}}");
    }).catchError((e) => print(e));
  }

  Future<void> deleteEvent({@required String id}) async {
    DocumentReference documentReferencer = documentReference.collection(collectionAppointment).doc(id);

    await documentReferencer.delete().catchError((e) => print(e));

    print('Event deleted, id: $id');
  }

  Stream<QuerySnapshot> retrieveEvents() {
    Stream<QuerySnapshot> myClasses = documentReference.collection(collectionAppointment).orderBy('start').snapshots();

    return myClasses;
  }
}


