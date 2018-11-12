import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';
import 'package:firebase_database/firebase_database.dart';

import 'package:blood/screens/widgets/common_divided_widget.dart';
import 'package:blood/data.dart' as data;
import 'package:blood/models/request_darah_model.dart';

import 'main_screen.dart';

class RequestDarahDetailScreen extends StatelessWidget {
  final RequestDarahModel requestDarahModel;
  RequestDarahDetailScreen(this.requestDarahModel);
  List<String> listDarah = ["A+", "A-", "B+", "B-"];
  Widget mapsLocation() => Container(
        width: double.infinity,
        height: 300.0,
        child: new FlutterMap(
          options: new MapOptions(
            center: new LatLng(requestDarahModel.latitude, requestDarahModel.longitude),
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
                  point: new LatLng(requestDarahModel.latitude, requestDarahModel.longitude),
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
                Text("Name", style: TextStyle( fontWeight: FontWeight.bold),),
                Text( requestDarahModel.nama),
                Text("Phone Number", style: TextStyle( fontWeight: FontWeight.bold),),
                Text( requestDarahModel.noTelp),
                Text("Address", style: TextStyle( fontWeight: FontWeight.bold),),
                Text( requestDarahModel.address),
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
                Text(requestDarahModel.description,)
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
                                selected: requestDarahModel.tipeDarah == pc,),
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[mapsLocation(), content()],
      ),
    );
  }
}
// class RequestDarahDetailScreen extends StatefulWidget {
//   final RequestDarahModel data;
//   RequestDarahDetailScreen( this.data);
//   _RequestDarahDetailScreenState createState() => _RequestDarahDetailScreenState(data);
// }

// class _RequestDarahDetailScreenState extends State<RequestDarahDetailScreen> {
//   RequestDarahModel requestDarahModel = new RequestDarahModel();
//   _RequestDarahDetailScreenState(this.requestDarahModel);

//   final mainReference = FirebaseDatabase.instance.reference();
//   // String _value = "A+";
//   List<String> listDarah = ["A+", "A-", "B+", "B-"];
//   Widget identityCard() => Container(
//       width: double.infinity,
//       child: Card(
//           elevation: 10.0,
//           child: Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: <Widget>[
//                 Text(
//                   "Identity",
//                   style: TextStyle(
//                     fontSize: 20.0,
//                     fontWeight: FontWeight.w700,
//                   ),
//                 ),
//                 SizedBox(
//                   height: 5.0,
//                 ),
//                 TextField(
//                   keyboardType: TextInputType.text,
//                   style: TextStyle(color: Colors.black),
//                   onChanged: (out) => requestDarahModel.nama = out,
//                   decoration: InputDecoration(
//                     labelStyle: TextStyle(
//                       fontWeight: FontWeight.bold,
//                     ),
//                     labelText: "Name",
//                   ),
//                 ),
//                 TextField(
//                   keyboardType: TextInputType.number,
//                   style: TextStyle(color: Colors.black),
//                   onChanged: (out) => requestDarahModel.noTelp = out,
//                   decoration: InputDecoration(
//                     labelStyle: TextStyle(
//                       fontWeight: FontWeight.bold,
//                     ),
//                     labelText: "Phone Number",
//                   ),
//                 ),
//               ],
//             ),
//           )));
//   Widget descriptionCard() => Container(
//       width: double.infinity,
//       child: Card(
//           elevation: 10.0,
//           child: Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: <Widget>[
//                 Text(
//                   "Description",
//                   style: TextStyle(
//                     fontSize: 20.0,
//                     fontWeight: FontWeight.w700,
//                   ),
//                 ),
//                 SizedBox(
//                   height: 5.0,
//                 ),
//                 Text(requestDarahModel.description,)
//               ],
//             ),
//           )));
//   Widget listDarahCard() => Container(
//       width: double.infinity,
//       child: Card(
//           elevation: 10.0,
//           child: Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: <Widget>[
//                 Text(
//                   "Blood type",
//                   style: TextStyle(
//                     fontSize: 20.0,
//                     fontWeight: FontWeight.w700,
//                   ),
//                 ),
//                 SizedBox(
//                   height: 5.0,
//                 ),
//                 Wrap(
//                   alignment: WrapAlignment.spaceBetween,
//                   children: listDarah
//                       .map((pc) => Padding(
//                             padding: const EdgeInsets.all(8.0),
//                             child: ChoiceChip(
//                                 selectedColor: Colors.yellow,
//                                 label: Text(
//                                   pc,
//                                   style: TextStyle(
//                                     fontWeight: FontWeight.bold,
//                                   ),
//                                 ),
//                                 selected: requestDarahModel.tipeDarah == pc,),
//                           ))
//                       .toList(),
//                 ),
//               ],
//             ),
//           )));
//   lokasiDonor() {
//     // return Text(requestDarahModel.latitude.toString()+" : "+requestDarahModel.longitude.toString());
//     return new FlutterMap(
//       options: new MapOptions(
//         center: new LatLng(requestDarahModel.latitude,requestDarahModel.longitude),
//         zoom: 13.0,
//       ),
//       layers: [
//         new TileLayerOptions(
//           urlTemplate: "https://api.tiles.mapbox.com/v4/"
//               "{id}/{z}/{x}/{y}@2x.png?access_token={accessToken}",
//           additionalOptions: {
//             'accessToken': 'pk.eyJ1Ijoic2tlaXRobmlnaHQiLCJhIjoiY2pvYWw5aGYwMGxnazNybGMxZ3B0ZWc3aiJ9.g5ybUMKi4nGoYGFQdly1-A',
//             'id': 'mapbox.streets',
//           },
//         ),
//         new MarkerLayerOptions(
//           markers: [
//             new Marker(
//               width: 80.0,
//               height: 80.0,
//               point: new LatLng(requestDarahModel.latitude,requestDarahModel.longitude),
//               builder: (ctx) =>
//               new Container(
//                 child: Icon(Icons.place),
//               ),
//             ),
//           ],
//         ),
//       ],
//     );
//   }

