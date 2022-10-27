import 'package:flutter/material.dart';
class Const{
 static  TextEditingController emailTec = new TextEditingController();
  static  TextEditingController passwordTec = new TextEditingController();
  static TextEditingController nameTec = new TextEditingController();
  static GlobalKey<FormState> globalKey = GlobalKey<FormState>();

}
const kUserName = 'userName';
const kUserEmail = 'userEmail';
const kUserPassword = 'userPassword';