
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
// ignore: deprecated_member_use
import 'package:googleapis_auth/auth.dart';
import 'package:googleapis_auth/auth_io.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:tika/Model/booking_model.dart';
import 'package:tika/Utils/appconfig.dart';
import 'package:tika/Utils/calendar_client.dart';
import 'package:tika/Utils/utils.dart';
import 'package:tika/provider/slot_booking_service.dart';
import 'package:googleapis/calendar/v3.dart' as cal;
import 'package:tika/services/firebase_service.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../cred.dart';
import 'create_event.dart';
import 'edit_screen.dart';

class DashboardScreen extends StatefulWidget {
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}


class _DashboardScreenState extends State<DashboardScreen> {
  Storage storage = Storage();




  @override
  Widget build(BuildContext context) {

    final vaccine = Provider.of<DatabaseManager>(context);
    vaccine.getData();



    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
        iconTheme: IconThemeData(
          color: Colors.grey, //change your color here
        ),
        title:Text("Dashboard",style: TextStyle(fontSize: 24,color: Colors.white,fontWeight: FontWeight.bold),),

      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.deepPurple,
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => CreateScreen(),
            ),
          );
        },
      ),
      body: Padding(
        padding: const EdgeInsets.only(
          left: 16.0,
          right: 16.0,
        ),
        child: Container(
          padding: EdgeInsets.only(top: 8.0),
          color: Colors.white,
          child: StreamBuilder<QuerySnapshot>(
            stream: storage.retrieveEvents(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                if (snapshot.data.docs.length > 0) {
                  return ListView.builder(
                    physics: BouncingScrollPhysics(),
                    itemCount: snapshot.data.docs.length,
                    itemBuilder: (context, index) {
                      Map<String, dynamic> eventInfo = snapshot.data.docs[index].data();

                      EventInfo event = EventInfo.fromMap(eventInfo);

                      DateTime startTime = DateTime.fromMillisecondsSinceEpoch(event.startTimeInEpoch);
                      DateTime endTime = DateTime.fromMillisecondsSinceEpoch(event.endTimeInEpoch);

                      String startTimeString = DateFormat.jm().format(startTime);
                      String endTimeString = DateFormat.jm().format(endTime);
                      String dateString = DateFormat.yMMMMd().format(startTime);

                      return Padding(
                        padding: EdgeInsets.only(bottom: 16.0),
                        child: InkWell(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => EditScreen(event: event),
                              ),
                            );
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                padding: EdgeInsets.only(
                                  bottom: 16.0,
                                  top: 16.0,
                                  left: 16.0,
                                  right: 16.0,
                                ),
                                decoration: BoxDecoration(
                                  color: event.hasMarked? CustomColor.neon_green.withOpacity(0.3):Colors.orange.withOpacity(0.3),
                                  borderRadius: BorderRadius.circular(12.0),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      event.name,
                                      style: TextStyle(
                                        color: CustomColor.dark_blue,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 22,
                                        letterSpacing: 1,
                                      ),
                                    ),
                                    SizedBox(height: 10),
                                    Text(
                                      event.description,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        color: Colors.black38,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                        letterSpacing: 1,
                                      ),
                                    ),
                                    SizedBox(height: 10),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                                      child: Text(
                                        event.link,
                                        style: TextStyle(
                                          color: CustomColor.dark_blue.withOpacity(0.5),
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                          letterSpacing: 0.5,
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 10),
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Container(
                                          height: 50,
                                          width: 5,
                                          color: event.hasMarked? CustomColor.neon_green:Colors.blueGrey,
                                        ),
                                        SizedBox(width: 10),
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              dateString,
                                              style: TextStyle(
                                                color: CustomColor.dark_cyan,
                                                fontFamily: 'OpenSans',
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16,
                                                letterSpacing: 1.5,
                                              ),
                                            ),
                                            Text(
                                              '$startTimeString - $endTimeString',
                                              style: TextStyle(
                                                color: CustomColor.dark_cyan,
                                                fontFamily: 'OpenSans',
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16,
                                                letterSpacing: 1.5,
                                              ),
                                            ),
                                            event.hasMarked?SizedBox.shrink() :Row(
                                              children: [
                                                Text(
                                                  "Mark as Completed",
                                                  style: TextStyle(
                                                    color: CustomColor.dark_blue.withOpacity(0.5),
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 16,
                                                    letterSpacing: 0.5,
                                                  ),
                                                ),
                                                IconButton(

                                                  icon: Icon(Icons.check , color: CustomColor.dark_blue.withOpacity(0.5),),

                                                  onPressed: (){

                                                    setState(()async{
                                                      event.hasMarked = true;
                                                      await storage
                                                          .updateEventData(event)
                                                          .whenComplete(() => Utils.showSuccessToast("Completed", context))
                                                          .catchError(
                                                            (e) {
                                                              print(e);
                                                              Utils.showSuccessToast(e, context);

                                                            },
                                                      );
                                                    });


                                                  },
                                                ),
                                              ],
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                } else {
                  return Center(
                    child: Text(
                      'Schedule Your Vaccine Appointment',
                      style: TextStyle(
                        color: Colors.black38,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1,
                      ),
                    ),
                  );
                }
              }
              return Center(
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(CustomColor.sea_blue),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}