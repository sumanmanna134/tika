import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:tika/Utils/appconfig.dart';
import 'package:tika/provider/google_signin_provider.dart';
import 'package:tika/screens/form.dart';
import 'package:tika/screens/home/homescreen.dart';
import 'package:tika/screens/phoneAuth/continue_with_phone.dart';
import 'package:tika/services/firebase_service.dart';
import 'package:tika/services/geolocator_service.dart';
import 'package:tika/widget/custom_scafold.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tika/widget/verification_complete.dart';
class MyProfile extends StatefulWidget {
  @override
  _MyProfileState createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {



  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    return MyScaffold(
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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
                        Icon(Icons.menu, color: Colors.white, size: 35,),
                        GestureDetector(
                            onTap: () {
                              final provider =
                              Provider.of<GoogleSignInProvider>(
                                  context, listen: false);
                              provider.signOut().then((value) =>
                                  Get.offAll(MainScreen()));
                            },
                            child: Icon(Icons.logout, color: Colors.white,
                              size: 30,)),

                      ],


                    ),
                    SizedBox(height: 30,),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Text("Hi, ${user.displayName.split(" ")[0]}",style: TextStyle(fontSize: 24,color: Colors.white,fontWeight: FontWeight.bold),),
                        Row(
                          children: [

                            Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(50),

                              ),
                              padding: EdgeInsets.only(
                                  left: 3, right: 3, top: 3, bottom: 3),
                              child: CircleAvatar(
                                maxRadius: 50,
                                backgroundImage: NetworkImage(user.photoURL),
                              ),

                            ),

                            Column(
                              children: [
                                Container(
                                    constraints: BoxConstraints(
                                        maxWidth: 300
                                    ),
                                    child: Text("${user.displayName}",
                                      style: TextStyle(fontSize: 24,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),)),
                                Container(
                                    constraints: BoxConstraints(
                                        maxWidth: 300
                                    ),
                                    child: Text("${user.email}",
                                      style: TextStyle(fontSize: 15,
                                          color: Colors.white,
                                          fontWeight: FontWeight.normal),)),
                                SizedBox(height: 10,),
                                Container(
                                    constraints: BoxConstraints(
                                        maxWidth: 300
                                    ),
                                    child: Text("${user.phoneNumber==null?"": user.phoneNumber}",
                                      style: TextStyle(fontSize: 15,
                                          color: Colors.white,
                                          fontWeight: FontWeight.normal),)),




                              ],
                            ),
                          ],
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                        )

                      ],
                    ),

                    SizedBox(height: 30,),

                  ],
                ),

              ),
            ),

            SizedBox(height: 10,),

            Visibility(
              visible: user.phoneNumber==null?true:false,
              child: InkWell(
                onTap: (){
                  Get.to(()=> ContinueWithPhone());
                },
                child: Container(
                  margin: EdgeInsets.only(left: 20, right: 20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.orange.withOpacity(0.7),
                  ),
                  padding: EdgeInsets.all(16),
                  child: Row(
                    children: <Widget>[
                      Image.asset(Images.phone, height: 80, width: 80,),
                      SizedBox(width: 24,),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text("Link With Your Phone"
                              ,
                              style: TextStyle(fontSize: 22, fontWeight: FontWeight
                                  .bold, color: Colors.white),),
                            SizedBox(height: 10,),
                            Text("For SMS, Notification and Emergency contact",
                              style: TextStyle(
                                  fontSize: 16, height: 1.5, color: Colors.white),),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            ListTile(
              leading: Icon(FontAwesomeIcons.user),
              title: Text("Patient ID" , style: TextStyle(color: AppColor.black , fontSize: 18 , fontWeight: FontWeight.bold),),
              subtitle:Text("98241657" , style: TextStyle(color: AppColor.black , fontSize: 15),) ,
            ),

            Divider(indent: 15.0,endIndent: 15, thickness: 1,),
            GenderWidget(context),
            Divider(indent: 15.0,endIndent: 15, thickness: 1,),
            AgeWidget(context),
            ListTile(

              leading: Icon(FontAwesomeIcons.envelope),
              title: Text("Patient Email" , style: TextStyle(color: AppColor.black , fontSize: 18 , fontWeight: FontWeight.bold),),
              subtitle:Text(user.email , style: TextStyle(color: AppColor.black , fontSize: 15),) ,
            ),
            Divider(indent: 15.0,endIndent: 15, thickness: 1,),
            ListTile(
              leading: Icon(FontAwesomeIcons.phone),
              title: Text("Patient Phone" , style: TextStyle(color: AppColor.black , fontSize: 18 , fontWeight: FontWeight.bold),),
              subtitle:Text("${user.phoneNumber==null?"+91 ***": user.phoneNumber}" , style: TextStyle(color: AppColor.black , fontSize: 15),) ,
            ),
            Divider(indent: 15.0,endIndent: 15, thickness: 1,),




            addressWidget(context),


            SizedBox(height: 24,),


          ],
        ),

      ),
    );
  }

}

Widget addressWidget(BuildContext context){
  final pc = Provider.of<GeolocatorService>(context, listen: false);
  pc.getCurrentLocation();
  return ListTile(

    leading: Icon(FontAwesomeIcons.locationArrow),

    title: Text("Address" , style: TextStyle(color: AppColor.black , fontSize: 18 , fontWeight: FontWeight.bold),),
    subtitle:
    Container(
      constraints: BoxConstraints(maxWidth: 250.0),
      child: Consumer<GeolocatorService>(
        builder: (context, location, child){
          return Text(location.location, style: TextStyle(color: Colors.black, fontSize: 15.0, fontWeight: FontWeight.w300, ),);
        },
      ),
    ) ,
  );
}

Widget GenderWidget(BuildContext context){
  final pc = Provider.of<DatabaseManager>(context, listen: false);
  pc.getData();
  return ListTile(

    leading: Icon(FontAwesomeIcons.venusMars),

    title: Text("Gender" , style: TextStyle(color: AppColor.black , fontSize: 18 , fontWeight: FontWeight.bold),),
    subtitle:
    Container(
      constraints: BoxConstraints(maxWidth: 250.0),
      child: Consumer<DatabaseManager>(
        builder: (context, user, child){
          return Text(user.gender!=null?user.gender:"**", style: TextStyle(color: Colors.black, fontSize: 15.0, fontWeight: FontWeight.w300, ),);
        },
      ),
    ) ,
  );
}

Widget AgeWidget(BuildContext context){
  final pc = Provider.of<DatabaseManager>(context, listen: false);
  pc.getData();
  return ListTile(

    leading: Icon(FontAwesomeIcons.birthdayCake),

    title: Text("Age" , style: TextStyle(color: AppColor.black , fontSize: 18 , fontWeight: FontWeight.bold),),
    subtitle:
    Container(
      constraints: BoxConstraints(maxWidth: 250.0),
      child: Consumer<DatabaseManager>(
        builder: (context, user, child){
          return Text(user.age!=null?"${user.age} years":"**", style: TextStyle(color: Colors.black, fontSize: 15.0, fontWeight: FontWeight.w300, ),);
        },
      ),
    ) ,
  );
}


