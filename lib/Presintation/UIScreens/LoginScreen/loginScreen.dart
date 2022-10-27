import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:waiterbird/Presintation/UIScreens/HomeMain.dart';

import '../../../cubit/app_cubit.dart';
import '../../Widgets/buttons/buttonstart.dart';
import '../../Widgets/inputText/inputText.dart';
class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    var size, height, width;
    size = MediaQuery.of(context).size;
    height = size.height;
    width = size.width;
    return BlocProvider(create: (BuildContext context) => AppCubit(),
      child: BlocConsumer<AppCubit, AppState>(builder: (BuildContext context, state){
        AppCubit cubit = AppCubit.get(context);
        return  Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [
                  Colors.grey.shade800,
                  Colors.red.shade800,
                ],
              )
          ),
          child: Scaffold(

            backgroundColor: Colors.transparent,
            body: SafeArea(
              child: SingleChildScrollView(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image(
                            image: AssetImage('assets/images/anim.gif'),
                            height: height *0.4,
                            fit: BoxFit.cover,
                          ),

                          SizedBox(height: 16,),
                          DefaultTextInput(tec: cubit.emailTEC, hintText: "username", obscureText: false),
                          DefaultTextInput(tec: cubit.passwordTEC, hintText: "password", obscureText: cubit.visibility,suffixIcon: cubit.visibility
                              ? IconButton(
                              onPressed: () {
                                cubit.onvisibilty();
                              },
                              icon: Icon(Icons.visibility))
                              : IconButton(
                              onPressed: () {
                                cubit.offVisibility();
                              },
                              icon: Icon(Icons.visibility_off)),),

                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: ButtonStart(onPrimary: Colors.white, primary: Colors.red, onPressed: (){

                              showDialog(
                                context: context,
                                barrierDismissible: false,
                                builder: (BuildContext context) {
                                  return Dialog(
                                    child: Container(
                                      height: height/9,
                                      child:  Image(
                                        image: AssetImage('assets/images/anim.gif'),

                                      ),
                                    ),
                                  );
                                },
                              );
                              cubit.Sigin();
                            }, text: "Login", minimumSizeX: double.infinity, minimumSizeY: 45, paddingHorizontal: 25, fontSize: 25, radius: 45),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      }, listener: (BuildContext context, state){
        if(state is SignINSccess){
          Navigator.pop(context);
           Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>HomeMainScreen()));

        }else if(state is SignINError){
          Navigator.pop(context);
        }

      }),
    );
  }
}
/*
Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              Colors.grey,
              Colors.red,
            ],
          )
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(child:Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,

          children: [
            Text('Bird Menu',style: TextStyle(
              fontSize: 48.0,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
            ),
          ],
        ),
        ),
      ),
    );
 */