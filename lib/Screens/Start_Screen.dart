import 'dart:async';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kinder_garten/Screens/Home_screen.dart';
import 'package:kinder_garten/Widgets/CustomButton.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GetStartScreen extends StatefulWidget {
  GetStartScreen({Key key, this.title}) : super(key: key);

  final String title;

  @override
  GetStartScreenState createState() => GetStartScreenState();
}

class GetStartScreenState extends State<GetStartScreen> {

  SharedPreferences prefs;

  @override
  void initState() {
    super.initState();
  }


  Future<Null> handleSignIn() async {
    prefs = await SharedPreferences.getInstance();
    Random random = new Random();
    int generatedKey = random.nextInt(8999999) + 1000000;

    Firestore.instance.collection('children').document("$generatedKey").setData({
      'lat': "0.0",
      'lng': "0.0",
      'guardian':""
    });
    // Write data to local
    await prefs.setString('baby_key', "$generatedKey");
    Fluttertoast.showToast(msg: "success operation");


    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>
        HomePageScreen(generatedKey: "$generatedKey",)));
  }


  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.teal,
          title: Text(
            widget.title,
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
        ),
        body: _buildScreen(size: _size,context: context),
    );
  }

  Widget _buildScreen({Size size,BuildContext context}){
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.all(10.0),
        width: size.width,
        height: size.height-MediaQuery.of(context).padding.top,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Column(
                children: <Widget>[
                  Image(
                    image: AssetImage("assets/images/logo.png"),
                    width: size.width*0.4,
                    height: size.width*0.3,
                  ),
                  SizedBox(height: 35,),
                  Text(
                    "Welcome to the kindergarten app",
                    style: TextStyle(color: Colors.grey,fontSize: 20),
                  ),
                ],
              ),
              Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: CustomButtonWidget(
                      title: "Generate Key",
                      onPressed: ()async{
                        await handleSignIn();
                      },
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

}
