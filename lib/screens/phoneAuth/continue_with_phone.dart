import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tika/Utils/appconfig.dart';
import 'package:tika/Utils/utils.dart';
import 'package:tika/provider/phone_provider.dart';

import 'package:tika/screens/phoneAuth/verify_phone.dart';

import 'numericpads.dart';

class ContinueWithPhone extends StatefulWidget {
  @override
  _ContinueWithPhoneState createState() => _ContinueWithPhoneState();
}

class _ContinueWithPhoneState extends State<ContinueWithPhone> {

  String phoneNumber = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(
          Icons.close,
          size: 30,
          color: Colors.black,
        ),
        title: Text(
          "Link with phone",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        textTheme: Theme.of(context).textTheme,
      ),
      body: SafeArea(
          child: Column(
            children: <Widget>[

              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Color(0xFFFFFFFF),
                        Color(0xFFF7F7F7),
                      ]
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[

                      SizedBox(
                        height: 130,
                        child: Image.asset(
                            Images.phone
                        ),
                      ),

                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 14, horizontal: 64),
                        child: Text(
                          "You'll receive a 4 digit code to verify next.",
                          style: TextStyle(
                            fontSize: 22,
                            color: Color(0xFF818181),
                          ),
                        ),
                      ),

                    ],
                  ),
                ),
              ),

              Container(
                height: MediaQuery.of(context).size.height * 0.13,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(
                    Radius.circular(25),
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Row(
                    children: <Widget>[

                      Container(
                        width: 230,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[

                            Text(
                              "(+91)",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey,
                              ),
                            ),

                            SizedBox(
                              height: 8,
                            ),



                            Text(
                              phoneNumber,
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),

                          ],
                        ),
                      ),

                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            if(phoneNumber.isEmpty || phoneNumber.length!=10){
                              Utils.showErrorToast("Enter Valid Phone Number", context);
                            }else{
                              Utils.showProgressToast("Processing", context);
                              verifyPhone(context);
                            }



                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: Color(0xFFFFDC3D),
                              borderRadius: BorderRadius.all(
                                Radius.circular(15),
                              ),
                            ),
                            child: Center(
                              child: Text(
                                "Continue",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),

                    ],
                  ),
                ),
              ),

              NumericPad(
                onNumberSelected: (value) {
                  setState(() {
                    if(value != -1){

                      if(phoneNumber.length!=10){
                        phoneNumber = phoneNumber + value.toString();
                      }


                    }
                    else{
                      if(phoneNumber.length!=0){
                        phoneNumber = phoneNumber.substring(0, phoneNumber.length - 1);
                      }
                    }
                  });
                },
              ),

            ],
          )
      ),
    );
  }


  verifyPhone(BuildContext context){
    try {
      Provider.of<AuthProvider>(context, listen: false)
          .verifyPhone(
          "+91",
          "+91" +
              phoneNumber.toString())
          .then((value) {

        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => VerifyPhone(phoneNumber: "+91"+phoneNumber)),
        );

      }).catchError((e) {
        String errorMsg =
            'Cant Authenticate you, Try Again Later';
        if (e.toString().contains(
            'We have blocked all requests from this device due to unusual activity. Try again later.')) {
          errorMsg =
          'Please wait as you have used limited number request';
        }
        Utils.showErrorToast(e, context);
      });
    } catch (e) {
      Utils.showErrorToast(e, context);
    }
  }
}