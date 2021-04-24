
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
  int notificationCount=0;

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
     if(!snapshot.data().containsKey('notification')){
       _db.collection(collection).doc(documentId).update({"notification":0});
     }
    }else {
      _db.collection(collection).doc(documentId).set(userModel.toJson());


    }




  }

  getData()async{

    final collection = auth.currentUser.uid.toString();
    final documentId  = "info";
    final FirebaseFirestore _db = FirebaseFirestore.instance;
    final snapshot = await _db.collection(collection).doc(documentId).get();

    if(snapshot.exists){
      vaccinaionPhase = snapshot.data().containsKey('vaccinePhase')?
      snapshot.get('vaccinePhase')==null?null:snapshot.get('vaccinePhase'): null;
      hasVerified = snapshot.data().containsKey('hasVerified')?snapshot.get('hasVerified')==null? false: true:false;
      gender = snapshot.data().containsKey('gender')?snapshot.get('gender'):null;
      age = snapshot.data().containsKey('age') ? snapshot.get("age"):null;

      // print(snapshot.get('notification'));
      if(!snapshot.data().containsKey('notification')){
        _db.collection(collection).doc(documentId).update({"notification":0});
        notificationCount = snapshot.data().containsKey('notification')?snapshot.get('notification')==0?0:snapshot.get('notification'):0;

      }else{
        notificationCount = snapshot.data().containsKey('notification')?snapshot.get('notification')==0?0:snapshot.get('notification'):0;


      }
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

  setNotifier({bool seen=false})async{
    FirebaseAuth auth = FirebaseAuth.instance;
    final collection = auth.currentUser.uid.toString();
    final documentId  = "info";

    final field= 'notification';

    final FirebaseFirestore _db = FirebaseFirestore.instance;
    final snapshot = await _db.collection(collection).doc(documentId).get();


    if(snapshot.data().containsKey(field)){
      if(seen==true){
        _db.collection(collection).doc(documentId).update({
          field: 0
        }).whenComplete(() {
          notificationCount = 0;
          notifyListeners();
        }).catchError((e) => print(e));
      }else{
        _db.collection(collection).doc(documentId).update({
          field: snapshot.get(field) + 1
        }).then((value) {
          notificationCount = snapshot.get(field);
          notifyListeners();
        }).catchError((e) => print(e));
      }
    }else{
      _db.collection(collection).doc(documentId).update({"notification":0});
    }

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