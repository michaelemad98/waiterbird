import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:waiterbird/Presintation/UIScreens/HomeMainScreens/CategoryScreens/categoryScreenOfline.dart';
import 'package:waiterbird/Presintation/Widgets/buttons/buttonstart.dart';

import '../../../cubit/app_cubit.dart';
import '../../Widgets/container/carnumberContainer.dart';
import 'Orders/ordercarScreen.dart';
import 'categoriesScreen.dart';

class MakeOrderScreen extends StatefulWidget {
  const MakeOrderScreen({Key? key}) : super(key: key);

  @override
  State<MakeOrderScreen> createState() => _MakeOrderScreenState();
}

class _MakeOrderScreenState extends State<MakeOrderScreen> {
  @override
  Widget build(BuildContext context) {
    var size, height, width;
    size = MediaQuery.of(context).size;
    height = size.height;
    width = size.width;
    final double itemHeight = (size.height - kToolbarHeight - 24) / 8;
    final double itemWidth = size.width / 1.5;
    return BlocProvider(create: (BuildContext context) => AppCubit(),
      child: BlocConsumer<AppCubit, AppState>(builder: (BuildContext context, state){
        AppCubit cubit = AppCubit.get(context);
        _getBooks() async {
          await cubit.GetListOrder();

        }
        return DefaultTabController(
          length: 2,
          initialIndex: 0,
          child: Scaffold(
            appBar: AppBar(
              title: Text('Make Order'),
              bottom: const TabBar(

                tabs: <Widget>[
                  Tab(
                    child: Text('Cars'),
                  ),
                  Tab(
                    child: Text('Tables'),
                  ),
                ],
              ),
            ),
            body: TabBarView(
              children: <Widget>[
                Column(
                  children: [
                    Container(
                      height: height/3,
                      child: FutureBuilder(
                        future: _getBooks(),
                        builder: (context,snapshot){
                          if (snapshot!=null){
                            return GridView.builder(gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              childAspectRatio: (itemWidth / itemHeight),
                            ),
                                shrinkWrap: true,
                                scrollDirection: Axis.vertical,
                                itemCount: cubit.orderDatalistnumber.length,
                                itemBuilder: (BuildContext context, index){
                                  return CarNumberContainer(txt: cubit.orderDatalistnumber[index].toString(),onpress:(){

                                    Navigator.push(context, MaterialPageRoute(builder: (context)=>OrderCareScreen(num:cubit.orderDatalistnumber[index].toString(),)));
                                  },color: Colors.grey.shade900,);
                                });
                          }else {
                            return Center(child: Image.asset('assets/images/anim.gif'),);
                          }

                        },
                      ),
                    ),
                    ButtonStart(onPrimary: Colors.white, primary: Colors.grey.shade900, onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>CategoiesScreenOffline(type: 1,)));
                      // Navigator.push(context, MaterialPageRoute(builder: (context)=>CategoiesScreen(type: 2)));
                    }, text: "Make Order", minimumSizeX: 45, minimumSizeY: 45, paddingHorizontal: 25, fontSize: 25, radius: 25),
                  ],
                ),
                Center(
                  child: ButtonStart(onPrimary: Colors.white, primary: Colors.grey.shade900, onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>CategoiesScreenOffline(type: 1,)));
                    // Navigator.push(context, MaterialPageRoute(builder: (context)=>CategoiesScreen(type: 1,)));
                  }, text: "Make Order", minimumSizeX: 45, minimumSizeY: 45, paddingHorizontal: 25, fontSize: 25, radius: 25),
                ),

              ],
            ),
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
Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                ],
              ),
            )
 */