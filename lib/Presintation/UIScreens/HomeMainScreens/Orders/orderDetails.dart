import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../cubit/app_cubit.dart';
import '../../../Widgets/container/Mycart_container.dart';
import '../../../Widgets/container/order_container.dart';
class OrderDetailsSecreen extends StatefulWidget {
  var id;
  var code;
  OrderDetailsSecreen({Key? key,this.code,this.id}) : super(key: key);

  @override
  State<OrderDetailsSecreen> createState() => _OrderDetailsSecreenState();
}

class _OrderDetailsSecreenState extends State<OrderDetailsSecreen> {
  @override
  Widget build(BuildContext context) {
    var size, height, width;
    size = MediaQuery.of(context).size;
    height = size.height;
    width = size.width;
    double itemHeight = (size.height - kToolbarHeight - 24) / 8;
    double itemWidth = size.width / 1.5;
    return BlocProvider(create: (BuildContext context) => AppCubit()..GetOrderDetiales(widget.id),
      child: BlocConsumer<AppCubit, AppState>(builder: (BuildContext context, state){
        AppCubit cubit = AppCubit.get(context);

        return Scaffold(
          appBar: AppBar(title: Text('${widget.code}'),
            centerTitle: true,
          ),
          body: Container(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(cubit.OrderTypeNameEnglish,style: TextStyle(fontSize: 25),),
                Text(cubit.Date,style: TextStyle(fontSize: 25),),
                Container(height: height/1.8,
                child: ListView.builder(
                    itemCount: cubit.OrderItemsQTY.length,
                    itemBuilder: (context,index){
                  return Order_container(image: 'https://tolscafetest.birdcloud.qa/assets/images/logo/logo.png',
                    qty:cubit.OrderItemsQTY[index].toString(),
                    itemname: cubit.OrderItemsNameArabic[index].toString(),
                    itemprice:cubit.OrderItemsPrice[index].toString() ,
                  );
                }),
                ),
                CircleAvatar(
                  radius: 30,
                  child: Text('menu'),
                )

              ],
            ),
          ),
        );
      }, listener: (BuildContext context, state){


      }),
    );
  }
}
/*
 Container(
                    padding: EdgeInsets.all(16),
                    margin: EdgeInsets.all(5),
                    decoration: BoxDecoration(color: Colors.white,
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(25)
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Text(cubit.OrderItemsNameArabic[index].toString()),
                            Text(cubit.OrderItemsQTY[index].toString())
                          ],
                        ),
                        Row(
                          children: [
                            Text(cubit.OrderItemsPrice[index].toString()),
                            Text(cubit.OrderItemsTotalValue[index].toString())
                          ],
                        ),
                      ],
                    ),
                  );
 */