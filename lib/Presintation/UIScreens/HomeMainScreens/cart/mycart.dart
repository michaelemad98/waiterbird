import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:waiterbird/Presintation/Widgets/buttons/buttonstart.dart';
import 'package:waiterbird/Presintation/Widgets/inputText/inputText.dart';
import 'package:waiterbird/models/cartmodel.dart';

import '../../../../constant/Toastmessage/compontents.dart';
import '../../../../cubit/app_cubit.dart';
import '../../../../function/database/dbhelper.dart';
import '../../../Widgets/container/Mycart_container.dart';
import '../../HomeMain.dart';
class MyCartScreen extends StatefulWidget {
  var type;
  MyCartScreen({Key? key,this.type}) : super(key: key);

  @override
  State<MyCartScreen> createState() => _MyCartScreenState();
}

class _MyCartScreenState extends State<MyCartScreen> {
  @override
  Widget build(BuildContext context) {
    var size, height, width;
    size = MediaQuery.of(context).size;
    height = size.height;
    width = size.width;
    DBHelper? dbHelper=DBHelper();
    return BlocProvider(create: (BuildContext context) => AppCubit()..getData(),
      child: BlocConsumer<AppCubit, AppState>(builder: (BuildContext context, state){
        AppCubit cubit = AppCubit.get(context);

        return Scaffold(
          appBar: AppBar(title: Text('${'My Cart'}'),
          ),
          body:ListView(children: [
            Container(
              padding: EdgeInsets.all(16),
              margin: EdgeInsets.all(16),
              decoration: BoxDecoration(color: Colors.red.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(15)
              ),
              child: Center(child:
                Text('You Have  ${cubit.getCounter()}  Item in your list chart',style: TextStyle(color: Colors.red.shade900,fontWeight: FontWeight.w700),),),
            ),
            Container(
              height: height/2.5,
              child: FutureBuilder(
                future: cubit.getData(),
                builder: (context,snspShot){
                  if(snspShot.hasData){
                    return ListView.builder(
                        itemCount: snspShot.data!.length,
                        itemBuilder: (context,index){
                          return MyCart_Container(itemname:snspShot.data![index].productName,image: snspShot.data![index].image,itemprice:snspShot.data![index].initialPrice,
                            onPresseddelete: (){
                            dbHelper.delete('${snspShot.data![index].id}');
                            cubit.RemoveCounter();
                            cubit.RemoveTotalprice(double.parse('${snspShot.data![index].initialPrice}'));
                          },
                            qty:snspShot.data![index].quantity ,
                            onPressedrmv: (){
                              int qunantity= snspShot.data![index].quantity!;
                              double price =snspShot.data![index].initialPrice!;
                              qunantity--;
                              double newPrice= qunantity*price;
                              if(qunantity > 0){
                                dbHelper.updareqty(Cart(
                                    id: snspShot.data![index].id,
                                    image: snspShot.data![index].image,
                                    initialPrice: snspShot.data![index].initialPrice,
                                    productId: snspShot.data![index].productId.toString(),
                                    productName: snspShot.data![index].productName,
                                    unitTag: snspShot.data![index].unitTag,
                                    quantity: qunantity,productPrice: newPrice)
                                ).then((value){
                                  newPrice=0.0;
                                  qunantity=0;
                                  cubit.RemoveTotalprice(double.parse(snspShot.data![index].initialPrice.toString()));
                                }).onError((error, stackTrace){print(error.toString());});
                              }

                            },
                            onPressedadd: (){
                            int qunantity= snspShot.data![index].quantity!;
                            double price =snspShot.data![index].initialPrice!;
                            qunantity++;
                            double newPrice= qunantity*price;
                            dbHelper.updareqty(Cart(
                                id: snspShot.data![index].id,
                                image: snspShot.data![index].image,
                                initialPrice: snspShot.data![index].initialPrice,
                                productId: snspShot.data![index].productId.toString(),
                                productName: snspShot.data![index].productName,
                                unitTag: snspShot.data![index].unitTag,
                                quantity: qunantity,productPrice: newPrice)
                              ).then((value){
                                newPrice=0.0;
                                qunantity=0;
                                cubit.AddTotalprice(double.parse(snspShot.data![index].initialPrice.toString()));
                            }).onError((error, stackTrace){print(error.toString());});
                            },
                          );
                        });
                  }else{
                    return Text('');
                  }
                },),
            ),



            Container(
              padding: EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Total Price",style: TextStyle(fontWeight: FontWeight.w900,fontSize: 25),),
                  Text('${cubit.getTotalPrice()}',style: TextStyle(fontWeight: FontWeight.w900,fontSize: 25)),
                ],
              ),
            ),
            
           Container(
              padding: EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ButtonStart(onPrimary: Colors.white, primary: Colors.red.shade900 , onPressed: (){
                    cubit.ISShow();
                  }, text: "Create Order", minimumSizeX: 30, minimumSizeY: 45, paddingHorizontal: 25 , fontSize: 25, radius: 25),
                  ButtonStart(onPrimary: Colors.white, primary: Colors.grey.shade700 , onPressed: (){
                    dbHelper.deleteAll();
                  }, text: "Cancel", minimumSizeX: 30, minimumSizeY: 45, paddingHorizontal: 25 , fontSize: 25, radius: 25),

                ],
              ),
            ),
            cubit.isshow?Container(child: Column(
              children: [
                Text('Cart Plate Number'),
                DefaultTextInput(tec: cubit.carplatTEC, hintText: 'Cart Plate Number', obscureText: false),
                ButtonStart(onPrimary: Colors.white, primary: Colors.red.shade900 , onPressed: (){
                  cubit.CreateOrder(widget.type);
                }, text: "Create Order", minimumSizeX: 30, minimumSizeY: 45, paddingHorizontal: 25 , fontSize: 25, radius: 25),

              ],
            ),):Container(),
          ],),

        );
      }, listener: (BuildContext context, state){
        if(state is CreateOrderStateSucess){
          showToast(text: "Success", state: ToastState.SUCCESS);
          Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeMainScreen()));
        }
        else if(state is CreateOrderStateError){
          showToast(text: "Sorry Can't Create Order please try Again ", state: ToastState.ERROR);
        }

      }),
    );
  }
}
