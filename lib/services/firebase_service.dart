
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:tika/Model/userModel.dart';

class DatabaseManager extends ChangeNotifier{
  static FirebaseMessaging messaging = FirebaseMessaging.instance;
  String vaccinaionPhase;
  bool hasVerified = false;
  String gender;
  String age;

  static FirebaseAuth auth = FirebaseAuth.instance;


  static Future<void> createUser()async{

    String name = auth.currentUser.displayName;
    final documentId = "info";
    final collection = auth.currentUser.uid.toString();
    final FirebaseFirestore _db = FirebaseFirestore.instance;
    final snapshot = await _db.collection(collection).doc(documentId).get();
    String email = auth.currentUser.email;
    UserModel userModel = UserModel(name:name, email: email, age: null, phone: null , vaccinePhase: null , hasVerified: false ,gender: null );

    if(snapshot.exists){
     print("Exist");
    }else {
      _db.collection(collection).doc(documentId).set(userModel.toJson());


    }




  }

  getData()async{

    final collection = auth.currentUser.uid.toString();
    final documentId  = "info";
    final FirebaseFirestore _db = FirebaseFirestore.instance;
    final snapshot = await _db.collection(collection).doc(documentId).get();

    if(snapshot.data().containsKey('vaccinePhase')){
      vaccinaionPhase = snapshot.get('vaccinePhase');
      hasVerified = snapshot.get('hasVerified')==null? false: true;
      gender = snapshot.get('gender');
      age = snapshot.get("age");
      notifyListeners();
    }else {

      print("vaccinePhase not exist ");
    }



  }

  updateVaccinationPhase({String age, String gender}) async{
    final collection = auth.currentUser.uid.toString();
    final documentId  = "info";
    final FirebaseFirestore _db = FirebaseFirestore.instance;
    final snapshot = await _db.collection(collection).doc(documentId).get();
    if(snapshot.get('vaccinePhase')==null){
      _db.collection(collection).doc(documentId).update({
        "vaccinePhase": "0",
        "age":age,
        "gender":gender,
      });
      notifyListeners();
    }else if(snapshot.get('vaccinePhase')=="0"){
      _db.collection(collection).doc(documentId).update({
        "vaccinePhase": "1",

      });

      notifyListeners();
    }else if(snapshot.get('vaccinePhase')=='1'){
      _db.collection(collection).doc(documentId).update({
        "vaccinePhase": "2",

      });

      notifyListeners();
    }





  }



  static Future<void> setFcmToken(String token)async{
    FirebaseAuth auth = FirebaseAuth.instance;
    final collection = auth.currentUser.uid.toString();
    final documentId  = "info";

    final field= 'fcm_token';

    final FirebaseFirestore _db = FirebaseFirestore.instance;
    final snapshot = await _db.collection(collection).doc(documentId).get();


    _db.collection(collection).doc(documentId).update({
      field: token,
      'createdAt': FieldValue.serverTimestamp(), // optional

    });

  }





  // static Future<void> removeFCM()async{
  //   FirebaseAuth auth = FirebaseAuth.instance;
  //   final collection = auth.currentUser.uid.toString();
  //   final documentId  = "info";
  //   final field= 'fcm_token';
  //
  //   final FirebaseFirestore _db = FirebaseFirestore.instance;
  //   final snapshot = await _db.collection(collection).doc(documentId).get();
  //
  //   if(snapshot.data().containsKey(field)){
  //     _db.collection(collection).doc(documentId).update({'fcm_token': null});
  //   }else {
  //     print("not exist");
  //   }
  //
  //
  //
  //
  // }



}