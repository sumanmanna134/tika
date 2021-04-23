import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:tika/Utils/appconfig.dart';
import 'package:tika/screens/home/homescreen.dart';
import 'package:tika/widget/custom_scafold.dart';
import 'package:tika/widget/default_button.dart';

class VerificationCompleted extends StatelessWidget {
  final String message;

  const VerificationCompleted({Key key, this.message}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,

        children: [

          Image.asset(Images.verified, height: 120,width: 120,),
          SizedBox(height: 20,),
          Text(message, style: TextStyle(color: Colors.black , fontSize: 30),),
          SizedBox(height: 50,),
          DefaultButton(press: (){
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => MainScreen()));

          },text: "Done", backgroundColor: Colors.green.shade500,)

        ],
      )
    );
  }
}
