import 'package:flutter/material.dart';
import 'package:blood/screens/login_screen.dart';
import 'package:blood/screens/main_screen.dart';
import 'package:blood/screens/splash_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

void main() => runApp(new MyApp());

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
    // Firebase messaging
    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) {
        print('on message yooo $message');
        // _showDialog(message);
      },
      onResume: (Map<String, dynamic> message) {
        print('on resume $message');
        // _showDialog(message);
      },
      onLaunch: (Map<String, dynamic> message) {
        print('on launch $message');
        // _showDialog(message);
      },
    );
    _firebaseMessaging.requestNotificationPermissions(
        const IosNotificationSettings(sound: true, badge: true, alert: true));
    _firebaseMessaging.getToken().then((token) {
      print(token);
    });
  }

Widget _handleCurrentScreen(context) {
    return StreamBuilder<FirebaseUser>(
        stream: FirebaseAuth.instance.onAuthStateChanged,
        builder: (BuildContext context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            print("Waiting......");
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