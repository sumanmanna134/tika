import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:tika/services/background_messaging_handler.dart';
import 'package:tika/Model/user_response.dart';
import 'package:tika/Utils/utils.dart';
import 'package:tika/Utils/vacc_eligible.dart';
import 'package:tika/controller/formController.dart';
import 'package:tika/services/firebase_service.dart';
import 'package:tika/services/geolocator_service.dart';
import 'package:tika/widget/custom_scafold.dart';
import 'package:tika/widget/homescreenWidget.dart';
import 'package:tika/widget/textfield_datepicker.dart';
import 'package:tika/widget/verification_complete.dart';
class UserForm extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<UserForm> {

  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //

  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  DatabaseManager _databaseManager = DatabaseManager();


  // TextField Controllers
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  TextEditingController mobileNoController = TextEditingController();
  TextEditingController feedbackController = TextEditingController();
  TextEditingController heightController = TextEditingController();
  TextEditingController weightController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController feverduration = TextEditingController();
  TextEditingController hospitalAddress = TextEditingController();
  String _hasFever = null;
  String _hasDryCough = null;
  String _hasheadache = null;
  String _userAddress="";
  double _userLat=0.0;
  double _userLong = 0.0;
  String gender=null;
  String vaccine=null;
  VaccineEigible _vaccineEigible = VaccineEigible();




  void _submitForm() {

    if(_formKey.currentState.validate() && _hasFever!=null && _hasDryCough!=null && vaccine!=null && _hasheadache!=null && gender!=null && _userAddress!=""){
      UserResponse feedbackForm = UserResponse(
        name: nameController.text,
        email_id: emailController.text,
        gender: gender,

        height: double.parse(heightController.text),
        weight: double.parse(weightController.text),
        dry_cough: _hasDryCough,
        fever_duration: _hasFever=="no"? feverduration.text="0": feverduration.text,
        user_address: _userAddress,
        headache: _hasheadache,
        age: ageController.text,
        admitted_in: hospitalAddress.text,
        status: "pending",

        isfever: _hasFever,

        vaccination_stage: vaccine,

        latlong: "${_userLat.toString()},${_userLong.toString()}",


      );

      Utils.showProgressToast("Submitting", context);

      print("Response: ${feedbackForm.toParams().toString()}");



      FormController formController = FormController((String response)async{
        print("Response: $response");
        Utils.showProgressToast("Fetching location..", context);
        if(response == FormController.STATUS_SUCCESS){
          //
          Utils.showProgressToast("Submitting", context);
          _databaseManager.updateVaccinationPhase(gender: gender, age: ageController.text);

          Utils.showSuccessToast("Submitted", context);
          showNotification(title: "Registration Completed!" , body: "Hey! Your Registration has been completed Successfully, Now you can schedule your 1st phase vaccine" );
          Get.to(()=> VerificationCompleted(message: "Done",));

        } else {
          Utils.showSuccessToast("Error", context);
        }
      });

      Utils.showProgressToast("Processing", context);

      formController.submitForm(feedbackForm);





    }else{
      Utils.showSuccessToast("Error", context);
    }


  }


