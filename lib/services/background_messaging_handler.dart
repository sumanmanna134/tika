import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:tika/provider/storageProvider.dart';
import 'package:tika/services/firebase_service.dart';

Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();


  print("Handling a background message: ${message.messageId}");
}

FirebaseMessaging messaging = FirebaseMessaging.instance;

FlutterLocalNotificationsPlugin notificationsPlugin;
void notificationPermission() async{
  NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );

  await messaging.subscribeToTopic('newUpdate').whenComplete(() => print("newUpdate topic subscribe"));

  print('User granted permission: ${settings.authorizationStatus}');
}

void initMessaging(){

  var androidInit = AndroidInitializationSettings('@mipmap/ic_launcher');
  var iosInit = IOSInitializationSettings();
  var initSettings = InitializationSettings(android: androidInit, iOS: iosInit);
  notificationsPlugin = FlutterLocalNotificationsPlugin();
  notificationsPlugin.initialize(initSettings );


  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    print('Got a message whilst in the foreground!');
    print('Message data: ${message.data}');
    if (message.notification != null) {
      showNotification(title: message.notification.title , body:message.notification.body);

      print('Message also contained a notification: ${message.notification}');
    }
  });
}

void showNotification({String title, String body})async{
  var androidDetails = AndroidNotificationDetails("channelId", "channelName", "channelDescription" , priority: Priority.high, importance: Importance.max);

  var iosDetails = IOSNotificationDetails();
  var generalNotificationDetails = NotificationDetails(android: androidDetails, iOS: iosDetails);
  await notificationsPlugin.show(0, title,body, generalNotificationDetails, payload: "payload");

}



 getToken() async{
  await messaging.getToken().then((token) => StorageUtil.putString("fcm_token",token));
  DatabaseManager.setFcmToken(StorageUtil.getString("fcm_token"));
}
