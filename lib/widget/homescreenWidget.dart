import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:tika/provider/google_signin_provider.dart';
import 'package:tika/screens/form.dart';
import 'package:tika/services/geolocator_service.dart';
import 'package:tika/widget/custom_scafold.dart';

class LoggedInWidget extends StatefulWidget {
  @override
  _LoggedInWidgetState createState() => _LoggedInWidgetState();
}

class _LoggedInWidgetState extends State<LoggedInWidget> {
  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;


    return MyScaffold(

      body: Container(
        alignment: Alignment.center,
        color: Colors.blueGrey.shade900,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            Text(
              'Logged In',
              style: TextStyle(color: Colors.white),
            ),
            SizedBox(height: 8),
            CircleAvatar(
              maxRadius: 25,
              backgroundImage: NetworkImage(user.photoURL),
            ),
            SizedBox(height: 8),
            Text(
              'Name: ' + user.displayName,
              style: TextStyle(color: Colors.white),
            ),
            SizedBox(height: 8),
            Text(
              'Email: ' + user.email,
              style: TextStyle(color: Colors.white),
            ),
            SizedBox(height: 8),
            // appBar(context),
            SizedBox(height: 8),
            ElevatedButton(
              onPressed: () {
                // final provider =
                // // Provider.of<GoogleSignInProvider>(context, listen: false);
                // // provider.signOut().then((value) => Get.to());
              },
              child: Text('Logout'),
            ),

            Container(
              child: FlatButton(
                onPressed: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => UserForm()),
                  );
                },
                child: Text("Add Record"),
              ),
            )
          ],
        ),
      ),
    );
  }
}

