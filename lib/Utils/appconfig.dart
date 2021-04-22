import 'dart:ui';

abstract class AppColor{

  static const Color colorGreen = Color(0xFF00EE44);
  static const Color colorRed = Color(0xFFEE4400);
  static const black = const Color(0xFF000000);
  static const lightBlack = const Color(0xFF626262);
  static const midBlack = const Color(0xFF4d4d4d);
  static const colorSecondary = const Color(0xFFFFFFFF);
  static const kTextColor = Color(0xFF757575);

}

abstract class AppString{
  static const String TITLE = "TIKA";
  static const String ONLINE = "Online";
  static const String OFFLINE = "Offline";

}

abstract class Images{
  static const String patient = "images/patient.png";
  static const String vaccine = "images/vaccine.png";
  static const String phone = "images/phone.png";
  static const String verified = "images/verified.gif";

}

class CustomColor {
  static const Color dark_blue = Color(0xFF05008b);
  static const Color dark_cyan = Color(0xFF025ab5);
  static const Color sea_blue = Color(0xFF106db6);
  static const Color neon_green = Color(0xFF51ca98);
}