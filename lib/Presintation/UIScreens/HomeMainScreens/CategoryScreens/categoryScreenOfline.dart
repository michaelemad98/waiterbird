import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:waiterbird/Presintation/UIScreens/HomeMainScreens/categoryitem/itemCategoryScereen.dart';
import 'package:waiterbird/cubit/app_cubit.dart';

import '../../../../constant/Toastmessage/compontents.dart';
import '../../../Widgets/container/categoryContainer.dart';


class CategoiesScreenOffline extends StatefulWidget {
  var type;
  CategoiesScreenOffline({Key? key,this.type}) : super(key: key);

  @override
  State<CategoiesScreenOffline> createState() => _CategoiesScreenOfflineState();
}

class _CategoiesScreenOfflineState extends State<CategoiesScreenOffline> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
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
        _getCate() async {
          await cubit.getCategoryData();
          return await cubit.getCategoryData();
        }
        return Scaffold(
          appBar: AppBar(title: Text('Categories Offline'),),
          body: Container(
            child: FutureBuilder(
              future: _getCate(),
              builder: (context,snspShot){
                if(snspShot.hasData){

                  return GridView.builder(gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                  ),
                      itemCount: snspShot.data!.length,
                      itemBuilder: (context,index){
                        return GestureDetector(
                            onTap: (){
                              // Navigator.push(context, MaterialPageRoute(builder: (context)=>ItemScreen(barname: snspShot.data![index].NameEnglish,cateogry_id:snspShot.data![index].id,type:widget.type,)));
                              // Navigator.push(context, MaterialPageRoute(builder: (context)=>ItemScreenOffline()));

                              },
                            child: CategoryConctainerOFF(
                              image: Image.asset('${snspShot.data![index].Image}',fit: BoxFit.cover,
                                height: 300,),
                              name: snspShot.data![index].NameEnglish,));
                      });
                }else{
                  print(_getCate());
                  return Center(child: CircularProgressIndicator());
                }
              },),
          ),
        );
      }, listener: (BuildContext context, state){

      }),
    );
  }
}
/*
MyCart_Container(itemname:snspShot.data![index].productName,image: snspShot.data![index].image,itemprice:snspShot.data![index].initialPrice,
                          onPresseddelete: (){
                            dbHelper.delete('${snspShot.data![index].id}');
                            cubit.RemoveCounter();
                            cubit.RemoveTotalprice(double.parse('${snspShot.data![index].initialPrice}'));
                          },
                          qty:snspShot.data![index].quantity ,
                          onPressedrmv: (){

                          },
                          onPressedadd: (){
                          },
                        )
FutureBuilder(
              future: cubit.getCategoryData(),
              builder: (context,snapshot){
                if (snapshot.hasData){

                  return GridView.builder(gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                  ),
                      itemCount: cubit.CategotyData.length,
                      itemBuilder: (BuildContext context, index){
                        return GestureDetector(
                            onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context)=>ItemScreen(barname: snapshot.data![index].NameEnglish,cateogry_id:snapshot.data![index].id,type:widget.type,)));},
                            child: CategoryConctainer(image: snapshot.data![index].Image,name: snapshot.data![index].NameEnglish,));
                      });
                }else {
                  return Center(child: Image.asset('assets/images/anim.gif'),);
                }

              },
            ),
 */