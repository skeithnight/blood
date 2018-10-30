import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'dart:async';
import 'dart:convert';
import 'dart:core';

import 'package:blood/models/event_model.dart';

class RequestScreen extends StatefulWidget {
  _RequestScreenState createState() => _RequestScreenState();
}

class _RequestScreenState extends State<RequestScreen> {

  Widget _getData(context) {

    List<EventModel> listEventModel;
    
    return StreamBuilder<Event>(
        stream: FirebaseDatabase.instance.reference().child("requestDarah").onValue,
        builder: (BuildContext context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            print("FirebaseDatabase: Waiting......");
            return new Center(
              child: Text("Waiting"),
            );
          } else {
            if (snapshot.hasData) {
              listEventModel = new List();
              List<EventModel> map = snapshot.data.snapshot.value;
                            
              print("Request: "+ json.encode(map) +" : ");
              return Text("Request: "+ json.encode(map));
            }
            print("Kosong");
            return new Center(
              child: Text("kosong"),
            );
          }
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar( 
            title: TabBar(
              tabs: [
                Tab( text: "Pencari Donor",),
                Tab( text: "Permintaan Darah"),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              _getData(context),
              Icon(Icons.directions_transit),
            ],
          ),
        ),
      ),
    );
  }
}