//   Widget locationCard() => Container(
//       width: double.infinity,
//       child: Card(
//           elevation: 10.0,
//           child: Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: <Widget>[
//                 Text(
//                   "Location",
//                   style: TextStyle(
//                     fontSize: 20.0,
//                     fontWeight: FontWeight.w700,
//                   ),
//                 ),
//                 SizedBox(
//                   height: 5.0,
//                 ),
//                 Container(
//                   margin: EdgeInsets.all(10.0),
//                   child: lokasiDonor(),
//                 ),
//                 SizedBox(
//                   height: 5.0,
//                 ),
//                 TextField(
//                   decoration: InputDecoration(
//                     labelStyle: TextStyle(
//                       fontWeight: FontWeight.bold,
//                     ),
//                     labelText: "Address",
//                   ),
//                   onChanged: (out) => requestDarahModel.address = out,
//                   keyboardType: TextInputType.multiline,
//                   maxLines: 3,
//                 )
//               ],
//             ),
//           )));
//   Widget content() => Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: <Widget>[
//           identityCard(),
//           CommonDivider(),
//           SizedBox(
//             height: 5.0,
//           ),
//           descriptionCard(),
//           CommonDivider(),
//           SizedBox(
//             height: 5.0,
//           ),
//           listDarahCard(),
//           CommonDivider(),
//           SizedBox(
//             height: 5.0,
//           ),
//           locationCard(),
//           CommonDivider(),
//           SizedBox(
//             height: 20.0,
//           ),
//         ],
//       );
//   Widget bottomButton() => Container(
//         width: double.infinity,
//         margin: EdgeInsets.all(10.0),
//         child: RaisedButton(
//           child: Text("Request"),
//           color: Colors.blue,
//           textColor: Colors.white,
//           elevation: 7.0,
//           onPressed: () {
//             print(json.encode(requestDarahModel));
//             inputData();
//           },
//         ),
//       );
//   inputData() {
//     mainReference
//         .child("requestDarah")
//         .push()
//         .set(requestDarahModel.toJson())
//         .then(_showDialog)
//         .catchError((onError) => _showDialog(onError));
//   }

//   void _showDialog(data) {
//     // flutter defined function
//     showDialog(
//       barrierDismissible: false,
//       context: context,
//       builder: (BuildContext context) {
//         // return object of type Dialog
//         return AlertDialog(
//           title: new Text("Success"),
//           content: new Text(
//               "Your request has been broadcast to all member, please wait and hope.."),
//           actions: <Widget>[
//             // usually buttons at the bottom of the dialog
//             new FlatButton(
//               child: new Text("Close"),
//               onPressed: () {
//                 Navigator.of(context).pushReplacement(
//                     MaterialPageRoute(builder: (context) => MainScreen()));
//               },
//             ),
//           ],
//         );
//       },
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           title: Text("Request Darah"),
//         ),
//         body: SingleChildScrollView(
//             child: Padding(
//           padding: EdgeInsets.all(20.0),
//           child: Center(
//             child: content(),
//           ),
//         )));
//   }
// }
