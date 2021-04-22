import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tika/provider/google_signin_provider.dart';
import 'package:tika/screens/auth/component/background.dart';
import 'package:tika/screens/auth/login.dart';
import 'package:tika/screens/home/homeWidget.dart';
import 'package:tika/screens/home/mainscreen.dart';
import 'package:tika/widget/custom_scafold.dart';
import 'package:tika/widget/homescreenWidget.dart';

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<GoogleSignInProvider>(context);
    return  MyScaffold(
      body: ChangeNotifierProvider(
        create: (context) => GoogleSignInProvider(),
        child: StreamBuilder<dynamic>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (provider.isSigningIn) {
              return buildLoading();
            } else if (snapshot.hasData) {
              return HomeWidget();
            } else {
              return SignUpWidget();
            }
          },
        ),
      ),
    );
  }

  Widget buildLoading() => Stack(
    fit: StackFit.expand,
    children: [
      CustomPaint(painter: BackgroundPainter()),
      Center(child: CircularProgressIndicator()),
    ],
  );
}