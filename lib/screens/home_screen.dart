import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'dart:async';
import 'dart:convert';

import 'package:blood/models/stok_darah_model.dart';

class HomeScreen extends StatefulWidget {
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  StreamSubscription _subscriptionStokDarah;
  List<String> goldDarah = ['A+', 'A-'];
  List<StokDarah> listStokDarah = new List();

  Widget _getStokDarah(context) {
    return StreamBuilder<Event>(
        stream: FirebaseDatabase.instance.reference().child("stokDarah").onValue,
        builder: (BuildContext context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            print("FirebaseDatabase: Waiting......");
            // return Navigator.of(context).pushNamed('/');
            return new Center( child: Text("Waiting"),);
          } else {
            if (snapshot.hasData) {
              // List<Map<String,dynamic>> map = json.decode(snapshot.data.snapshot.value).toString() ;
              List<dynamic> map = snapshot.data.snapshot.value;
              for (var item in map) {
                listStokDarah.add(new StokDarah.fromSnapshot(item));
              }
              print(listStokDarah[0].golonganDarah);
              // print("GetStokDarah: "+map.length.toString() +" : "+map[0].toString());
              // print(json.decode(snapshot.data.snapshot.value));
              // String jsoncode = json.decode( snapshot.data.snapshot.value.toString());
              // Map jsoncode = json.decode(snapshot.data.snapshot.toStringS());
              // print("FirebaseDatabase : "+ jsoncode.toString()+" : ");
              // return new MainScreen();
              // return new MainScreen(firestore: firestore,
              //     uuid: snapshot.data.uid);
              return content();
            }
            print("Kosong");
            return new Center( child: Text("kosong"),);
            // return new LoginScreen();
          }
        });
  }

  // void initState() {
  //   FirebaseDatabase.instance.reference().child("stokDarah").onValue;
  //   // for (var i = 0; i < goldDarah.length; i++) {
  //   //   // StokDarahController.getStokDarahStream(goldDarah[i], _updateStokDarah)
  //   //   //     .then((StreamSubscription s) => _subscriptionStokDarah = s);
  //   // }
  //   super.initState();
  // }

  // @override
  // void dispose() {
  //   if (_subscriptionStokDarah != null) {
  //     _subscriptionStokDarah.cancel();
  //   }
  //   super.dispose();
  // }

  // _updateStokDarah(StokDarah data) {
  //   listStokDarah.add(data);
  //   print(listStokDarah.length.toString());
  //   for (var stokDarah in listStokDarah) {
  //     print("StokDarah => " +
  //         stokDarah.key +
  //         " : " +
  //         stokDarah.jumlah.toString());
  //   }
  // }

  _golongandarah() {
    if (listStokDarah != null) {
      print(listStokDarah.length);
      for (var stokDarah in listStokDarah) {
        
      return Text(stokDarah.golonganDarah);
        // return ListTile(
        //   leading: CircleAvatar(
        //     backgroundColor: Colors.red,
        //     child: Text(
        //       stokDarah.key,
        //       style: TextStyle(color: Colors.white),
        //     ),
        //   ),
        //   title: Text(stokDarah.jumlah.toString()),
        // );
      }
    }else{
      return Text("ksoong");
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
        child: Card(
          child: Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(10.0),
                child: Text("Stok Darah"),
              ),
              Row(
                children: <Widget>[
                  _golongandarah(),
                  // ListTile(
                  //   leading: Text(listStokDarah[0].golonganDarah),
                  //   title: Text(listStokDarah[0].golonganDarah),
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
      home: _getStokDarah(context),
    );
  }
}
