import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../constant/Toastmessage/compontents.dart';
import '../../../../cubit/app_cubit.dart';
import '../../../../models/cartmodel.dart';
import '../../../Widgets/container/itemContainer.dart';
import '../categoryitem/itemDetils.dart';
class ItemScreenOffline extends StatefulWidget {
  const ItemScreenOffline({Key? key}) : super(key: key);

  @override
  State<ItemScreenOffline> createState() => _ItemScreenOfflineState();
}

class _ItemScreenOfflineState extends State<ItemScreenOffline> {
  get dbHelper => null;

  @override
  Widget build(BuildContext context) {
    var size, height, width;
    size = MediaQuery.of(context).size;
    height = size.height;
    width = size.width;
    //return Container();
    return BlocProvider(create: (BuildContext context) => AppCubit(),
      child: BlocConsumer<AppCubit, AppState>(builder: (BuildContext context, state){
        AppCubit cubit = AppCubit.get(context);
        _getCate() async {
          await cubit.getItemData();
          return await cubit.getItemData();
        }
        return Scaffold(
          appBar: AppBar(title: Text('Item Offline'),),
          body: Container(
            child: FutureBuilder(
              future: _getCate(),
              builder: (context,snspShot){
                if(snspShot.hasData){

                  return ListView.builder(
                      itemCount: snspShot.data!.length,
                      itemBuilder: (context,index){
                        return GestureDetector(
                          onTap: (){
                            // Navigator.push(context, MaterialPageRoute(builder: (context)=>ItemDetals(image: 'https://tolscafetest-api.birdcloud.qa/${cubit.itemData[index]["Image"]}',itemname: cubit.itemData[index]["NameEnglish"],priceitem: cubit.itemData[index]["CardSizes"].map((e){return e['Price'];}),)));
                            // Navigator.push(context, MaterialPageRoute(builder: (context)=>ItemDetals(id:cubit.itemData[index]["ID"])));

                          },
                          child: ItemContainerOffline(
                            itemname: snspShot.data![index].NameEnglish,
                            itemprice: snspShot.data![index].SizePrice,
                            image: snspShot.data![index].Image,
                            onPressed: () {
                              int qunantity=1;
                              // dbHelper.insert(
                              //     Cart(
                              //         id:'1,${index}',
                              //         productId: cubit.itemData[index]['CardSizes'][0]["ID"].toString(),
                              //         productName: cubit.itemData[index]["NameEnglish"],
                              //         initialPrice: cubit.itemData[index]["CardSizes"][0]['Price'],
                              //         productPrice:cubit.itemData[index]["CardSizes"][0]['Price'],
                              //         unitTag: 'Unit Size',
                              //         quantity: qunantity,
                              //         image: cubit.itemData[index]["Image"]
                              //     )
                              // ).then((value){
                              //   print('Produce is Add to Cart');
                              //   cubit.AddTotalprice(cubit.itemData[index]["CardSizes"][0]['Price'],);
                              //   cubit.AddCounter();
                              // }).onError((error, stackTrace){
                              //   print('111111111111111111${error.toString()}');
                              //   showToast(text: 'Already Added !', state: ToastState.WARNING);
                              //
                              // });

                            },
                          ),
                        );

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
