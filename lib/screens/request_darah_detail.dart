import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:url_launcher/url_launcher.dart';
<<<<<<< HEAD
=======
import 'package:firebase_auth/firebase_auth.dart';
>>>>>>> 6b27894b4e26bcf7bf6b026641288ab07f379657

import 'package:blood/screens/widgets/common_divided_widget.dart';
import 'package:blood/data.dart' as data;
import 'package:blood/models/request_darah_model.dart';

import 'main_screen.dart';

class RequestDarahDetailScreen extends StatefulWidget {
  final RequestDarahModel requestDarahModel;
  RequestDarahDetailScreen(this.requestDarahModel);
<<<<<<< HEAD
  List<String> listDarah = ["A+", "A-", "B+", "B-", "0+", "0-", "AB+", "AB-"];
  BuildContext mContext;
=======
  _RequestDarahDetailScreenState createState() =>
      _RequestDarahDetailScreenState();
}

class _RequestDarahDetailScreenState extends State<RequestDarahDetailScreen> {
  BuildContext mContext;
  List<String> listDarah = ["A+", "A-", "B+", "B-", "0+", "0-", "AB+", "AB-"];
  // Firebase messaging
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final mainReference = FirebaseDatabase.instance.reference();
  String phoneNumber = "";

  @override
  void initState() {
    super.initState();
    getUser();
  }

  void getUser() async {
    FirebaseUser user = await _auth.currentUser();
    setState(() {
      this.phoneNumber = user.phoneNumber;
    });
  }
>>>>>>> 6b27894b4e26bcf7bf6b026641288ab07f379657

