import 'package:flutter/material.dart';
import 'package:kinder_garten/Screens/Home_screen.dart';
import 'package:kinder_garten/Screens/Start_Screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:splashscreen/splashscreen.dart'as sp;


class SplashScreen extends StatelessWidget {

  bool isHaveKey = false;
  String babyKey;

  setKey()async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    if(pref.getString("baby_key") !=null){
      babyKey = pref.getString("baby_key");
      isHaveKey = true;
    }else{
      isHaveKey = false;
    }
  }

  @override
  Widget build(BuildContext context){
    setKey();
    return sp.SplashScreen(
      gradientBackground: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [Color(0xff55ffff),Color(0xff89cff0)],
      ),
      image: Image(
        image: AssetImage("assets/images/logo.png"),
      ),
      photoSize: MediaQuery.of(context).size.width*.3,
      seconds: 3,
      navigateAfterSeconds: isHaveKey?
      GetStartScreen(title: "KinderGarten",):
      HomePageScreen(generatedKey: babyKey,),
      loaderColor: Colors.white,
      loadingText: Text(
        "Starting Kinder Garten App",
        style: TextStyle(color: Colors.black),
      ),
    );
  }
}

