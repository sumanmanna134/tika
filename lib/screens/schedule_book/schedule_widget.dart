import 'package:flutter/material.dart';
import 'package:tika/Model/event_model.dart';
import 'package:tika/Utils/appconfig.dart';
import 'package:tika/Utils/utils.dart';
import 'package:tika/Utils/vacc_eligible.dart';
import 'package:tika/widget/calendar_widget.dart';
import 'package:tika/widget/custom_scafold.dart';
import 'package:tika/widget/default_button.dart';
import 'package:tika/widget/dialogUtils.dart';
import 'package:tika/widget/textfield_datepicker.dart';
class ScheduleBook extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    EventModel eventModel = EventModel();
    VaccineEigible vaccineEigible = VaccineEigible();
    return SafeArea(
      child: MyScaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.deepPurple,
          elevation: 0,
          title: Text("COVID-19 Vaccine Registration"),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [


              Container(
                child:CalendarWidget(eventModel:eventModel ,),
              ),
              Container( margin: EdgeInsets.only(left: 20,right: 20), decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: Colors.red.shade500.withOpacity(0.7),
          ),
                padding: EdgeInsets.all(16),
                child: Row(
                children: <Widget>[
                  Image.asset(Images.patient,height: 80,width: 80,),
                  SizedBox(width: 24,),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text("Vaccination Allowence"
                      ,style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold,color: Colors.white),),
                    SizedBox(height: 10,),
                    Text("COVID-19 Vaccination For Everyone Above 45",style: TextStyle(fontSize: 16,height: 1.5,color: Colors.white),),
                        SizedBox(height: 10,),



                  ],
                ),
              ),
            ],
          ),
        ),
              SizedBox(height: 40,),


              DefaultButton(text: "Schedule",
                press: (){

                  eventModel.date!=null? vaccineEigible.hasEligible?print(eventModel.toJson())


                      : Utils.showErrorToast("You Are Not Eligible For Vaccination", context):
                  Utils.showErrorToast("Please Choose your Date", context);

                },btnHeight: 40.0,btnWidth: 180.0,fontSize: 15.0, backgroundColor: Colors.deepPurple,),

            ],
          ),
        ),
      ),
    );
  }


}







