import 'package:flutter/foundation.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthProvider with ChangeNotifier {
  final _firebaseAuth = FirebaseAuth.instance;
  String verificationId;

  Future<void> verifyPhone(String countryCode, String mobile) async {
    var mobileToSend = mobile;
    final PhoneCodeSent smsOTPSent = (String verId, [int forceCodeResend]) {
      this.verificationId = verId;
    };
    try {
      await _firebaseAuth.verifyPhoneNumber(
          phoneNumber: mobileToSend,
          codeAutoRetrievalTimeout: (String verId) {
            this.verificationId = verId;
          },
          codeSent: smsOTPSent,
          timeout: const Duration(
            seconds: 120,
          ),
          verificationCompleted: (AuthCredential phoneAuthCredential) {
            print(phoneAuthCredential);
          },
          verificationFailed: (FirebaseAuthException exceptio) {
            throw exceptio;
          });
    } catch (e) {
      throw e;
    }
  }

  Future<void> verifyOTP(String otp) async {
    try {
      final AuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: otp,
      );
      final UserCredential user =
      await _firebaseAuth.currentUser.linkWithCredential(credential);
      final User currentUser = _firebaseAuth.currentUser;
      print(user);

      if (currentUser.uid != "") {
        print(currentUser.uid);
      }
    } catch (e) {
      throw e;
    }
  }

  showError(error) {
    throw error.toString();
  }
}