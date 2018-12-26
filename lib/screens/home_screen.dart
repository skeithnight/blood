import 'package:flutter/material.dart';
import 'dart:core';
import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:blood/controller/calculate_total_stok_darah.dart' as totalStok;
import 'widgets/common_divided_widget.dart';

import 'package:blood/models/stok_darah_model.dart';
import 'package:blood/models/event_model.dart';
import 'items/stok_darah_item.dart';
import 'items/detail_stok_darah_item.dart';
import 'package:blood/models/event_model.dart';

class HomeScreen extends StatefulWidget {
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  StreamSubscription _subscriptionStokDarah;

  List<StokDarah> listStokDarah = new List();
  List<EventModel> listEvent = new List();

// Stok Darah
  Future<StokDarah> fetchGetStokDarah() async {
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
      future: fetchGetStokDarah(),
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
                          child: InkWell(
                            child: StokDarahItem("A+", totalAPos(snapshot)),
                            onTap: () {
                              _modalBottomSheet(snapshot.data, "A+");
                            },
                          )),
                      Expanded(
                          flex: 1,
                          child: InkWell(
                            child: StokDarahItem("B+", totalBPos(snapshot)),
                            onTap: () {
                              _modalBottomSheet(snapshot.data, "B+");
                            },
                          )),
                      Expanded(
                          flex: 1,
                          child: InkWell(
                            child: StokDarahItem("AB+", totalABPos(snapshot)),
                            onTap: () {
                              _modalBottomSheet(snapshot.data, "AB+");
                            },
                          )),
                      Expanded(
                          flex: 1,
                          child: InkWell(
                            child: StokDarahItem("O+", totalOPos(snapshot)),
                            onTap: () {
                              _modalBottomSheet(snapshot.data, "O+");
                            },
                          )),
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
                          onTap: () {
                            _modalBottomSheet(snapshot.data, "A-");
                          },
                        ),
                      ),
                      Expanded(
                          flex: 1,
                          child: InkWell(
                            child: StokDarahItem("B-", totalBNeg(snapshot)),
                            onTap: () {
                              _modalBottomSheet(snapshot.data, "B-");
                            },
                          )),
                      Expanded(
                          flex: 1,
                          child: InkWell(
                            child: StokDarahItem("AB-", totalABNeg(snapshot)),
                            onTap: () {
                              _modalBottomSheet(snapshot.data, "AB-");
                            },
                          )),
                      Expanded(
                          flex: 1,
                          child: InkWell(
                            child: StokDarahItem("O-", totalONeg(snapshot)),
                            onTap: () {
                              _modalBottomSheet(snapshot.data, "O-");
                            },
                          )),
                    ],
                  )),
            ],
          );
          // return StokDarahItem("A+", totalAPos(snapshot));
        } else if (snapshot.hasError) {
          return Text("${snapshot.error}");
        }

        // By default, show a loading spinner
        return Center(child: CircularProgressIndicator());
      },
    );
  }

  void _modalBottomSheet(StokDarah snapshot, String golDar) {
    showModalBottomSheet(
        context: context,
        builder: (builder) {
          return new Container(
            child: Row(mainAxisSize: MainAxisSize.max, children: <Widget>[
              Expanded(
                  flex: 1,
                  child: Column(children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: DetailStokDarahItem("WB", golDar, snapshot.WB),
                    ),
                    Expanded(
                      flex: 1,
                      child: DetailStokDarahItem("WE", golDar, snapshot.WE),
                    ),
                    Expanded(
                      flex: 1,
                      child: DetailStokDarahItem("AHF", golDar, snapshot.AHF),
                    ),
                    Expanded(
                      flex: 1,
                      child: DetailStokDarahItem("BC", golDar, snapshot.BC),
                    ),
                    Expanded(
                      flex: 1,
                      child: DetailStokDarahItem("FFP", golDar, snapshot.FFP),
                    ),
                  ])),
              Expanded(
                  flex: 1,
                  child: Column(children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: DetailStokDarahItem("TC", golDar, snapshot.TC),
                    ),
                    Expanded(
                      flex: 1,
                      child: DetailStokDarahItem(
                          "TC Aferesis", golDar, snapshot.TC_Aferesis),
                    ),
                    Expanded(
                      flex: 1,
                      child: DetailStokDarahItem("PRD", golDar, snapshot.PRC),
                    ),
                    Expanded(
                      flex: 1,
                      child: DetailStokDarahItem("FP", golDar, snapshot.FP),
                    ),
                    Expanded(
                      flex: 1,
                      child: DetailStokDarahItem("LP", golDar, snapshot.LP),
                    ),
                  ]))
            ]),
          );
        });
  }

// Event
  Future<EventModel> fetchPostEvent() async {
    String url = "https://pmikotabandung.org/jadwal/get_data_jadwal_pencarian";
    final response = await http.post(url,
        headers: {"Content-Type": "application/x-www-form-urlencoded"},
        encoding: Encoding.getByName("utf8"),
        body: "draw=1&start=0&length=100");

    if (response.statusCode == 200) {
      // If the call to the server was successful, parse the JSON
      try {
        Map<String, dynamic> map = json.decode(response.body);
        return EventModel.fromSnapshot(map);
      } catch (e) {
        print("gagal: " + e.toString());
      }
    } else {
      // If that call was not successful, throw an error.
      throw Exception('Failed to load post');
    }
  }

  _eventDonorDarah() {
    return FutureBuilder<EventModel>(
        future: fetchPostEvent(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            print(json.encode(snapshot.data.data));
            return ListView.builder(
                itemCount: snapshot.data.data.length,
                itemBuilder: (BuildContext context, int index) => Card(
                      child: ListTile(
                        onTap: () {
                          _modalEventBottomSheet(snapshot.data.data[index]);
                        },
                        title: Text(snapshot.data.data[index][1]),
                        subtitle: Text(snapshot.data.data[index][2]),
                      ),
                    ));
          } else if (snapshot.hasError) {
            return Text("${snapshot.error}");
          }
          // By default, show a loading spinner
          return Center(child: CircularProgressIndicator());
        });
  }

  void _modalEventBottomSheet(List<dynamic> data) {
    showModalBottomSheet(
        context: context,
        builder: (builder) {
          return new Container(
            padding: EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text("Tanggal & Waktu", style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold)),
                CommonDivider(),
                SizedBox(
                  height: 5.0,
                ),
                Text(data[1]+", "+data[3]),
                CommonDivider(),
                SizedBox(
                  height: 5.0,
                ),
                Text("Lokasi Event", style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold)),
                CommonDivider(),
                SizedBox(
                  height: 5.0,
                ),
                Text(data[2]+", "+data[4]),
                CommonDivider(),
                SizedBox(
                  height: 5.0,
                ),
                Text("Target Pendonor", style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold)),
                CommonDivider(),
                SizedBox(
                  height: 5.0,
                ),
                Text(data[5]+" Orang"),
                CommonDivider(),
                SizedBox(
                  height: 20.0,
                ),
              ],
            ),
          );
        });
  }

// main menu
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
