import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:kinder_garten/Screens/ShowKey_screen.dart';
import 'package:location/location.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePageScreen extends StatefulWidget {

  final String generatedKey;
  HomePageScreen({@required this.generatedKey});

  @override
  _HomePageScreenState createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen> {

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  LocationData  currentLocation;
  var location = new Location();

  @override
  initState(){
    super.initState();
    _initState();
  }


  _initState()async{
    location.onLocationChanged().listen((LocationData currentLocation) {
      // Use current location
      print("location change ");
      _updateData(LatLng(currentLocation.latitude,currentLocation.longitude));
    });
  }

  _updateData(LatLng latLng)async{
    // save in firebase
    print("update values when location change ");
    Firestore.instance.collection('children').document("${widget.generatedKey}").updateData({
      'lat': latLng.latitude,
      'lng': latLng.longitude,
      //'guardian':""
    });
  }


  _getKey()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context)=>
          ShowKeyScreen(babyKey: prefs.getString("baby_key"),))
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: Text("KinderGarten",style: TextStyle(color: Colors.white,fontSize: 18),),
        centerTitle: true,
      ),

      body: Container(
        height: MediaQuery.of(context).size.height-100,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[

            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                height: 60.0,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    gradient: LinearGradient(
                      colors: <Color>[Color(0xff55ffff),Color(0xff89cff0)],
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey[500],
                        offset: Offset(0.0, 1.5),
                        blurRadius: 5.5,
                      ),
                    ]
                ),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: _getKey,
                    child: Center(
                      child: Text("Get Key",
                        style: TextStyle(fontSize: 20,color: Colors.white),),
                    )
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
