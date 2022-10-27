import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:waiterbird/Presintation/UIScreens/HomeMainScreens/cart/mycart.dart';
import 'package:waiterbird/constant/Toastmessage/compontents.dart';
import 'package:waiterbird/cubit/app_cubit.dart';
import 'package:waiterbird/function/database/dbhelper.dart';
import 'package:waiterbird/models/cartmodel.dart';

import '../../../Widgets/container/itemContainer.dart';
import 'itemDetils.dart';
class ItemScreen extends StatefulWidget {
  final String ? barname;
  final int ? cateogry_id;
  var type;
  ItemScreen({Key? key,this.barname,this.cateogry_id,this.type}) : super(key: key);

  @override
  State<ItemScreen> createState() => _ItemScreenState();
}

class _ItemScreenState extends State<ItemScreen> {
  @override
  Widget build(BuildContext context) {
    var size, height, width;
    size = MediaQuery.of(context).size;
    height = size.height;
    width = size.width;
    DBHelper? dbHelper=DBHelper();

    return BlocProvider(create: (BuildContext context) => AppCubit(),
      child: BlocConsumer<AppCubit, AppState>(builder: (BuildContext context, state){
        AppCubit cubit = AppCubit.get(context);
        _getItem() async {
          await cubit.GetItem('${widget.cateogry_id}');
        }
        return Scaffold(
          appBar: AppBar(title: Text('${widget.barname}'),
          actions: [Stack(
            children: [
              IconButton(onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>MyCartScreen(type: widget.type,)));
              }, icon: Icon(Icons.shopping_cart_rounded)),
              Positioned(top: 5,right: 5, child:cubit.getCounter()==null?Text(''):Text('${cubit.getCounter()}'))
            ],
          )],
          ),
          body: Container(
            child: FutureBuilder(
              future: _getItem(),
              builder: (context,snapshot){
                if (snapshot!=null){
                  return ListView.builder(
                      itemCount: cubit.itemData.length,
                      itemBuilder: (context,index){
                    return GestureDetector(
                      onTap: (){
                        // Navigator.push(context, MaterialPageRoute(builder: (context)=>ItemDetals(image: 'https://tolscafetest-api.birdcloud.qa/${cubit.itemData[index]["Image"]}',itemname: cubit.itemData[index]["NameEnglish"],priceitem: cubit.itemData[index]["CardSizes"].map((e){return e['Price'];}),)));
                      //  Navigator.push(context, MaterialPageRoute(builder: (context)=>ItemDetals(id:cubit.itemData[index]["ID"])));

                      },
                      child: ItemContainer(
                        itemname: cubit.itemData[index]["NameEnglish"],
                        //itemprice: cubit.itemData[index]["CardSizes"].map((e){return jsonEncode(e['Price']);}),
                        itemprice: cubit.itemData[index]["CardSizes"][0]['Price'],
                        image: cubit.itemData[index]["Image"],
                        onPressed: () {
                          int qunantity=1;
                          dbHelper.insert(
                            Cart(
                              id:'${widget.cateogry_id},${index}',
                              productId: cubit.itemData[index]['CardSizes'][0]["ID"].toString(),
                              productName: cubit.itemData[index]["NameEnglish"],
                              initialPrice: cubit.itemData[index]["CardSizes"][0]['Price'],
                              productPrice:cubit.itemData[index]["CardSizes"][0]['Price'],
                              unitTag: 'Unit Size',
                              quantity: qunantity,
                              image: cubit.itemData[index]["Image"]
                            )
                          ).then((value){
                            print('Produce is Add to Cart');
                            cubit.AddTotalprice(cubit.itemData[index]["CardSizes"][0]['Price'],);
                            cubit.AddCounter();
                          }).onError((error, stackTrace){
                            print('111111111111111111${error.toString()}');
                            showToast(text: 'Already Added !', state: ToastState.WARNING);

                          });

                        },
                      ),
                    );

                  });
                }else {
                  return Center(child: Image.asset('assets/images/anim.gif'),);
                }

              },
            ),
          ),


        );
      }, listener: (BuildContext context, state){


      }),
    );
  }
}
