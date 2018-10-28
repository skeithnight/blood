import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'dart:async';

import 'package:blood/controller/stok_darah_controller.dart';
import 'package:blood/models/stok_darah_model.dart';

class HomeScreen extends StatefulWidget {
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  StreamSubscription _subscriptionStokDarah;
  List<String> goldDarah = ['A+', 'A-'];
  List<StokDarah> listStokDarah = new List();

  void initState() {
    for (var i = 0; i < goldDarah.length; i++) {
      StokDarahController.getStokDarahStream(goldDarah[i], _updateStokDarah)
          .then((StreamSubscription s) => _subscriptionStokDarah = s);
    }
    super.initState();
  }

  @override
  void dispose() {
    if (_subscriptionStokDarah != null) {
      _subscriptionStokDarah.cancel();
    }
    super.dispose();
  }

  _updateStokDarah(StokDarah data) {
    listStokDarah.add(data);
    print(listStokDarah.length.toString());
    for (var stokDarah in listStokDarah) {
      print("StokDarah => " +
          stokDarah.key +
          " : " +
          stokDarah.jumlah.toString());
    }
  }
  // final notesReference = FirebaseDatabase.instance.reference().child('notes');
  // void _writeData() {
  //   notesReference.push().set({
  //     'title': 'grokonez.com',
  //     'description': 'Programming Tutorials'
  //   }).then((_) {
  //     // ...
  //     print("write data");
  //   }).catchError((e) {
  //     print(e);
  //   });
  // }

  Widget userContent() => Container(
        width: double.infinity,
        height: 100.0,
        // margin: EdgeInsets.all(10.0),
        child: Card(
          child: Row(
            children: <Widget>[
              Expanded(
                flex: 2,
                child: Column(
                  children: <Widget>[
                    Text("nama lengkap"),
                    Text("Nomer Telepon")
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: Column(
                  children: <Widget>[Text("A+"), Text("Golongan Darah")],
                ),
              )
            ],
          ),
        ),
      );
  Widget stokDarahContent() => Container(
        width: double.infinity,
        child: Card(
          child: Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(10.0),
                child: Text("Stok Darah"),
              ),
              Row(
                children: <Widget>[
                  // ListTile(
                  //   leading: Text(listStokDarah[0].key),
                  //   title: Text(listStokDarah[0].jumlah.toString()),
                  // )
                ],
              )
              // listStokDarah(),
            ],
          ),
        ),
      );
  Widget eventContent() => Container();

  Widget content() => Scaffold(
        body: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
          child: Column(
            children: <Widget>[
              userContent(),
              stokDarahContent(),
              eventContent()
            ],
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      color: Colors.grey,
      home: content(),
    );
  }
}
