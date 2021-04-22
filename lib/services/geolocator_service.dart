import 'dart:io';


import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoder/geocoder.dart' as geo;
import 'package:tika/services/firebase_service.dart';

class GeolocatorService extends ChangeNotifier{

  double latitude;
  double longitude;

  String location ="Searching Address..";
  String countryCode = "";

  Future getCurrentLocation() async{

      var positionData = await GeolocatorPlatform.instance.getCurrentPosition();

      this.latitude = positionData.latitude;
      this.longitude =  positionData.longitude;

    final cords = geo.Coordinates(latitude, longitude);
    var address = await geo.Geocoder.local.findAddressesFromCoordinates(cords);
    location = address.first.addressLine;
    countryCode = address.first.postalCode;
    print(countryCode);



    notifyListeners();


  }










}