import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:waiterbird/Presintation/UIScreens/HomeMainScreens/categoriesScreen.dart';

import '../../constant/colors.dart';
import '../../cubit/app_cubit.dart';
import 'HomeMainScreens/Orders/ordersScereen.dart';
import 'HomeMainScreens/makeoredrScreen.dart';
import 'HomeMainScreens/optionScreen.dart';

class HomeMainScreen extends StatefulWidget {
  const HomeMainScreen({Key? key}) : super(key: key);

  @override
  State<HomeMainScreen> createState() => _HomeMainScreenState();
}

class _HomeMainScreenState extends State<HomeMainScreen> {
  List<Widget> _pages = [
    Scaffold(
      body: Center(child: CategoiesScreen()),
    ),
    Scaffold(
      body: Center(child: OrderScreen()),
    ),
    Scaffold(
      body: Center(child: MakeOrderScreen()),
    ),
    Scaffold(
      body: Center(child: Text("Notifiations")),
    ),
    Scaffold(
      body: Center(child: OptionsScreen()),
    ),
  ];
  int _selectPageindex = 2;

  void _x1(int index) {
    setState(() {
      _selectPageindex = index;
    });
  }
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
          body: _pages[_selectPageindex],
          bottomNavigationBar: BottomNavigationBar(
            selectedItemColor: AppColors.primaryColor,
            unselectedItemColor: AppColors.darkGreyColor,
            currentIndex: _selectPageindex,
            type: BottomNavigationBarType.fixed,
            onTap: _x1,
            items: [
              BottomNavigationBarItem(icon: Icon(Icons.category), label: 'Categories'),
              BottomNavigationBarItem(icon: Icon(Icons.restaurant_menu_sharp), label: 'Orders'),
              BottomNavigationBarItem(icon: Icon(Icons.add_shopping_cart_outlined), label: 'Make order'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.notifications_active), label: 'Notifiations'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.apps_sharp), label: 'Option'),
            ],
          ),
        );
      }, listener: (BuildContext context, state){
        if(state is SignINSccess){
          Navigator.pop(context);
          // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>AddPosts()));

        }else if(state is SignINError){
          Navigator.pop(context);
        }

      }),
    );
  }
}
/*

 */
