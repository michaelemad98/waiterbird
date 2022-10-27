import 'package:flutter/material.dart';
class OptionsScreen extends StatefulWidget {
  const OptionsScreen({Key? key}) : super(key: key);

  @override
  State<OptionsScreen> createState() => _OptionsScreenState();
}

class _OptionsScreenState extends State<OptionsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Options'),
      ),
      body: Container(
        margin: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [Text("SETTINGS"),
          SizedBox(height: 16,),
          GestureDetector(
            onTap: (){},
            child: Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(color: Colors.white,
                  border: Border.all(color: Colors.grey)
              ),

              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                Text("My Account",style: TextStyle(fontSize: 16)),
                Icon(Icons.arrow_forward_ios_sharp),
              ],),
            ),
          ),
            SizedBox(height: 5,),
            GestureDetector(
              onTap: (){},
              child: Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(color: Colors.white,
                    border: Border.all(color: Colors.grey)
                ),

                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Notifiations",style: TextStyle(fontSize: 16)),
                    Icon(Icons.arrow_forward_ios_sharp),
                  ],),
              ),
            ),
            SizedBox(height: 5,),
            GestureDetector(
              onTap: (){},
              child: Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(color: Colors.white,
                    border: Border.all(color: Colors.grey)
                ),

                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Logout",style: TextStyle(fontSize: 16)),
                    Icon(Icons.arrow_forward_ios_sharp),
                  ],),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
