import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../cubit/app_cubit.dart';
import '../../../Widgets/container/carnumberContainer.dart';
class OrderScreen extends StatefulWidget {
  const OrderScreen({Key? key}) : super(key: key);

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
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
          await cubit.GetListOrder();

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
                  return GridView.builder(gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 1,
                    childAspectRatio: (itemWidth / itemHeight),
                  ),
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      itemCount: cubit.ordersDetails.length,
                      itemBuilder: (BuildContext context, index){
                        return CarNumberContainer(txt: cubit.ordersDetails[index].toString(),onpress:(){},color: Colors.red.shade900,);
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
