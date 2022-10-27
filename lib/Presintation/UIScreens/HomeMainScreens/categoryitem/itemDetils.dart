import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:waiterbird/Presintation/Widgets/buttons/buttonstart.dart';
import 'package:waiterbird/Presintation/Widgets/inputText/inputText.dart';

import '../../../../constant/Toastmessage/compontents.dart';
import '../../../../cubit/app_cubit.dart';
import '../../../../function/database/dbhelper.dart';
import '../../../../models/cartmodel.dart';
class ItemDetals extends StatefulWidget {
  int? id;
  ItemDetals({Key? key,this.id}) : super(key: key);
  @override
  State<ItemDetals> createState() => _ItemDetalsState();
}

class _ItemDetalsState extends State<ItemDetals> {
  @override
  Widget build(BuildContext context) {
    var size, height, width;
    size = MediaQuery.of(context).size;
    height = size.height;
    width = size.width;
    DBHelper? dbHelper=DBHelper();
    return BlocProvider(create: (BuildContext context) => AppCubit()..GetDetils('${widget.id}'),
      child: BlocConsumer<AppCubit, AppState>(builder: (BuildContext context, state){
        AppCubit cubit = AppCubit.get(context);
        return Scaffold(
          appBar: AppBar(title: Text('Datiels'),
          ),
          body:SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                FadeInImage.assetNetwork(placeholder: 'assets/images/anim.gif', image: "https://tolscafetest-api.birdcloud.qa/${cubit.image}",
                  fit: BoxFit.cover,
                  height:height/3,
                ),
                SizedBox(height: 16,),
                Text('${cubit.nameEng}'),
                Container(
                  height: height/9,
                  child: ListView.builder(
                    itemCount: cubit.size.length,
                    itemBuilder: (context,index){
                      return Container(padding: EdgeInsets.all(16),child: Text('${cubit.size[index]['Size']['NameEnglish']}'));
                    },
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  width: double.infinity,
                  color: Colors.grey.withOpacity(0.5),
                  child: Text("Special Instructions"),
                ),
                DefaultTextInput(tec: cubit.emailTEC, hintText: 'Add a note (extra sausce, no Onions,etc. )', obscureText: false),
                SizedBox(height: 16,),
                Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    margin: EdgeInsets.all(10),
                    padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(24.0),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0x29000000),
                        offset: Offset(0, 3),
                        blurRadius: 6,
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      IconButton(onPressed: (){cubit.RemoveItem();}, icon: Icon(Icons.remove)),
                      Text(cubit.item==null?'':'${cubit.item}'),
                      IconButton(onPressed: (){cubit.AddItem();}, icon: Icon(Icons.add)),
                    ],
                  ),
                  ),
                  Container(
                      margin: EdgeInsets.all(10),
                      child: Text('${cubit.finalprice ==null?cubit.prise:cubit.finalprice } QR',style: TextStyle(fontSize: 25, fontWeight: FontWeight.w900),)),
                ],
                ),
                ButtonStart(onPrimary: Colors.white, primary: Colors.grey.shade700, onPressed: (){
                  print(cubit.itemid.toString());
                  print(widget.id);

                  int qunantity=1;
                  dbHelper.insert(
                      Cart(
                          id:'${widget.id}',
                          productId: cubit.itemid.toString(),
                          productName: cubit.nameEng,
                          initialPrice: cubit.finalprice ==null? double.parse(cubit.prise): double.parse('${cubit.finalprice}'),
                          productPrice:cubit.finalprice ==null? double.parse(cubit.prise): double.parse('${cubit.finalprice}') ,
                          unitTag: 'Unit Size',
                          quantity: cubit.item,
                          image: "https://tolscafetest-api.birdcloud.qa/${cubit.image}"
                      )
                  ).then((value){
                    print('Produce is Add to Cart');
                    cubit.AddTotalprice(cubit.finalprice ==null? double.parse(cubit.prise): double.parse('${cubit.finalprice}'),);
                    cubit.AddCounter();
                  }).onError((error, stackTrace){
                    print('111111111111111111${error.toString()}');
                    showToast(text: 'Already Added !', state: ToastState.WARNING);

                  });

                  // */

                }, text: "Add To Cart", minimumSizeX: 45, minimumSizeY: 35, paddingHorizontal: 25, fontSize: 25, radius: 25)
              ],
            ),
          ),


        );
      }, listener: (BuildContext context, state){


      }),
    );
  }
}

