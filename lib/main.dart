import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:googleapis_auth/auth.dart';
import 'package:googleapis_auth/auth_io.dart';
import 'package:provider/provider.dart';
import 'package:tika/provider/google_signin_provider.dart';
import 'package:tika/provider/phone_provider.dart';
import 'package:tika/provider/storageProvider.dart';
import 'package:tika/screens/auth/login.dart';
import 'package:tika/screens/home/homescreen.dart';
import 'package:tika/services/background_messaging_handler.dart';
import 'package:tika/services/firebase_service.dart';
import 'package:tika/services/geolocator_service.dart';
import 'package:tika/widget/custom_scafold.dart';
import 'package:tika/widget/homescreenWidget.dart';
import 'package:googleapis/calendar/v3.dart' as cal;
import 'package:url_launcher/url_launcher.dart';

import 'Utils/calendar_client.dart';
import 'cred.dart';
final googleSignIn =  GoogleSignInProvider();
final geolocator = GeolocatorService();
Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await StorageUtil.getInstance();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

  runApp(MyApp());
}



class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (context) => googleSignIn ,),
         ChangeNotifierProvider.value(value: GeolocatorService()) ,
        ChangeNotifierProvider.value(value: DatabaseManager()),
        ChangeNotifierProvider.value(value: AuthProvider()),

      ],
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Tika',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: MainScreen()
      ),
    );
  }
}
