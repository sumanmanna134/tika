import 'dart:convert' as convert;

import 'package:http/http.dart' as http;
import 'package:tika/Model/user_response.dart';


class FormController {

  final void Function(String) callback;


  static const String URL = "https://script.google.com/macros/s/AKfycbz32bUWl3fG5HE4a_cN3oIw4u-68iL7Ulfyg4Yx5V5J3t8fStW78APux0PYumGdVRdPdA/exec";

  static const STATUS_SUCCESS = "SUCCESS";

  FormController(this.callback);

  void submitForm(UserResponse form) async{
    String finalUrl = URL + form.toParams();
    try{
      await http.get(Uri.parse(finalUrl.toString())).then(
              (response){
            callback(convert.jsonDecode(response.body)['status']);
          });
    } catch(e){
      print(e);
    }
  }
}