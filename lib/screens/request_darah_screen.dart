import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

import 'package:blood/data.dart' as data;

class RequestDarahScreen extends StatelessWidget {
  Future<Position> posisiSekarang() async {
    await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
  }

  Future<GeolocationStatus> statusGeoLocation() async {
    await Geolocator().checkGeolocationPermissionStatus();
  }

  void getPosition() {
    // print("lokasi: "+posisiSekarang().toString());
    statusGeoLocation().then((onValue) {
      print(onValue);
    });
  }

  Widget content(context) => new Scaffold(
        appBar: AppBar(),
        bottomNavigationBar: Container(
          margin: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
          child: new RaisedButton(
            child: const Text('Request'),
            textColor: Colors.white,
            color: Colors.green,
            elevation: 4.0,
            splashColor: Colors.blueGrey,
            onPressed: () {
              getPosition();
              // Perform some action
            },
          ),
        ),
        body: new Center(
            // child: getPosition(),
            ),
      );
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SafeArea(
      child: content(context),
    );
  }
}
