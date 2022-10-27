import 'package:flutter/material.dart';
class ItemContainer extends StatelessWidget {
  final String? itemname;
  final String? image;
  var itemprice;
  GestureTapCallback? onPressed;
  ItemContainer({Key? key,this.itemname,this.itemprice,this.image,this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      margin: EdgeInsets.all(16),
      decoration: BoxDecoration(color: Colors.white,
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(25)
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: 80,
            height: 80,
            child: FadeInImage.assetNetwork(placeholder: 'assets/images/anim.gif', image: 'https://tolscafetest-api.birdcloud.qa/${image}',
              fit: BoxFit.cover,
              height: 300,

            ),
          ),
          Column(
            children: [
              Text('${itemname}',style: TextStyle(fontWeight: FontWeight.w900),),
              SizedBox(height: 10,),
              Text('${itemprice} QR',style: TextStyle(fontWeight: FontWeight.w700),),
            ],
          ),
          CircleAvatar(
            child: IconButton(onPressed: onPressed,icon: Icon(Icons.add,color: Colors.white,),),
            backgroundColor: Colors.red.shade900,
    )

        ],
      ),
    );
  }
}
