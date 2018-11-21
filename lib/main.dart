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

void main() => runApp(new MyApp());

class MyApp extends StatefulWidget {
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  FirebaseMessaging _firebaseMessaging = new FirebaseMessaging();
  String fcmToken = '';

  void pindahPage(message){
    RequestDarahModel ac = new RequestDarahModel.fromSnapshot(json.decode(message['data']['body']));
        Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => RequestDarahDetailScreen(ac)));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // Firebase messaging
    _firebaseMessaging.subscribeToTopic("requestDarah");
    _firebaseMessaging.configure(
      onMessage: (Map<dynamic, dynamic> message) {
        print('on message $message');
        pindahPage(message);
        // _showDialog(message);
      },
      onResume: (Map<dynamic, dynamic> message) {
        print('on resume $message');
        pindahPage(message);
        // _showDialog(message);
      },
      onLaunch: (Map<dynamic, dynamic> message) {
        print('on launch $message');
        pindahPage(message);
        // _showDialog(message);
      },
    );
    _firebaseMessaging.requestNotificationPermissions(
        const IosNotificationSettings(sound: true, badge: true, alert: true));
    _firebaseMessaging.getToken().then((token) {
      print(token);
    });
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

Widget _handleCurrentScreen(context) {
    return StreamBuilder<FirebaseUser>(
        stream: FirebaseAuth.instance.onAuthStateChanged,
        builder: (BuildContext context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // print("Waiting......");
            _onLoading();
            // return Navigator.of(context).pushNamed('/');
            return new SplashScreen();
          } else {
            if (snapshot.hasData) {
              print( snapshot.data.uid+" : "+snapshot.data.phoneNumber);
              return new MainScreen();
              // return new MainScreen(firestore: firestore,
              //     uuid: snapshot.data.uid);
            }
            print("Kosong");
            return new LoginScreen();
          }
        });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Blood",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.lightBlue, fontFamily: 'Nunito'),
      home: _handleCurrentScreen(context),
      // routes: routes,
    );
  }
}