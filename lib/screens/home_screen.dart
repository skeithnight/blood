import 'package:flutter/material.dart';
import 'dart:core';
import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:blood/controller/calculate_total_stok_darah.dart' as totalStok;

import 'package:blood/models/stok_darah_model.dart';
import 'package:blood/models/event_model.dart';
import 'items/stok_darah_item.dart';

class HomeScreen extends StatefulWidget {
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  StreamSubscription _subscriptionStokDarah;

  List<StokDarah> listStokDarah = new List();
  List<EventModel> listEvent = new List();

  Widget _getData(context) {
    return FutureBuilder();
    // return StreamBuilder<Event>(
    //     stream: FirebaseDatabase.instance.reference().onValue,
    //     builder: (BuildContext context, snapshot) {
    //       if (snapshot.connectionState == ConnectionState.waiting) {
    //         // _onLoading(context);
    //         // print("FirebaseDatabase: Waiting......");
    //         return new Center(
    //           child: Text("Waiting"),
    //         );
    //       } else {
    //         if (snapshot.hasData) {
    //           listEvent = new List();
    //           listStokDarah = new List();
    //           var map = snapshot.data.snapshot.value;
    //           List<dynamic> mapEvent = map["event"];
    //           List<dynamic> mapStokDarah = map["stokDarah"];
    //           for (var item in mapEvent) {
    //             listEvent.add(new EventModel.fromSnapshot(item));
    //           }
    //           for (var item in mapStokDarah) {
    //             listStokDarah.add(new StokDarah.fromSnapshot(item));
    //           }
    //           return content(context);
    //         }
    //         print("Kosong");
    //         return new Center(
    //           child: Text("kosong"),
    //         );
    //       }
    //     });
  }

  Future<StokDarah> fetchPost() async {
    final response =
        await http.get('https://pmikotabandung.org/api/stok_darah');

    if (response.statusCode == 200) {
      // If the call to the server was successful, parse the JSON
      return StokDarah.fromSnapshot(json.decode(response.body));
    } else {
      // If that call was not successful, throw an error.
      throw Exception('Failed to load post');
    }
  }

  int totalAPos(snapshot) {
    return snapshot.data.WB.a_pos +
        snapshot.data.PRC.a_pos +
        snapshot.data.TC.a_pos +
        snapshot.data.FFP.a_pos +
        snapshot.data.AHF.a_pos +
        snapshot.data.LP.a_pos +
        snapshot.data.WE.a_pos +
        snapshot.data.FP.a_pos +
        snapshot.data.TC_Aferesis.a_pos +
        snapshot.data.BC.a_pos;
  }

  int totalBPos(snapshot) {
    return snapshot.data.WB.b_pos +
        snapshot.data.PRC.b_pos +
        snapshot.data.TC.b_pos +
        snapshot.data.FFP.b_pos +
        snapshot.data.AHF.b_pos +
        snapshot.data.LP.b_pos +
        snapshot.data.WE.b_pos +
        snapshot.data.FP.b_pos +
        snapshot.data.TC_Aferesis.b_pos +
        snapshot.data.BC.b_pos;
  }

  int totalABPos(snapshot) {
    return snapshot.data.WB.ab_pos +
        snapshot.data.PRC.ab_pos +
        snapshot.data.TC.ab_pos +
        snapshot.data.FFP.ab_pos +
        snapshot.data.AHF.ab_pos +
        snapshot.data.LP.ab_pos +
        snapshot.data.WE.ab_pos +
        snapshot.data.FP.ab_pos +
        snapshot.data.TC_Aferesis.ab_pos +
        snapshot.data.BC.ab_pos;
  }

  int totalOPos(snapshot) {
    return snapshot.data.WB.o_pos +
        snapshot.data.PRC.o_pos +
        snapshot.data.TC.o_pos +
        snapshot.data.FFP.o_pos +
        snapshot.data.AHF.o_pos +
        snapshot.data.LP.o_pos +
        snapshot.data.WE.o_pos +
        snapshot.data.FP.o_pos +
        snapshot.data.TC_Aferesis.o_pos +
        snapshot.data.BC.o_pos;
  }

  int totalANeg(snapshot) {
    return snapshot.data.WB.a_neg +
        snapshot.data.PRC.a_neg +
        snapshot.data.TC.a_neg +
        snapshot.data.FFP.a_neg +
        snapshot.data.AHF.a_neg +
        snapshot.data.LP.a_neg +
        snapshot.data.WE.a_neg +
        snapshot.data.FP.a_neg +
        snapshot.data.TC_Aferesis.a_neg +
        snapshot.data.BC.a_neg;
  }

