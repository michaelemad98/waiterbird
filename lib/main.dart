import 'package:flutter/material.dart';
import 'package:waiterbird/Presintation/UIScreens/HomeMain.dart';

import 'Presintation/UIScreens/LoginScreen/loginScreen.dart';
import 'function/database/dbcategory.dart';
import 'function/sharedprefrenc.dart';
bool ?islogin;
void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper.init();

  islogin = CacheHelper.getData(key: 'islogin');

  if (islogin == null||islogin==false) {
    islogin = false;
  } else {
    islogin = true;
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Waiter Bird Menu',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home:islogin!?HomeMainScreen():LoginScreen(),
    );
  }
}

