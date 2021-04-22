import 'package:flutter/material.dart';
import 'package:tika/Utils/appconfig.dart';
class NoInternet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(AppString.OFFLINE, style: TextStyle(color:  Colors.white),),
        SizedBox(width: 8.0,),
        SizedBox(width:12.0, height: 12.0, child:
          CircularProgressIndicator(
            strokeWidth: 2.0,
            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
          )
          ,)
      ],
    );
  }
}
