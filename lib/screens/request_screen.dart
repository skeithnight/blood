import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'dart:async';
import 'dart:convert';
import 'dart:core';

import 'package:blood/models/request_darah_model.dart';
import 'package:blood/screens/request_darah_detail.dart';

class RequestScreen extends StatefulWidget {
  _RequestScreenState createState() => _RequestScreenState();
}

class _RequestScreenState extends State<RequestScreen> {
  List<RequestDarahModel> listRequestDarah;

  Widget _getData(context) {
    return StreamBuilder<Event>(
        stream:
            FirebaseDatabase.instance.reference().child("requestDarah").onValue,
        builder: (BuildContext context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            print("FirebaseDatabase: Waiting......");
            return new Center(
              child: Text("Waiting"),
            );
          } else {
            if (snapshot.hasData) {
              listRequestDarah = new List();
              Map<dynamic, dynamic> map = snapshot.data.snapshot.value;
              List<dynamic> list = map.values.toList();
              List<dynamic> list2 = map.keys.toList();
              for (var i = 0; i < list.length; i++) {
                listRequestDarah
                    .add(new RequestDarahModel.fromData(list[i], list2[i]));
              }
              return content();
            } else {
              print("Kosong");
              return new Center(
                child: Text("kosong"),
              );
            }
          }
        });
  }

  Widget content() {
    return ListView.builder(
        itemCount: listRequestDarah.length,
        itemBuilder: (BuildContext context, int index) => Card(
              elevation: 5.0,
              child: ListTile(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) =>
                          RequestDarahDetailScreen(listRequestDarah[index])));
                },
                leading: CircleAvatar(
                  backgroundColor: Color.fromRGBO(206, 20, 20, 1.0),
                  child: Text(
                    listRequestDarah[index].tipeDarah,
                    style: TextStyle(color: Colors.white, fontSize: 20.0),
                  ),
                ),
                title: Text(listRequestDarah[index].nama),
                subtitle: Text(listRequestDarah[index].address),
              ),
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _getData(context),
    );
  }
}
