import 'package:flutter/material.dart';
import 'package:blood/screens/login_screen.dart';
import 'package:blood/screens/main_screen.dart';
import 'package:blood/screens/splash_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
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
