import 'package:flutter/material.dart';

import 'Presintation/UIScreens/LoginScreen/loginScreen.dart';
import 'function/sharedprefrenc.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper.init();
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
      home:LoginScreen(),
    );
  }
}

