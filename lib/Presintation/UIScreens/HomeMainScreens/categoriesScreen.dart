import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:waiterbird/Presintation/UIScreens/HomeMainScreens/categoryitem/itemCategoryScereen.dart';

import '../../../cubit/app_cubit.dart';
import '../../Widgets/container/categoryContainer.dart';
class CategoiesScreen extends StatefulWidget {
  var type;
  CategoiesScreen({Key? key,this.type}) : super(key: key);

  @override
  State<CategoiesScreen> createState() => _CategoiesScreenState();
}

class _CategoiesScreenState extends State<CategoiesScreen> {
  @override
  Widget build(BuildContext context) {
    var size, height, width;
    size = MediaQuery.of(context).size;
    height = size.height;
    width = size.width;
    return BlocProvider(create: (BuildContext context) => AppCubit(),
      child: BlocConsumer<AppCubit, AppState>(builder: (BuildContext context, state){
        AppCubit cubit = AppCubit.get(context);
        _getBooks() async {
          await cubit.GetCategory();
        }
        return Scaffold(
          appBar: AppBar(title: Text('Categories'),),
          body: Container(
            child: FutureBuilder(
              future: _getBooks(),
              builder: (context,snapshot){
                if (snapshot!=null){
                 return GridView.builder(gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                  ),
                      itemCount: cubit.CategotyData.length,
                      itemBuilder: (BuildContext context, index){
                        return GestureDetector(
                            onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context)=>ItemScreen(barname: cubit.CategotyData[index].nameEnglish,cateogry_id: cubit.CategotyData[index].id,type:widget.type,)));},
                            child: CategoryConctainer(image: cubit.CategotyData[index].image,name: cubit.CategotyData[index].nameEnglish,));
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
