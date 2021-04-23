

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:tika/services/firebase_service.dart';

class GoogleSignInProvider extends ChangeNotifier{
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final googleSignIn = GoogleSignIn();
  bool _isSigningIn;
  GoogleSignInProvider(){
    _isSigningIn = false;
    notifyListeners();
  }

  bool get isSigningIn => _isSigningIn;



  set isSigningIn(bool isSignIn){
    _isSigningIn  = isSignIn;
    notifyListeners();
  }

  Future login() async{
    isSigningIn = true;
   final user = await googleSignIn.signIn();
   if(user == null){
     isSigningIn = false;
     return;
   }else{
     final googleAuth = await user.authentication;
     final credentialAuth = GoogleAuthProvider.credential(
       accessToken:  googleAuth.accessToken,
       idToken:  googleAuth.idToken,
     );

     await FirebaseAuth.instance.signInWithCredential(credentialAuth);
     DatabaseManager.createUser();

     isSigningIn = false;

   }
  }

  Future<void> signOut() async {
    await firebaseAuth.signOut();
    await googleSignIn.disconnect();
  }




}