import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:waiterbird/constant/Toastmessage/compontents.dart';
class CategoryConctainer extends StatelessWidget {
  final String ?image;
  final String ?name;

  const CategoryConctainer({Key? key, this.image,this.name}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(16),
      decoration: BoxDecoration(
          border: Border.all(color: Colors.red.shade900)
      ),
      child: Stack(
        children: [
          FadeInImage.assetNetwork(placeholder: 'assets/images/anim.gif', image: 'https://tolscafetest-api.birdcloud.qa/${image}',
          fit: BoxFit.cover,
            height: 300,

          ),
          Positioned(
            bottom: 1,
            child: Container(
              color: Colors.red.withOpacity(0.5),
              child: Text('$name',style: TextStyle(fontSize: 30,color: Colors.white),),
            ),
          )
        ],
      ),
    );
  }
}
class CategoryConctainerOFF extends StatelessWidget {
  final Widget ?image;
  final String ?name;

  const CategoryConctainerOFF({Key? key,this.image, this.name}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Uint8List bytes = base64Decode('$image');
    // print(bytes);
    // var blob = image;
    // var imageaa;
    // if(blob !=null){
    //   imageaa = base64.decode(blob);
    // }else{
    //   showToast(text: "Errror in base64", state:ToastState.ERROR);
    // }
    return Container(
      margin: EdgeInsets.all(16),
      decoration: BoxDecoration(
          border: Border.all(color: Colors.red.shade900)
      ),
      child: Stack(
        children: [
            // MemoryImage(imageaa),
           image!,
          // Image.asset('$image',fit: BoxFit.cover,
          // height: 300,),
          Positioned(
            bottom: 1,
            child: Container(
              color: Colors.red.withOpacity(0.5),
              child: Text('$name',style: TextStyle(fontSize: 30,color: Colors.white),),
            ),
          )
        ],
      ),
    );
  }
}

