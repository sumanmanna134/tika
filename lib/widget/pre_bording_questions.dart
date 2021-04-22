import 'package:flutter/material.dart';
import 'package:tika/screens/form.dart';
import 'package:tika/widget/custom_scafold.dart';
class OnBoardingQuestion extends StatefulWidget {
  @override
  _OnBoardingQuestionState createState() => _OnBoardingQuestionState();
}

class _OnBoardingQuestionState extends State<OnBoardingQuestion> {
  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      body: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.deepPurple,
              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(40),
                  bottomRight: Radius.circular(40)),

            ),


            child: Container(
              padding: EdgeInsets.only(left: 20, right: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 50,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(Icons.close, color: Colors.white, size: 35,),
                      Text("Registration",style: TextStyle(fontSize: 24,color: Colors.white,fontWeight: FontWeight.bold),),
                      SizedBox()
                    ],


                  ),
                  SizedBox(height: 30,),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [




                    ],
                  ),

                ],
              ),

            ),
          ),
          UserForm(),

          SizedBox(height: 10,),
        ],
      ),
    );
  }
}
