import 'package:flutter/material.dart';
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
