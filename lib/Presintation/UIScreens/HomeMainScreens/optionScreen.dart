import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:waiterbird/Presintation/UIScreens/HomeMainScreens/CategoryScreens/categoryScreenOfline.dart';
import 'package:waiterbird/Presintation/UIScreens/LoginScreen/loginScreen.dart';

import '../../../cubit/app_cubit.dart';
import '../../../function/sharedprefrenc.dart';
class OptionsScreen extends StatefulWidget {
  const OptionsScreen({Key? key}) : super(key: key);

  @override
  State<OptionsScreen> createState() => _OptionsScreenState();
}

class _OptionsScreenState extends State<OptionsScreen> {
  @override
  Widget build(BuildContext context) {
    var size, height, width;
    size = MediaQuery.of(context).size;
    height = size.height;
    width = size.width;
    return BlocProvider(create: (BuildContext context) => AppCubit(),
      child: BlocConsumer<AppCubit, AppState>(builder: (BuildContext context, state){
        AppCubit cubit = AppCubit.get(context);

        return Scaffold(
          appBar: AppBar(
            title: Text('Options'),
          ),
          body: SingleChildScrollView(
            child: Container(
              margin: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [Text("SETTINGS"),
                  SizedBox(height: 16,),
                  GestureDetector(
                    onTap: (){},
                    child: Container(
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(color: Colors.white,
                          border: Border.all(color: Colors.grey)
                      ),

                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("My Account",style: TextStyle(fontSize: 16)),
                          Icon(Icons.arrow_forward_ios_sharp),
                        ],),
                    ),
                  ),
                  SizedBox(height: 5,),
                  GestureDetector(
                    onTap: (){},
                    child: Container(
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(color: Colors.white,
                          border: Border.all(color: Colors.grey)
                      ),

                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Notifiations",style: TextStyle(fontSize: 16)),
                          Icon(Icons.arrow_forward_ios_sharp),
                        ],),
                    ),
                  ),
                  SizedBox(height: 5,),
                  GestureDetector(
                    onTap: (){
                      cubit.InsertCategory();
                    },
                    child: Container(
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(color: Colors.white,
                          border: Border.all(color: Colors.grey)
                      ),

                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Get Category",style: TextStyle(fontSize: 16)),
                          Icon(Icons.arrow_forward_ios_sharp),
                        ],),
                    ),
                  ),
                  SizedBox(height: 5,),
                  GestureDetector(
                    onTap: (){
                      cubit.insertItem();
                    },
                    child: Container(
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(color: Colors.white,
                          border: Border.all(color: Colors.grey)
                      ),

                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Get Item",style: TextStyle(fontSize: 16)),
                          Icon(Icons.arrow_forward_ios_sharp),
                        ],),
                    ),
                  ),
                  SizedBox(height: 5,),
                  GestureDetector(
                    onTap: (){
                      CacheHelper.saveData(key: 'islogin', value: false);
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>LoginScreen()));
                    },
                    child: Container(
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(color: Colors.white,
                          border: Border.all(color: Colors.grey)
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Logout",style: TextStyle(fontSize: 16)),
                          Icon(Icons.arrow_forward_ios_sharp),
                        ],),
                    ),
                  ),

                  
                ],
              ),
            ),
          ),
        );
      }, listener: (BuildContext context, state){
        // if(state is InsertCatdgoryErorr){
        //   Navigator.push(context, MaterialPageRoute(builder: (context)=>CategoiesScreenOffline()));
        // }
      }),
    );
  }
}
/*
 */