  int totalBNeg(snapshot) {
    return snapshot.data.WB.b_neg +
        snapshot.data.PRC.b_neg +
        snapshot.data.TC.b_neg +
        snapshot.data.FFP.b_neg +
        snapshot.data.AHF.b_neg +
        snapshot.data.LP.b_neg +
        snapshot.data.WE.b_neg +
        snapshot.data.FP.b_neg +
        snapshot.data.TC_Aferesis.b_neg +
        snapshot.data.BC.b_neg;
  }

  int totalABNeg(snapshot) {
    return snapshot.data.WB.ab_neg +
        snapshot.data.PRC.ab_neg +
        snapshot.data.TC.ab_neg +
        snapshot.data.FFP.ab_neg +
        snapshot.data.AHF.ab_neg +
        snapshot.data.LP.ab_neg +
        snapshot.data.WE.ab_neg +
        snapshot.data.FP.ab_neg +
        snapshot.data.TC_Aferesis.ab_neg +
        snapshot.data.BC.ab_neg;
  }

  int totalONeg(snapshot) {
    return snapshot.data.WB.o_neg +
        snapshot.data.PRC.o_neg +
        snapshot.data.TC.o_neg +
        snapshot.data.FFP.o_neg +
        snapshot.data.AHF.o_neg +
        snapshot.data.LP.o_neg +
        snapshot.data.WE.o_neg +
        snapshot.data.FP.o_neg +
        snapshot.data.TC_Aferesis.o_neg +
        snapshot.data.BC.o_neg;
  }

  _golongandarah() {
    return FutureBuilder<StokDarah>(
      future: fetchPost(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Row(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Expanded(
                  flex: 1,
                  child: Column(
                    children: <Widget>[
                      Expanded(
                          flex: 1,
                          child: StokDarahItem("A+", totalAPos(snapshot))),
                      Expanded(
                          flex: 1,
                          child: StokDarahItem("B+", totalBPos(snapshot))),
                      Expanded(
                          flex: 1,
                          child: StokDarahItem("AB+", totalABPos(snapshot))),
                      Expanded(
                          flex: 1,
                          child: StokDarahItem("O+", totalOPos(snapshot))),
                    ],
                  )),
              Expanded(
                  flex: 1,
                  child: Column(
                    children: <Widget>[
                      Expanded(
                        flex: 1,
                        child: InkWell(
                          child: StokDarahItem("A-", totalANeg(snapshot)),
                          onTap: _modalBottomSheet,
                        ),
                      ),
                      Expanded(
                          flex: 1,
                          child: StokDarahItem("B-", totalBNeg(snapshot))),
                      Expanded(
                          flex: 1,
                          child: StokDarahItem("AB-", totalABNeg(snapshot))),
                      Expanded(
                          flex: 1,
                          child: StokDarahItem("O-", totalONeg(snapshot))),
                    ],
                  )),
            ],
          );
          // return StokDarahItem("A+", totalAPos(snapshot));
        } else if (snapshot.hasError) {
          return Text("${snapshot.error}");
        }

        // By default, show a loading spinner
        return CircularProgressIndicator();
      },
    );
  }

  void _modalBottomSheet() {
    showModalBottomSheet(
        context: context,
        builder: (builder) {
          return new Container(
            color: Colors.yellowAccent,
            child: new Center(
              child: new Text("Hey guys !! it is a modal bottom sheet"),
            ),
          );
        });
  }

  _eventDonorDarah() {
    return ListView.builder(
        itemCount: listEvent.length,
        itemBuilder: (BuildContext context, int index) => Card(
              child: ListTile(
                title: Text(listEvent[index].judulAcara),
                subtitle: Text(listEvent[index].tanggal),
              ),
            ));
  }

  Widget content() => Scaffold(
        body: Column(
          children: <Widget>[
            Container(
              child: Card(
                child: Center(
                  child: Container(
                    padding: EdgeInsets.all(20.0),
                    child: Text(
                      "Stok Darah PMI Bandung",
                      style: TextStyle(fontSize: 20.0),
                    ),
                  ),
                ),
              ),
              width: double.infinity,
            ),
            Expanded(
              child: Container(
                width: double.infinity,
                child: _golongandarah(),
              ),
              // child: stokDarahContent(),
              flex: 3,
            ),
            Container(
              child: Card(
                child: Center(
                  child: Container(
                    padding: EdgeInsets.all(20.0),
                    child: Text(
                      "Event Donor Darah",
                      style: TextStyle(fontSize: 20.0),
                    ),
                  ),
                ),
              ),
              width: double.infinity,
            ),
            Expanded(
              child: Container(
                width: double.infinity,
                child: _eventDonorDarah(),
              ),
              // child: eventContent(),
              flex: 3,
            )
          ],
        ),
      );

  @override
  Widget build(BuildContext context) {
    return content();
  }
}
