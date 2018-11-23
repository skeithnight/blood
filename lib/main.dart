import 'package:flutter/material.dart';
import 'dart:convert';

import 'package:blood/screens/login_screen.dart';
import 'package:blood/screens/main_screen.dart';
import 'package:blood/screens/splash_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:blood/screens/request_darah_detail.dart';
import 'package:blood/models/request_darah_model.dart';
import 'package:blood/screens/request_screen.dart';

void main() => runApp(new MaterialApp(
      title: "Blood",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.lightBlue, fontFamily: 'Nunito'),
      home: MyApp(),
    ));

final FirebaseAuth _auth = FirebaseAuth.instance;

class MyApp extends StatefulWidget {
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  FirebaseMessaging _firebaseMessaging = new FirebaseMessaging();
  String fcmToken = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // getUser().then((user) {
    //   print(user);
    //   if (user != null) {
    //     print("adada");
    //     // send the user to the home page
    //     MainScreen();
    //   }
    // });
    // firebaseCloudMessaging_Listeners();
    // _navigateToItemDetail();
  }

  Future<FirebaseUser> getUser() async {
    return await _auth.currentUser();
  }

  void firebaseCloudMessaging_Listeners() {
    // Firebase messaging
    _firebaseMessaging.subscribeToTopic("requestDarah");

    _firebaseMessaging.getToken().then((token) {
      print(token);
    });

    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print('on message $message');
      },
      onResume: (Map<String, dynamic> message) async {
        print('on resume $message');
      },
      onLaunch: (Map<String, dynamic> message) async {
        print('on launch $message');
        // _navigateToItemDetail(message);
      },
    );
  }

  _navigateToItemDetail() {
    SplashScreen();
    // Navigator.push(context,
    //     MaterialPageRoute(builder: (BuildContext context) => SplashScreen()));
  }

  void _onLoading() {
    showDialog(
      context: context,
      barrierDismissible: false,
      child: new Dialog(
        child: new Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            new CircularProgressIndicator(),
            new Text("Loading"),
          ],
        ),
      ),
    );
  }

  // Widget _handleCurrentScreen(context) {
  //   return StreamBuilder<FirebaseUser>(
  //       stream: FirebaseAuth.instance.onAuthStateChanged,
  //       builder: (BuildContext context, snapshot) {
  //         if (snapshot.connectionState == ConnectionState.waiting) {
  //           print("Waiting......");
  //           // _onLoading();
  //           // return Navigator.of(context).pushNamed('/');
  //           return new SplashScreen();
  //         } else {
  //           if (snapshot.hasData) {
  //             print(snapshot.data.uid + " : " + snapshot.data.phoneNumber);
  //             return new MainScreen();
  //             // return new MainScreen(firestore: firestore,
  //             //     uuid: snapshot.data.uid);
  //           }
  //           print("Kosong");
  //           return new LoginScreen();
  //         }
  //       });
  // }

  @override
  Widget build(BuildContext context) {
    // _firebaseMessaging.configure(
    //   onMessage: (Map<String, dynamic> message) async {
    //     print('on message $message');
    //   },
    //   onResume: (Map<String, dynamic> message) async {
    //     print('on resume $message');
    //   },
    //   onLaunch: (Map<String, dynamic> message) async {
    //     print('on launch $message');
    //     // _navigateToItemDetail(message);
    //   },
    // );
    getUser().then((user) {
      if (user != null) {
        print("user");
        // send the user to the home page
        return new MainScreen();
      }else{
        return new LoginScreen();
      }
    });
    
  }
}
