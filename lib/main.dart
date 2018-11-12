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
// // import 'package:flutter/material.dart';
// // import 'package:flutter/services.dart';
// // import 'package:google_places_picker/google_places_picker.dart';


// // void main() => runApp(new MyApp());

// // class MyApp extends StatefulWidget {
// //   @override
// //   _MyAppState createState() => new _MyAppState();
// // }

// // class _MyAppState extends State<MyApp> {
// //   String _placeName = 'Unknown';

// //   @override
// //   initState() {
// //     super.initState();
// //   }

// //   // Platform messages are asynchronous, so we initialize in an async method.
// //   _showPlacePicker() async {
// //     String placeName;
// //     // Platform messages may fail, so we use a try/catch PlatformException.
// //     var place = await PluginGooglePlacePicker.showPlacePicker();
// //     placeName = place.name;


// //     // If the widget was removed from the tree while the asynchronous platform
// //     // message was in flight, we want to discard the reply rather than calling
// //     // setState to update our non-existent appearance.
// //     if (!mounted)
// //       return;

// //     setState(() {
// //       _placeName = placeName;
// //     });
// //   }

// //   _showAutocomplete() async {
// //     String placeName;
// //     // Platform messages may fail, so we use a try/catch PlatformException.
// //     var place = await PluginGooglePlacePicker.showAutocomplete(PlaceAutocompleteMode.MODE_OVERLAY);
// //     placeName = place.name;


// //     // If the widget was removed from the tree while the asynchronous platform
// //     // message was in flight, we want to discard the reply rather than calling
// //     // setState to update our non-existent appearance.
// //     if (!mounted)
// //       return;

// //     setState(() {
// //       _placeName = placeName;
// //     });
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return new MaterialApp(
// //       home: new Scaffold(
// //         appBar: new AppBar(
// //           title: new Text('Place picker example app'),
// //         ),
// //         body: new Center(
// //           child: new Column(
// //             children: <Widget>[
// //               new FlatButton(onPressed: _showPlacePicker, child: new Text("Show place picker")),
// //               new FlatButton(onPressed: _showAutocomplete, child: new Text("Show autocomplete")),
// //               new Row(
// //                 children: <Widget>[
// //                   new Text("Place name: "),
// //                   new Text(_placeName)
// //                 ],
// //               )
// //             ],
// //           ),
// //         ),
// //       ),
// //     );
//   }
// }