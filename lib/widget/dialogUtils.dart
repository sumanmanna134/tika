import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:tika/Utils/appconfig.dart';
class DialogUtils {
  static DialogUtils _instance = new DialogUtils.internal();

  DialogUtils.internal();

  factory DialogUtils() => _instance;

  static void showCustomDialog(BuildContext context,
      {@required String title,
        String okBtnText = "Ok",
        String cancelBtnText = "Cancel",
        String msg = "",
        @required Function okBtnFunction}) {
    showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            title: Align(
                alignment: Alignment.topRight,
                child: Icon(Icons.close,size: 20,)),
            content: Text(msg),
            actions: <Widget>[
              FlatButton(
                child: Text(okBtnText),
                onPressed: okBtnFunction,
              ),
              FlatButton(
                  child: Text(cancelBtnText),
                  onPressed: () => Navigator.pop(context))
            ],
          );
        });
  }


  static showCustomPieChart({@required percentage,
    double radius=90,
    String centerText="40",
    double centerTextFontSize=30.0,
    Color centerTextColor=Colors.white,
    String centerSubText="DAYS" ,
    double centerSubTextFontSize = 15.0,
    Color centerSubTextColor= Colors.white,
    String footerText="TO SURGERY",
    double footerTextFontSize = 18,
    Color footerTextColor = Colors.white,
    Color progressColor=Colors.green,
    Color backgroundColor=AppColor.colorGreen}){
    return CircularPercentIndicator(
      radius: radius, animation: true, animationDuration: 1200,lineWidth: 10.0,percent: percentage,
      center:Wrap(
        direction: Axis.vertical,
        children: [
          Text(centerText,style : TextStyle(fontWeight: FontWeight.bold, fontSize: centerTextFontSize, color: centerTextColor,)),
          Text(centerSubText.toUpperCase(),style : TextStyle( fontSize: centerSubTextFontSize, color: centerSubTextColor,))
        ],
      ),
      footer:Padding(
        padding: const EdgeInsets.only(top: 10),
        child: Text(footerText.toUpperCase() , style: TextStyle(color: footerTextColor, fontWeight: FontWeight.w100 , fontSize: footerTextFontSize),),
      ),
      circularStrokeCap: CircularStrokeCap.square,
      backgroundColor: backgroundColor,
      progressColor: progressColor,
    );

  }
}