  @override
  Widget build(BuildContext context) {
    final pc = Provider.of<GeolocatorService>(context, listen: false);
    final user = FirebaseAuth.instance.currentUser;
    emailController.text = user.email;
    nameController.text = user.displayName;

    return MyScaffold(
      key:  _scaffoldKey,
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 50,horizontal: 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
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
              SizedBox(height: 20,),


              FutureBuilder(
                future: pc.getCurrentLocation(),
                builder: (context, snapshot) {
                  if(pc.countryCode!=""){

                    return Form(

                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          TextFormField(
                            controller: nameController,
                            keyboardType: TextInputType.name,
                            decoration: InputDecoration(

                              border: OutlineInputBorder(),

                              // prefixIcon: widget.prefixIcon,
                              // suffixIcon: widget.suffixIcon,
                              labelText: "Enter Name",
                            ),

                            validator: (value){
                              if(value.isEmpty){
                                return "Enter Valid Name";
                              }
                              return null;
                            },

                          ),
                          Divider(indent: 15.0,endIndent: 15, thickness: 1,),
                          TextFormField(
                            controller: emailController,
                            readOnly: true,
                            keyboardType: TextInputType.emailAddress,
                            validator: (value){
                              if(value.isEmpty || !Utils.isEmail(value)){
                                return "Enter Valid Email";
                              }
                              return null;
                            },

                            decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: "Email"
                            ),
                          ),
                          Divider(indent: 15.0,endIndent: 15, thickness: 1,),
                          TextFormField(
                            controller: heightController,
                            keyboardType: TextInputType.number,
                            inputFormatters: [WhitelistingTextInputFormatter.digitsOnly,  LengthLimitingTextInputFormatter(3),],

                            validator: (value){
                              if(value.isEmpty){
                                return "Enter Height";
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: "Your Height",
                                suffixText: "CM"

                            ),
                          ),
                          Divider(indent: 15.0,endIndent: 15, thickness: 1,),

                          TextFormField(
                            controller: weightController,
                            keyboardType: TextInputType.number,
                            inputFormatters: [WhitelistingTextInputFormatter.digitsOnly, LengthLimitingTextInputFormatter(2)],

                            validator: (value){
                              if(value.isEmpty){
                                return "Enter Weight";
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: "Your Weight",
                                suffixText: "KG"

                            ),
                          ),

                          Divider(indent: 15.0,endIndent: 15, thickness: 1,),

                          MyTextFieldDatePicker(
                            labelText: "Date of Birth",
                            prefixIcon: Icon(Icons.date_range),
                            suffixIcon: Icon(Icons.arrow_drop_down),
                            lastDate: DateTime.now().subtract(Duration(days: 16058)),
                            firstDate: DateTime.now().subtract(Duration(days: 36500)),
                            initialDate: DateTime.now().subtract(Duration(days: 16060)),
                            onDateChanged: (selectedDate) {
                              // Do something with the selected date
                              _vaccineEigible.eligible(Utils.dateToLocalString(selectedDate));
                              ageController.text = _vaccineEigible.age.toStringAsFixed(0);

                            },
                          ),

                          Divider(indent: 15.0,endIndent: 15, thickness: 1,),

                          TextFormField(
                            controller: ageController,
                            readOnly: true,
                            keyboardType: TextInputType.number,
                            inputFormatters: [WhitelistingTextInputFormatter.digitsOnly, LengthLimitingTextInputFormatter(2)],

                            validator: (value){
                              if(value.isEmpty){
                                return "Enter Age";
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: "Your Age",
                                suffixText: "Years"

                            ),
                          ),


                          SizedBox(height: 10,),

                          Divider(indent: 15.0,endIndent: 15, thickness: 1,),

                          ListTile(
                            leading: Icon(FontAwesomeIcons.venusMars),

                            trailing: Wrap(
                              children: [
                                Text("Male"),
                                new Radio(
                                  value: "male",
                                  groupValue: gender,
                                  onChanged:(String value){
                                    setState(() {
                                      gender = value;
                                    });

                                  },
                                ),
                                SizedBox(width: 10,),
                                Text("Female"),
                                new Radio(
                                  value: "Female",
                                  groupValue: gender,
                                  onChanged:(String value){
                                    setState(() {
                                      gender = value;
                                    });

                                  },
                                ),
                                SizedBox(width: 10,),
                                Text("Others"),
                                new Radio(
                                  value: "Others",
                                  groupValue: gender,
                                  onChanged:(String value){
                                    setState(() {
                                      gender = value;
                                    });

                                  },
                                ),
                              ],
                            ),
                          ),
                          Divider(indent: 15.0,endIndent: 15, thickness: 1,),


                          ListTile(
                            leading: Icon(Icons.info),
                            tileColor: Colors.orange.shade100,
                            title: Text("Do you have Fever? "),
                            trailing: Wrap(
                              children: [
                                Text("Yes"),
                                new Radio(
                                  value: "yes",
                                  groupValue: _hasFever,
                                  onChanged:(String value){
                                    setState(() {
                                      _hasFever = value;
                                    });

                                  },
                                ),
                                SizedBox(width: 10,),
                                Text("No"),
                                new Radio(
                                  value: "No",
                                  groupValue: _hasFever,
                                  onChanged:(String value){
                                    setState(() {
                                      _hasFever = value;
                                    });

                                  },
                                ),
                              ],
                            ),
                          ),

                          Divider(indent: 15.0,endIndent: 15, thickness: 1,),
                          Visibility(
                            visible: _hasFever!=null && _hasFever=="yes"? true: false,
                            child:TextFormField(
                              controller: feverduration,
                              keyboardType: TextInputType.number,
                              inputFormatters: [WhitelistingTextInputFormatter.digitsOnly],

                              validator: (value){
                                if(value.isEmpty && _hasFever=="yes"){
                                  return "Enter fever duration";
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: "Fever Duration",
                                  suffixText: "Days"
                              ),
                            ),

                          ),

                          SizedBox(height: 10,),
                          Divider(indent: 15.0,endIndent: 15, thickness: 1,),

                          ListTile(
                            leading : Icon(Icons.info),
                            tileColor: Colors.orange.shade100,
                            title: Text("Do you have Dry Cough? "),
                            trailing: Wrap(
                              children: [
                                Text("Yes"),
                                new Radio(
                                  value: "yes",
                                  groupValue: _hasDryCough,
                                  onChanged:(String value){
                                    setState(() {
                                      _hasDryCough = value;
                                    });

                                  },
                                ),
                                SizedBox(width: 10,),
                                Text("No"),
                                new Radio(
                                  value: "No",
                                  groupValue: _hasDryCough,
                                  onChanged:(String value){
                                    setState(() {
                                      _hasDryCough = value;
                                    });

                                  },
                                ),
                              ],
                            ),
                          ),
                          Divider(indent: 15.0,endIndent: 15, thickness: 1,),

                          ListTile(
                            leading : Icon(Icons.info),
                            tileColor: Colors.orange.shade100,
                            title: Text("Do you have Headache? "),
                            trailing: Wrap(
                              children: [
                                Text("Yes"),
                                new Radio(
                                  value: "yes",
                                  groupValue: _hasheadache,
                                  onChanged:(String value){
                                    setState(() {
                                      _hasheadache = value;
                                    });

                                  },
                                ),
                                SizedBox(width: 10,),
                                Text("No"),
                                new Radio(
                                  value: "No",
                                  groupValue: _hasheadache,
                                  onChanged:(String value){
                                    setState(() {
                                      _hasheadache = value;
                                    });

                                  },
                                ),
                              ],
                            ),
                          ),
                          Divider(indent: 15.0,endIndent: 15, thickness: 1,),

                          ListTile(
                            leading : Icon(Icons.info),


                            title: Text("Stage of Vaccination "),
                            trailing: Wrap(
                              children: [
                                Text("1st"),
                                new Radio(
                                  value: "1",
                                  groupValue: vaccine,
                                  onChanged:(String value){
                                    setState(() {
                                      vaccine = value;
                                    });

                                  },
                                ),
                                SizedBox(width: 10,),
                                Text("2nd"),
                                new Radio(
                                  value: "2",
                                  groupValue: vaccine,
                                  onChanged:(String value){
                                    setState(() {
                                      vaccine = value;
                                    });

                                  },
                                ),
                              ],
                            ),
                          ),
                          Divider(indent: 15.0,endIndent: 15, thickness: 1,),

                          TextFormField(
                            controller: hospitalAddress,
                            keyboardType: TextInputType.streetAddress,


                            validator: (value){
                              if(value.isEmpty){
                                return "Enter Hospital";
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: "Nearby Hospital Name",
                                suffixText: "At"

                            ),
                          ),




                          Container(
                            padding: EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Icon(FontAwesomeIcons.locationArrow, color: Colors.black,size: 15.0, ),
                                SizedBox(width: 10,),
                                Container(
                                  constraints: BoxConstraints(maxWidth: 250.0),
                                  child:Consumer<GeolocatorService>(
                                    builder: (context, location, child){
                                      _userAddress = location.location;
                                      _userLat = location.latitude;
                                      _userLong = location.longitude;

                                      return Text(location.location, style: TextStyle(color: Colors.black, fontSize: 12.0, fontWeight: FontWeight.w300, ),);
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),

                          RaisedButton(
                            color: Colors.blue,
                            textColor: Colors.white,
                            onPressed:_submitForm,
                            child: Text('Submit'),
                          )
                        ],
                      ),
                    );
                  }
                  else {
                    return Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment:  MainAxisAlignment.center,

                        children: [
                          SizedBox(height: 30,),
                          CircularProgressIndicator(backgroundColor: Colors.deepPurple,),
                          SizedBox(height: 30,),

                          Text("Fetching Location.." , style: TextStyle(fontSize: 20),)
                        ],
                      ),
                    );
                  }

                }
              )
            ],
          ),
        ),
      ),
    );
  }


}