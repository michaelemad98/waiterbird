import 'package:flutter/material.dart';
class MyCart_Container extends StatelessWidget {
  final String? itemname;
  final String? image;
  var itemprice;
  var qty;
  final GestureTapCallback? onPresseddelete;
  final GestureTapCallback? onPressedrmv;
  final GestureTapCallback? onPressedadd;
  MyCart_Container({Key? key,this.itemname,this.itemprice,this.image,this.onPresseddelete,this.onPressedrmv,this.onPressedadd,this.qty}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size, height, width;
    size = MediaQuery.of(context).size;
    height = size.height;
    width = size.width;
    return Stack(
      children: [
        Container(
          padding: EdgeInsets.all(16),
          margin: EdgeInsets.all(10),
          decoration: BoxDecoration(color: Colors.white,
              borderRadius: BorderRadius.circular(15),
          ),
          child:Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              FadeInImage.assetNetwork(placeholder: 'assets/images/anim.gif', image: 'https://tolscafetest-api.birdcloud.qa/${image}',
                width: width/8,
                height:height/8 ,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('${itemname}',style: TextStyle(color: Colors.red.shade900,fontWeight: FontWeight.w900),),
                  SizedBox(height: 16),
                  Text('${itemprice}  QR',style: TextStyle(color: Colors.black,fontWeight: FontWeight.w700)),
                ],
              ),
              Container(
                margin: EdgeInsets.all(2),
                padding: EdgeInsets.all(1),
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
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                  IconButton(onPressed: onPressedrmv, icon: Icon(Icons.remove)),
                  Text('${qty}'),
                  IconButton(onPressed: onPressedadd, icon: Icon(Icons.add)),
                ],),
              )
            ],
          ),
        ),
        Positioned(
            right: 2,

            child: IconButton(onPressed: onPresseddelete, icon: Icon(Icons.clear,color: Colors.red,)))
      ],
    );

  }
}
