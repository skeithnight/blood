import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:map_view/map_view.dart';

import 'package:blood/data.dart' as data;

class RequestDarahScreen extends StatefulWidget {
  _RequestDarahScreenState createState() => _RequestDarahScreenState();
}

class _RequestDarahScreenState extends State<RequestDarahScreen> {
  MapView mapView = new MapView();

  displayMap() {
    MapOptions mapOptions = new MapOptions(
        mapViewType: MapViewType.normal,
        initialCameraPosition: CameraPosition(Location(35.22, -101.83), 15.0), showMyLocationButton: true, showUserLocation: true, title: 'Lokasi permintaan');
    mapView.show(mapOptions);
  }

  Widget content() => new Scaffold(
        appBar: AppBar(
          title: Text("Request Darah"),
        ),
        body: Center(
          child: Container(
            child: RaisedButton(
              child: Text("Tap me"),
              color: Colors.blue,
              textColor: Colors.white,
              elevation: 7.0,
              onPressed: displayMap(),
            ),
          ),
        ),
      );
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: content(),
    );
  }
}