  Widget mapsLocation() => Container(
        width: double.infinity,
        height: 300.0,
        child: new FlutterMap(
          options: new MapOptions(
<<<<<<< HEAD
            center: new LatLng(
                requestDarahModel.latitude, requestDarahModel.longitude),
=======
            center: new LatLng(widget.requestDarahModel.latitude,
                widget.requestDarahModel.longitude),
>>>>>>> 6b27894b4e26bcf7bf6b026641288ab07f379657
            zoom: 13.0,
          ),
          layers: [
            new TileLayerOptions(
              urlTemplate: "https://api.tiles.mapbox.com/v4/"
                  "{id}/{z}/{x}/{y}@2x.png?access_token={accessToken}",
              additionalOptions: {
                'accessToken':
                    'pk.eyJ1Ijoic2tlaXRobmlnaHQiLCJhIjoiY2pvYWw5aGYwMGxnazNybGMxZ3B0ZWc3aiJ9.g5ybUMKi4nGoYGFQdly1-A',
                'id': 'mapbox.streets',
              },
            ),
            new MarkerLayerOptions(
              markers: [
                new Marker(
                  width: 80.0,
                  height: 80.0,
<<<<<<< HEAD
                  point: new LatLng(
                      requestDarahModel.latitude, requestDarahModel.longitude),
=======
                  point: new LatLng(widget.requestDarahModel.latitude,
                      widget.requestDarahModel.longitude),
>>>>>>> 6b27894b4e26bcf7bf6b026641288ab07f379657
                  builder: (ctx) => new Container(
                        child: Icon(Icons.place),
                      ),
                ),
              ],
            ),
          ],
        ),
      );

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
                Text(
                  "Name",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
<<<<<<< HEAD
                Text(requestDarahModel.nama),
                // Text("Phone Number", style: TextStyle( fontWeight: FontWeight.bold),),
                // Text( requestDarahModel.noTelp),
=======
                Text(widget.requestDarahModel.nama),
>>>>>>> 6b27894b4e26bcf7bf6b026641288ab07f379657
                Text(
                  "Address",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
<<<<<<< HEAD
                Text(requestDarahModel.address),
                Center(
                  child: Container(
                    width: 100.0,
                    child: Row(
                      children: <Widget>[
                        Container(
                          child: Column(
                            children: <Widget>[
                              IconButton(
                                icon: Icon(Icons.call),
                                onPressed: () {
                                  tampilDialog(
                                      "Information",
                                      "Kapan terakhir kali anda donor darah ?",
                                      "telp");
                                },
                              ),
                              Text(
                                "Call",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          child: Column(
                            children: <Widget>[
                              IconButton(
                                icon: Icon(Icons.message),
                                onPressed: () {
                                  tampilDialog(
                                      "Information",
                                      "Kapan terakhir kali anda donor darah ?",
                                      "sms");
                                },
                              ),
                              Text(
                                "SMS",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                )
=======
                Text(widget.requestDarahModel.address),
                Center(
                    child: Container(
                  width: 100.0,
                  child: Row(children: <Widget>[
                    Container(
                      child: Column(
                        children: <Widget>[
                          IconButton(
                            icon: Icon(Icons.call),
                            onPressed: () {
                              tampilDialog("Information",
                                  "Kapan terakhir anda donor darah?", "call");
                            },
                          ),
                          Text("Call"),
                        ],
                      ),
                    ),
                    Container(
                      child: Column(
                        children: <Widget>[
                          IconButton(
                            icon: Icon(Icons.sms),
                            onPressed: () {
                              tampilDialog("Information",
                                  "Kapan terakhir anda donor darah?", "sms");
                            },
                          ),
                          Text("SMS"),
                        ],
                      ),
                    ),
                  ]),
                )),
>>>>>>> 6b27894b4e26bcf7bf6b026641288ab07f379657
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
                Text(
<<<<<<< HEAD
                  requestDarahModel.description,
=======
                  widget.requestDarahModel.description,
>>>>>>> 6b27894b4e26bcf7bf6b026641288ab07f379657
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
                  children: listDarah
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
<<<<<<< HEAD
                              selected: requestDarahModel.tipeDarah == pc,
=======
                              selected:
                                  widget.requestDarahModel.tipeDarah == pc,
>>>>>>> 6b27894b4e26bcf7bf6b026641288ab07f379657
                            ),
                          ))
                      .toList(),
                ),
              ],
            ),
          )));
  Widget respondenCard() => Container(
      alignment: Alignment.topRight,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              "Responden",
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(
              height: 5.0,
            ),
            Text(
              widget.requestDarahModel.listResponden == null
                  ? "0"
                  : widget.requestDarahModel.listResponden.length.toString(),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ));
  Widget content() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Stack(
            children: <Widget>[
              identityCard(),
              respondenCard(),
            ],
          ),
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
          // CommonDivider(),
          // SizedBox(
          //   height: 5.0,
          // ),
          // respondenCard(),
          CommonDivider(),
          SizedBox(
            height: 20.0,
          ),
        ],
      );

  void tampilDialog(String tittle, String message, String level) {
    showDialog(
      context: mContext,
<<<<<<< HEAD
      builder: (BuildContext mContext) {
=======
      builder: (BuildContext context) {
>>>>>>> 6b27894b4e26bcf7bf6b026641288ab07f379657
        // return object of type Dialog
        return AlertDialog(
          title: new Text(tittle),
          content: new Text(message),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
<<<<<<< HEAD
              child: new Text("< 8 Minggu"),
              onPressed: () {
                Navigator.of(mContext).pop();
              },
            ),
            new FlatButton(
              child: new Text("> 8 Minggu"),
              onPressed: () {_launchURL(level);},
=======
              child: new Text("<8 Minggu"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            new FlatButton(
              child: new Text(">8 Minggu"),
              onPressed: () {
                _launchURL(level);
              },
>>>>>>> 6b27894b4e26bcf7bf6b026641288ab07f379657
            ),
          ],
        );
      },
    );
  }

  _launchURL(String level) async {
<<<<<<< HEAD
    final String notelp = requestDarahModel.noTelp;
    var url;
    if (level == "telp") {
=======
    var url;
    String notelp = widget.requestDarahModel.noTelp;
    if (level == "call") {
>>>>>>> 6b27894b4e26bcf7bf6b026641288ab07f379657
      url = 'tel:$notelp';
    } else {
      url = 'sms:$notelp';
    }
    if (await canLaunch(url)) {
<<<<<<< HEAD
=======
      inputData();
>>>>>>> 6b27894b4e26bcf7bf6b026641288ab07f379657
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

<<<<<<< HEAD
=======
  inputData() {
    List<dynamic> listResponden;
    if (widget.requestDarahModel.listResponden != null) {
      listResponden =
          new List<dynamic>.from(widget.requestDarahModel.listResponden);
    } else {
      listResponden = new List<dynamic>();
    }
    listResponden.add({"phoneNumber": "$phoneNumber"});
    widget.requestDarahModel.listResponden = listResponden;
    print(widget.requestDarahModel.toJson());
    mainReference
        .child("requestDarah")
        .child(widget.requestDarahModel.id)
        .set(widget.requestDarahModel.toJson()).then((onValue){print("Successful");}).catchError((onError){print(onError);});
  }

>>>>>>> 6b27894b4e26bcf7bf6b026641288ab07f379657
  @override
  Widget build(BuildContext context) {
    this.mContext = context;
    return MaterialApp(
        home: Scaffold(
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[mapsLocation(), content()],
      ),
    ));
  }
}
