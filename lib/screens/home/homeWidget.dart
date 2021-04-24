import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:tika/Model/prevention.dart';
import 'package:tika/Utils/appconfig.dart';
import 'package:tika/screens/form.dart';
import 'package:tika/screens/notification/notification_screen.dart';
import 'package:tika/screens/phoneAuth/continue_with_phone.dart';
import 'package:tika/screens/profile/profile.dart';
import 'package:tika/screens/schedule_book/dash_board.dart';
import 'package:tika/screens/schedule_book/schedule_widget.dart';
import 'package:tika/services/background_messaging_handler.dart';
import 'package:tika/services/firebase_service.dart';
import 'package:tika/widget/custom_scafold.dart';
import 'package:tika/widget/notification_icon_widget.dart';
import 'package:tika/widget/pre_bording_questions.dart';
import 'package:tika/widget/prevention_list.dart';
class HomeWidget extends StatefulWidget {

  @override
  _HomeWidgetState createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {

  @override
  void initState() {
    // TODO: implement initState
    notificationPermission();
    initMessaging();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    final vaccine = Provider.of<DatabaseManager>(context, listen: false);
    vaccine.getData();
    getToken();
    return SafeArea(
      child: MyScaffold(
        body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.deepPurple,
                  borderRadius: BorderRadius.only(bottomLeft: Radius.circular(40), bottomRight: Radius.circular(40)),

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
                          Icon(Icons.menu, color: Colors.white, size: 35,),

                          Consumer<DatabaseManager>(
                            builder: (context, notification, child){
                              return NamedIcon(iconData:Icons.notifications , onTap: (){
                                notification.setNotifier(seen: true);
                                Get.to(()=> NotificationScreen());

                              }, notificationCount: notification.notificationCount,) ;
                            },

                          )


                        ],


                      ),
                      SizedBox(height: 30,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Hi, ${user.displayName.split(" ")[0]}",style: TextStyle(fontSize: 24,color: Colors.white,fontWeight: FontWeight.bold),),
                          GestureDetector(
                            onTap:(){
                              Get.to(MyProfile());
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.green,
                                borderRadius: BorderRadius.circular(30),

                              ),
                              padding: EdgeInsets.only(left: 3, right: 3, top: 3, bottom: 3),
                              child:  CircleAvatar(
                                maxRadius: 25,
                                backgroundImage: NetworkImage(user.photoURL),
                              ),

                            ),
                          ),

                        ],
                      ),
                      SizedBox(height: 30,),
                      Text("Are you feeling sick?",style: TextStyle(fontSize: 24,color: Colors.white,fontWeight: FontWeight.bold),),
                      SizedBox(height: 20,),
                      Text("If you feel sick with any of covid 19 symptoms\nplease call or SMS us immediately for help.",style: TextStyle(fontSize: 16,height: 1.6,color: Colors.white),),
                      SizedBox(height: 30,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            height: 45,
                            child: FlatButton(
                              onPressed: (){

                              },

                              color: Colors.red,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                              child: Container(
                                padding: EdgeInsets.only(left: 20,right: 20),
                                child: Row(
                                  children: <Widget>[
                                    Icon(Icons.call,color: Colors.white,),
                                    SizedBox(width: 10,),
                                    Text("Call Now",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white,fontSize: 16),),
                                  ],
                                ),
                              ),
                            ),
                          ),

                          Consumer<DatabaseManager>(
                            builder: (context, state , child){
                              if(state.vaccinaionPhase!=null){
                                return Container(
                                  height: 45,
                                  child: FlatButton(
                                    onPressed: (){

                                      Get.to(()=> DashboardScreen());

                                    },

                                    color: Colors.blue,
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                                    child: Container(
                                      padding: EdgeInsets.only(left: 20,right: 20),
                                      child: Row(
                                        children: <Widget>[
                                          Icon(Icons.calendar_today,color: Colors.white,),
                                          SizedBox(width: 10,),
                                          Text("Vaccination",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white,fontSize: 16),),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              }
                              return SizedBox.shrink();

                            },
                          )



                        ],
                      ),
                      SizedBox(height: 30,),

                    ],
                  ),

                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 20),
                child: Text("Prevention",style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold),),
              ),
              SizedBox(height: 24,),
              Container(
                height: 120,
                child: ListView.builder(
                  itemCount: prevention.length,
                  shrinkWrap: true,
                  physics: BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  padding: EdgeInsets.only(left: 20),
                  itemBuilder: (context, index){
                    return Container(
                      padding: EdgeInsets.only(right: 60),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Image.asset(prevention[index].image,height: 50,width: 50,fit: BoxFit.cover,),
                          SizedBox(height: 10,),
                          Text(prevention[index].text,style: TextStyle(fontSize: 16,height: 1.5,fontWeight: FontWeight.w500),textAlign: TextAlign.center,),
                        ],
                      ),
                    );
                  },
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 20,right: 20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.indigo.withOpacity(0.3),
                ),
                padding: EdgeInsets.all(16),
                child: Row(
                  children: <Widget>[
                    Image.asset("images/patient.png",height: 80,width: 80,),
                    SizedBox(width: 24,),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text("Do your own test!",style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold,color: Colors.white),),
                          SizedBox(height: 10,),
                          Text("Follow the instructions to do your own test.",style: TextStyle(fontSize: 16,height: 1.5,color: Colors.white),),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10,),


              Consumer<DatabaseManager>(
                builder: (context, state, child){
                  return state.vaccinaionPhase==null?GestureDetector(
                    onTap: (){
                      user.phoneNumber!=null?
                      Get.to(()=> UserForm()) : Get.to(()=> ContinueWithPhone());
                    },
                    child: Container(
                      margin: EdgeInsets.only(left: 20,right: 20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.blueGrey.withOpacity(0.7),
                      ),
                      padding: EdgeInsets.all(16),
                      child: Row(
                        children: <Widget>[
                          Image.asset(Images.vaccine,height: 80,width: 80,),
                          SizedBox(width: 24,),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text("Vaccine Registration"
                                  ,style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold,color: Colors.white),),
                                SizedBox(height: 10,),
                                Text("COVID-19 Vaccination For Everyone Above 45",style: TextStyle(fontSize: 16,height: 1.5,color: Colors.white),),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ): SizedBox.shrink();
                },
              ),

              SizedBox(height: 30,)
            ],
          ),

        ),
      ),
    );
  }
}






