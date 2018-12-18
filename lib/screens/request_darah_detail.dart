import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:blood/screens/widgets/common_divided_widget.dart';
import 'package:blood/data.dart' as data;
import 'package:blood/models/request_darah_model.dart';

import 'main_screen.dart';

class RequestDarahDetailScreen extends StatelessWidget {
  final RequestDarahModel requestDarahModel;
  RequestDarahDetailScreen(this.requestDarahModel);
  List<String> listDarah = ["A+", "A-", "B+", "B-", "0+", "0-", "AB+", "AB-"];
  BuildContext mContext;

  Widget mapsLocation() => Container(
        width: double.infinity,
        height: 300.0,
        child: new FlutterMap(
          options: new MapOptions(
            center: new LatLng(
                requestDarahModel.latitude, requestDarahModel.longitude),
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
                  point: new LatLng(
                      requestDarahModel.latitude, requestDarahModel.longitude),
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
                Text(requestDarahModel.nama),
                // Text("Phone Number", style: TextStyle( fontWeight: FontWeight.bold),),
                // Text( requestDarahModel.noTelp),
                Text(
                  "Address",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
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
                  requestDarahModel.description,
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
                              selected: requestDarahModel.tipeDarah == pc,
                            ),
                          ))
                      .toList(),
                ),
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
            height: 20.0,
          ),
        ],
      );

  void tampilDialog(String tittle, String message, String level) {
    showDialog(
      context: mContext,
      builder: (BuildContext mContext) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text(tittle),
          content: new Text(message),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("< 8 Minggu"),
              onPressed: () {
                Navigator.of(mContext).pop();
              },
            ),
            new FlatButton(
              child: new Text("> 8 Minggu"),
              onPressed: () {_launchURL(level);},
            ),
          ],
        );
      },
    );
  }

  _launchURL(String level) async {
    final String notelp = requestDarahModel.noTelp;
    var url;
    if (level == "telp") {
      url = 'tel:$notelp';
    } else {
      url = 'sms:$notelp';
    }
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

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
