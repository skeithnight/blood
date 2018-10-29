import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'dart:async';
import 'dart:convert';
import 'dart:core';

import 'package:blood/models/stok_darah_model.dart';
import 'package:blood/screens/stok_darah_item.dart';
import 'package:blood/models/event_model.dart';

class HomeScreen extends StatefulWidget {
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  StreamSubscription _subscriptionStokDarah;
  
  List<StokDarah> listStokDarah = new List();
  List<EventModel> listEvent = new List();

  Widget _getStokDarah(context) {
    return StreamBuilder<Event>(
        stream: FirebaseDatabase.instance.reference().onValue,
        builder: (BuildContext context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            print("FirebaseDatabase: Waiting......");
            return new Center(
              child: Text("Waiting"),
            );
          } else {
            if (snapshot.hasData) {
              var map = snapshot.data.snapshot.value;
              List<dynamic> mapEvent = map["event"];
              List<dynamic> mapStokDarah = map["stokDarah"];
              for (var item in mapEvent) {
                listEvent.add(new EventModel.fromSnapshot(item));
              }
              for (var item in mapStokDarah) {
                listStokDarah.add(new StokDarah.fromSnapshot(item));
              }
              return content(context);
            }
            print("Kosong");
            return new Center(
              child: Text("kosong"),
            );
            // return new LoginScreen();
          }
        });
  }

  _golongandarah() {
    if (listStokDarah != null) {
      print(listStokDarah.length);
      List<StokDarah> stokDarahGenap = new List();
      List<StokDarah> stokDarahGanjil = new List();
      for (var i = 0; i < listStokDarah.length; i++) {
        if (i.isOdd) {
          stokDarahGanjil.add(listStokDarah[i]);
        } else {
          stokDarahGenap.add(listStokDarah[i]);
        }
      }

      // return Text("aa");
      return Row(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Expanded(
            flex: 1,
            child: ListView.builder(
              itemCount: stokDarahGenap.length,
              itemBuilder: (BuildContext context, int index) =>
                  StokDarahItem(stokDarahGenap[index]),
            ),
          ),
          Expanded(
              flex: 1,
              child: ListView.builder(
                itemCount: stokDarahGanjil.length,
                itemBuilder: (BuildContext context, int index) =>
                    StokDarahItem(stokDarahGanjil[index]),
              ))
        ],
      );
    } else {
      return Text("kosong");
    }
  }

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
        child: _golongandarah(),
      );
  Widget eventContent() => Container();

  Widget content(context) => Scaffold(
        body: Column(
          children: <Widget>[
            Expanded(
              child: userContent(),
              flex: 1,
            ),
            Expanded(
              child: stokDarahContent(),
              flex: 2,
            ),
            Expanded(
              child: eventContent(),
              flex: 3,
            )
          ],
        ),
        // body: SingleChildScrollView(
        //   padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
        //   child: Column(
        //     children: <Widget>[
        //       userContent(),
        //       stokDarahContent(),
        //       eventContent()
        //     ],
        //   ),
        // ),
      );

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      color: Colors.grey,
      home: _getStokDarah(context),
    );
  }
}
