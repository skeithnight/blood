import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:geolocator/geolocator.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import 'package:blood/screens/widgets/common_divided_widget.dart';
import 'package:blood/data.dart' as data;
import 'package:http/http.dart' as http;
import 'package:blood/models/request_darah_model.dart';
import 'package:blood/screens/request_darah_detail.dart';

import 'main_screen.dart';

class RequestDarahScreen extends StatefulWidget {
  _RequestDarahScreenState createState() => _RequestDarahScreenState();
}

class _RequestDarahScreenState extends State<RequestDarahScreen> {
  RequestDarahModel requestDarahModel = new RequestDarahModel();
  final mainReference = FirebaseDatabase.instance.reference();
  // String _value = "A+";
  List<String> listDarah = ["A+", "A-", "B+", "B-","O+","O-","AB+","AB-"];

  // Firebase messaging
  FirebaseMessaging _firebaseMessaging = new FirebaseMessaging();

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
    if (requestDarahModel.latitude == null) {
      return RaisedButton(
        child: Text("Location"),
        color: Colors.blue,
        textColor: Colors.white,
        elevation: 7.0,
        onPressed: () {
          print(requestDarahModel.latitude);
          requestDarahModel.latitude = -6.898356;
          requestDarahModel.longitude = 107.621707;
        },
      );
    } else {
      return Text(requestDarahModel.latitude.toString() +
          " , " +
          requestDarahModel.longitude.toString());
    }
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
                Container(
                  width: double.infinity,
                  margin: EdgeInsets.all(10.0),
                  child: lokasiDonor(),
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
        child: RaisedButton(
          child: Text("Request"),
          color: Colors.blue,
          textColor: Colors.white,
          elevation: 7.0,
          onPressed: () {
            print(json.encode(requestDarahModel));
            pushNotif("adaada");
            // inputData();
          },
        ),
      );

  inputData() {
    mainReference
        .child("requestDarah")
        .push()
        .set(requestDarahModel.toJson())
        .then(pushNotif)
        .catchError((onError) => _showDialog(onError));
  }

  void pushNotif(String cc){
    // var fcmToken = "fWf8dBG4SIw:APA91bFpHMG8TSowERG-eHSRROg6tZujuBZj-1rcsX6q5tN35hhKHJgZjVjGaH_AK29g_9JXZV_qxzcpU3pGlpbq9hcVL2W5B9BTZFplqMLDo55MnOMaHyb1tlJx9o7cchVaLlwqpHol";
    var fcmToken = "/topics/requestDarah";
    String aa = requestDarahModel.address;
    String bb = json.encode(requestDarahModel);
    // print(requestDarahModel.toString());
    var data1 = '{"to": "$fcmToken","notification": {"title": "Donorkan darah anda","body": "$aa"},"priority": "high", "data": {"click_action": "FLUTTER_NOTIFICATION_CLICK", "body":$bb}}';
        // '{"notification": {"body": "this is a body","title": "this is a title"}, "priority": "high", "data": {"click_action": "FLUTTER_NOTIFICATION_CLICK", "id": "1", "status": "done"}, "to": "$fcmToken"}';
    var url = "https://fcm.googleapis.com/fcm/send";
    http.post(url, body: data1, headers: {
      "Authorization": "key=${data.fcmServerKey}",
      "Content-Type": "application/json"
    }).then(_showDialog);
  }
// (response) {
//   print("Response status: ${response.statusCode}");
//   print("Response body: ${response.body}");
// }
  void _showDialog(data) {
    // flutter defined function
    // Map map = data;
    // print(data['statusCode']);
    showDialog(
      // barrierDismissible: false,
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
  void initState() {
    // TODO: implement initState
    super.initState();
    // Firebase messaging
    _firebaseMessaging.configure(
      onMessage: (Map<dynamic, dynamic> message) {
        // var aa = message['status']
        // RequestDarahModel ac = new RequestDarahModel.fromSnapshot(message['data']['body']);
        // print('adada : '+json.encode(ac));
        // _showDialog(message);
        RequestDarahModel ac = new RequestDarahModel.fromSnapshot(json.decode(message['data']['body']));
        print('adada : '+json.encode(message['data']['body']));
        print('ddddd : '+json.encode(ac));
        Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => RequestDarahDetailScreen(ac)));
      },
      onResume: (Map<String, dynamic> message) {
        print('on resume $message');
        // _showDialog(message);
      },
      onLaunch: (Map<String, dynamic> message) {
        print('on launch $message');
        // _showDialog(message);
      },
    );
    _firebaseMessaging.requestNotificationPermissions(
        const IosNotificationSettings(sound: true, badge: true, alert: true));
    _firebaseMessaging.getToken().then((token) {
      print("adada : $token");
    });
  }

  @override
  Widget build(BuildContext context) {
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
  }
}

// class RequestDarahScreen extends StatelessWidget {

//   String _sizeValue = "M";
//   getPosition() async {
//     // FlutterPlacesDialog.setGoogleApiKey(data.apiKey);
//     // var place = await FlutterPlacesDialog.getPlacesDialog();
//   }

//   // Widget
// Widget listDarahCard() => Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: <Widget>[
//           Text(
//             "Sizes",
//             style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20.0),
//           ),
//           SizedBox(
//             height: 10.0,
//           ),
//           Wrap(
//             alignment: WrapAlignment.spaceEvenly,
//             children: widget.product.sizes
//                 .map((pc) => Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: ChoiceChip(
//                           selectedColor: Colors.yellow,
//                           label: Text(
//                             pc,
//                             style: TextStyle(fontWeight: FontWeight.bold),
//                           ),
//                           selected: _sizeValue == pc,
//                           onSelected: (selected) {
//                             setState(() {
//                               _sizeValue = selected ? pc : null;
//                             });
//                           }),
//                     ))
//                 .toList(),
//           ),
//         ],
//       );

//   Widget content() => Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: <Widget>[
//         listDarahCard(),
//         CommonDivider(),
//         SizedBox(
//           height: 5.0,
//         ),
//         // sizesCard(),
//         // CommonDivider(),
//         // SizedBox(
//         //   height: 5.0,
//         // ),
//         // quantityCard(),
//         // SizedBox(
//         //   height: 20.0,
//         // ),
//       ],
//     );

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar( title: Text("Request Darah"),),
//         body: content());
//   }
// }

// main() {
//   MapView.setApiKey(data.apiKey);
//   runApp(RequestDarahScreen());
// }

// class RequestDarahScreen extends StatefulWidget {
//   _RequestDarahScreenState createState() => _RequestDarahScreenState();
// }

// class _RequestDarahScreenState extends State<RequestDarahScreen> {
//   MapView mapView = new MapView();

//   displayMap() {
//     MapOptions mapOptions = MapOptions(
//         title: 'Lokasi Donor',
//         showMyLocationButton: true,
//         showUserLocation: true,
//         mapViewType: MapViewType.normal,
//         initialCameraPosition: CameraPosition(Location(355.55, -101.2), 5.0));
//     mapView.show(mapOptions);
//   }

//   @override
//   Widget build(BuildContext context) {
//     Scaffold(
//       appBar: AppBar(
//         title: Text('Geolocation'),
//       ),
//       body: Center(
//         child: Container(
//           child: RaisedButton(
//             child: Text("Lokasi donor"),
//             color: Colors.blue,
//             textColor: Colors.white,
//             elevation: 7.0,
//             onPressed: displayMap(),
//           ),
//         ),
//       ),
//     );
//   }
// }
