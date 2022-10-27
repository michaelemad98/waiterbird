import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../cubit/app_cubit.dart';
import '../../../Widgets/container/carnumberContainer.dart';
import 'orderDetails.dart';


class OrderCareScreen extends StatefulWidget {
  var num;
  OrderCareScreen({Key? key,this.num}) : super(key: key);

  @override
  State<OrderCareScreen> createState() => _OrderCareScreenState();
}

class _OrderCareScreenState extends State<OrderCareScreen> {
  @override
  Widget build(BuildContext context) {
    var size, height, width;
    size = MediaQuery.of(context).size;
    height = size.height;
    width = size.width;
    double itemHeight = (size.height - kToolbarHeight - 24) / 8;
    double itemWidth = size.width / 1.5;
    return BlocProvider(create: (BuildContext context) => AppCubit(),
      child: BlocConsumer<AppCubit, AppState>(builder: (BuildContext context, state){
        AppCubit cubit = AppCubit.get(context);
        _getBooks() async {
          await cubit.GetOrderDetils(widget.num);

        }
        return Scaffold(
          appBar: AppBar(title: Text('Orders'),
            centerTitle: true,
          ),
          body: Container(
            child: FutureBuilder(
              future: _getBooks(),
              builder: (context,snapshot){
                if (snapshot!=null){
                  return ListView.builder(
                      itemCount: cubit.orderdeilslistcode.length,
                      itemBuilder: (context,index){
                    return CarNumberContainer(color: Colors.red.shade900,txt: cubit.orderdeilslistcode[index].toString(),onpress: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>OrderDetailsSecreen(id: cubit.orderdeilslistid[index],code: cubit.orderdeilslistcode[index].toString(),)));
                      },);

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
