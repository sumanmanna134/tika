import 'package:flutter/material.dart';
import 'package:tika/Utils/appconfig.dart';

class DefaultButton extends StatelessWidget {
  const DefaultButton({
    Key key,
    this.text,
    this.press, this.backgroundColor, this.textColor, this.btnHeight, this.btnWidth, this.fontSize,
  }) : super(key: key);
  final String text;
  final Function press;
  final double btnHeight;
  final double btnWidth;
  final fontSize;

  final Color backgroundColor;
  final Color textColor;


  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: btnWidth!=null ?btnWidth: 200,
      height: btnHeight!=null ?btnHeight: 51,
      child: FlatButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30) ),
        disabledColor: Colors.grey,
        disabledTextColor: Colors.white,
        color: backgroundColor!=null?backgroundColor:AppColor.colorGreen,
        onPressed: press,
        child: Text(
          text.toUpperCase(),
          style: TextStyle(
            fontSize: fontSize!=null ? fontSize : 18,
            color: textColor!=null?textColor:Colors.white,
          ),
        ),
      ),
    );
  }
}