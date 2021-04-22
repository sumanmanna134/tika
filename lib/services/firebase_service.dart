
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


    final documentId = auth.currentUser.uid.toString();
    final collection = "user";
    final FirebaseFirestore _db = FirebaseFirestore.instance;
    final snapshot = await _db.collection('user').doc(documentId).get();
    String email = auth.currentUser.email;
    UserModel userModel = UserModel(name:name, email: email, age: null, phone: null , vaccinePhase: null , hasVerified: false ,gender: null );

    if(snapshot.exists){
     print("Exist");
    }else {
      _db.collection(collection).doc(auth.currentUser.uid).set(userModel.toJson());


    }




  }

  getData()async{

    final documentId = auth.currentUser.uid.toString();
    final collection = "user";
    final FirebaseFirestore _db = FirebaseFirestore.instance;
    final snapshot = await _db.collection('user').doc(documentId).get();
    vaccinaionPhase = snapshot.get('vaccinePhase');
    hasVerified = snapshot.get('hasVerified')==null? false: true;
    gender = snapshot.get('gender');
    age = snapshot.get("age");
    notifyListeners();

  }

  static updateVaccinationPhase({String age, String gender}) async{
    final documentId = auth.currentUser.uid.toString();
    final collection = "user";
    final FirebaseFirestore _db = FirebaseFirestore.instance;
    final snapshot = await _db.collection('user').doc(documentId).get();
    if(snapshot.get('vaccinePhase')==null){
      _db.collection(collection).doc(auth.currentUser.uid).update({
        "vaccinePhase": "0",
        "age":age,
        "gender":gender,
      });
    }else if(snapshot.get('vaccinePhase')=="0"){
      _db.collection(collection).doc(auth.currentUser.uid).update({
        "vaccinePhase": "1",

      });
    }else if(snapshot.get('vaccinePhase')=='1'){
      _db.collection(collection).doc(auth.currentUser.uid).update({
        "vaccinePhase": "2",

      });
    }



  }



  static Future<void> setFcmToken(String token)async{
    FirebaseAuth auth = FirebaseAuth.instance;
    final documentId = auth.currentUser.uid.toString();
    final field= 'fcm_token';
    final collection = "user";
    final FirebaseFirestore _db = FirebaseFirestore.instance;
    final snapshot = await _db.collection('user').doc(documentId).get();


    _db.collection(collection).doc(auth.currentUser.uid).update({
      field: token,
      'createdAt': FieldValue.serverTimestamp(), // optional

    });

  }





  static Future<void> removeFCM()async{
    FirebaseAuth auth = FirebaseAuth.instance;
    final documentId = auth.currentUser.uid.toString();
    final field= 'fcm_token';
    final collection = "user";
    final FirebaseFirestore _db = FirebaseFirestore.instance;
    final snapshot = await _db.collection('user').doc(documentId).get();

    if(snapshot.data().containsKey(field)){
      _db.collection(collection).doc(auth.currentUser.uid).update({'fcm_token': null});
    }else {
      print("not exist");
    }




  }



}