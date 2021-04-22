import 'package:tika/Utils/utils.dart';

class VaccineEigible{

  double _days=0.0;

  eligible(String date){
    DateTime dob = Utils.stringToUtcDate(date);
    var years = (Utils.stringToUtcDate(Utils.dateToLocalString(DateTime.now())).difference(dob)).inDays;
    var days = years/365;
    this._days = days;
  }

  bool get hasEligible => _days>=45.0?true:false;

  double get age => _days;



}

