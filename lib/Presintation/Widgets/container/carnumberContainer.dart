import 'package:flutter/material.dart';

class CarNumberContainer extends StatelessWidget {
  final String ?txt;
  final GestureTapCallback ?onpress;
  final Color ?color;
  const CarNumberContainer({Key? key,this.txt,this.onpress,this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onpress,
      child: Container(
        padding: EdgeInsets.all(5),
        margin: EdgeInsets.all(5),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: color
        ),
        child: Center(child: Text('${txt}',style: TextStyle(fontSize: 25,color: Colors.white),)),

      ),
    );
  }
}

