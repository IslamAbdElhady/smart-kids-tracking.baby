import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

// ignore: must_be_immutable
class ShowKeyScreen extends StatelessWidget {

  final String babyKey;
  ShowKeyScreen({this.babyKey});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: Text("KinderGarten",style: TextStyle(color: Colors.white,fontSize: 18),),
        centerTitle: true,
      ),
      body: Container(
        height: MediaQuery.of(context).size.height-100,
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[

              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text("key: ",style: TextStyle(
                        color: Colors.grey,fontSize: 19
                    ),),
                    Text("$babyKey",style: TextStyle(
                        color: Colors.black,fontSize: 16
                    ),),
                  ],
                )
              ),

              QrImage(
                data: babyKey,
                version: QrVersions.auto,
                size: MediaQuery.of(context).size.width*0.45,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
