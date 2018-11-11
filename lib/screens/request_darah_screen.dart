// import 'package:flutter/material.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:blood/screens/widgets/common_divided_widget.dart';

// import 'package:blood/data.dart' as data;

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

// // main() {
// //   MapView.setApiKey(data.apiKey);
// //   runApp(RequestDarahScreen());
// // }

// // class RequestDarahScreen extends StatefulWidget {
// //   _RequestDarahScreenState createState() => _RequestDarahScreenState();
// // }

// // class _RequestDarahScreenState extends State<RequestDarahScreen> {
// //   MapView mapView = new MapView();

// //   displayMap() {
// //     MapOptions mapOptions = MapOptions(
// //         title: 'Lokasi Donor',
// //         showMyLocationButton: true,
// //         showUserLocation: true,
// //         mapViewType: MapViewType.normal,
// //         initialCameraPosition: CameraPosition(Location(355.55, -101.2), 5.0));
// //     mapView.show(mapOptions);
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     Scaffold(
// //       appBar: AppBar(
// //         title: Text('Geolocation'),
// //       ),
// //       body: Center(
// //         child: Container(
// //           child: RaisedButton(
// //             child: Text("Lokasi donor"),
// //             color: Colors.blue,
// //             textColor: Colors.white,
// //             elevation: 7.0,
// //             onPressed: displayMap(),
// //           ),
// //         ),
// //       ),
// //     );
// //   }
// // }
