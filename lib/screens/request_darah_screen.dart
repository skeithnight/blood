import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:geolocator/geolocator.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:blood/screens/widgets/common_divided_widget.dart';
import 'package:blood/data.dart' as data;
import 'package:http/http.dart' as http;

import 'package:blood/models/request_darah_model.dart';
import 'package:blood/screens/request_darah_detail.dart';
import 'package:blood/screens/widgets/error_widget.dart';

import 'main_screen.dart';

class RequestDarahScreen extends StatefulWidget {
  _RequestDarahScreenState createState() => _RequestDarahScreenState();
}

class _RequestDarahScreenState extends State<RequestDarahScreen> {
  RequestDarahModel requestDarahModel = new RequestDarahModel();
  Position _position;
  bool isLoadinginput = false;


  // Firebase messaging
  FirebaseMessaging _firebaseMessaging = new FirebaseMessaging();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final mainReference = FirebaseDatabase.instance.reference();

  @override
  void initState() {
    super.initState();
    _initPlatformState();
    getUser();
  }

  void getUser() async {
    FirebaseUser user = await _auth.currentUser();
    setState(() {
      this.requestDarahModel.requester = user.uid;
    });
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  void _initPlatformState() async {
    Position position;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      // Geolocator geolocator = Geolocator()..forceAndroidLocationManager = true;
      position = await Geolocator()
          .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      print("position");
    } on Exception {
      print("object");
      position = null;
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      requestDarahModel.latitude = position.latitude;
      requestDarahModel.longitude = position.longitude;
    });
  }

  Widget identityCard() => Container(
      width: double.infinity,
      child: Card(
          elevation: 10.0,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "Identity",
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(
                  height: 5.0,
                ),
                TextField(
                  keyboardType: TextInputType.text,
                  style: TextStyle(color: Colors.black),
                  onChanged: (out) => requestDarahModel.nama = out,
                  decoration: InputDecoration(
                    labelStyle: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                    labelText: "Name",
                  ),
                ),
                TextField(
                  keyboardType: TextInputType.number,
                  style: TextStyle(color: Colors.black),
                  onChanged: (out) => requestDarahModel.noTelp = out,
                  decoration: InputDecoration(
                    labelStyle: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                    labelText: "Phone Number",
                  ),
                ),
              ],
            ),
          )));
  Widget descriptionCard() => Container(
      width: double.infinity,
      child: Card(
          elevation: 10.0,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "Description",
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(
                  height: 5.0,
                ),
                TextField(
                  onChanged: (out) => requestDarahModel.description = out,
                  keyboardType: TextInputType.multiline,
                  maxLines: 5,
                )
              ],
            ),
          )));
  Widget listDarahCard() => Container(
      width: double.infinity,
      child: Card(
          elevation: 10.0,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "Blood type",
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(
                  height: 5.0,
                ),
                Wrap(
                  alignment: WrapAlignment.spaceBetween,
                  children: data.listDarah
                      .map((pc) => Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ChoiceChip(
                                selectedColor: Colors.yellow,
                                label: Text(
                                  pc,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                selected: requestDarahModel.tipeDarah == pc,
                                onSelected: (selected) {
                                  setState(() {
                                    requestDarahModel.tipeDarah =
                                        selected ? pc : null;
                                  });
                                }),
                          ))
                      .toList(),
                ),
              ],
            ),
          )));

  lokasiDonor() {
    return Text(requestDarahModel.latitude.toString() +
        " : " +
        requestDarahModel.longitude.toString());
    // if (requestDarahModel.latitude == null) {
    //   return RaisedButton(
    //     child: Text("Location"),
    //     color: Colors.blue,
    //     textColor: Colors.white,
    //     elevation: 7.0,
    //     onPressed: () {
    //       print(requestDarahModel.latitude);
    //       requestDarahModel.latitude = -6.898356;
    //       requestDarahModel.longitude = 107.621707;
    //     },
    //   );
    // } else {
    //   return Text(requestDarahModel.latitude.toString() +
    //       " , " +
    //       requestDarahModel.longitude.toString());
    // }
  }

  Widget locationCard() => Container(
      width: double.infinity,
      child: Card(
          elevation: 10.0,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "Location",
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(
                  height: 5.0,
                ),
                TextField(
                  decoration: InputDecoration(
                    labelStyle: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                    labelText: "Address",
                  ),
                  onChanged: (out) => requestDarahModel.address = out,
                  keyboardType: TextInputType.multiline,
                  maxLines: 3,
                )
              ],
            ),
          )));
  Widget content() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          identityCard(),
          CommonDivider(),
          SizedBox(
            height: 5.0,
          ),
          descriptionCard(),
          CommonDivider(),
          SizedBox(
            height: 5.0,
          ),
          listDarahCard(),
          CommonDivider(),
          SizedBox(
            height: 5.0,
          ),
          locationCard(),
          CommonDivider(),
          SizedBox(
            height: 5.0,
          ),
          bottomButton(),
          SizedBox(
            height: 20.0,
          ),
        ],
      );
  Widget bottomButton() => Container(
        width: double.infinity,
        margin: EdgeInsets.all(10.0),
        child: isLoadinginput == true
            ? Center(child: CircularProgressIndicator())
            : RaisedButton(
                child: Text("Request"),
                color: Colors.blue,
                textColor: Colors.white,
                elevation: 7.0,
                onPressed: () {
                  if (requestDarahModel.address == null ||
                      requestDarahModel.description == null ||
                      requestDarahModel.latitude == null ||
                      requestDarahModel.longitude == null ||
                      requestDarahModel.nama == null ||
                      requestDarahModel.noTelp == null ||
                      requestDarahModel.tipeDarah == null) {
                    tampilDialog("Alert", "Sorry data is incomplete");
                  } else {
                    setState(() {
                      isLoadinginput = true;
                    });
                    try {
                      // print( requestDarahModel.toJson());
                      inputData();
                    } catch (e) {
                      print(e.toString());
                    }
                  }
                },
              ),
      );

  inputData() {
    mainReference
        .child("requestDarah")
        .push()
        .set(requestDarahModel.toJson())
        .then((value) {
      pushNotif();
    }).catchError((onError) => _showDialog());
  }

  void pushNotif() {
    var fcmToken = "/topics/requestDarah";
    String aa = requestDarahModel.address;
    String bb = json.encode(requestDarahModel);
    var data1 =
        '{"to": "$fcmToken","notification": {"title": "Donorkan darah anda","body": "$aa"},"priority": "high", "data": {"click_action": "FLUTTER_NOTIFICATION_CLICK", "body":$bb}}';
    var url = "https://fcm.googleapis.com/fcm/send";
    http.post(url, body: data1, headers: {
      "Authorization": "key=${data.fcmServerKey}",
      "Content-Type": "application/json"
    }).then((value) {
      _showDialog();
    });
  }

  void tampilDialog(String tittle, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text(tittle),
          content: new Text(message),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Close"),
              onPressed: () {
                if (tittle == "Alert") {
                  Navigator.of(context).pop();
                } else {}
              },
            ),
          ],
        );
      },
    );
  }

  void _showDialog() {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Success"),
          content: new Text(
              "Your request has been broadcast to all member, please wait and hope.."),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Close"),
              onPressed: () {
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => MainScreen()));
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Geolocator().checkGeolocationPermissionStatus(),
        builder:
            (BuildContext context, AsyncSnapshot<GeolocationStatus> snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.data == GeolocationStatus.disabled) {
            return ErrorScreenWidget("Access to location denied",
                "Allow access to the location services for this App using the device settings.");
          }

          if (snapshot.data == GeolocationStatus.denied) {
            return ErrorScreenWidget("Access to location denied",
                "Allow access to the location services for this App using the device settings.");
          }

          return Scaffold(
              appBar: AppBar(
                title: Text("Request Darah"),
              ),
              body: SingleChildScrollView(
                  child: Padding(
                padding: EdgeInsets.all(20.0),
                child: Center(
                  child: content(),
                ),
              )));
        });
  }
}
