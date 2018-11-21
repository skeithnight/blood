import 'package:flutter/material.dart';
import 'package:blood/routes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:blood/screens/home_screen.dart' as home;
import 'package:blood/screens/request_screen.dart' as request;
import 'package:blood/screens/profile_screen.dart' as profile;
import 'request_darah_screen.dart' as requestDarah;

class MainScreen extends StatelessWidget {
  static String tag = 'main-page';
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = new GoogleSignIn();

  Future<Null> _signOut() async {
    await FirebaseAuth.instance.signOut();
    await googleSignIn.signOut();
  }

  // Future<
  // pindah ke activity request darah
  void goToRequest(context) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => requestDarah.RequestDarahScreen()));
  }

  Widget bottomNavigator() => TabBar(
        labelColor: Colors.black,
        tabs: <Widget>[
          Tab(
            icon: new Icon(
              Icons.home,
              color: Colors.black,
            ),
            text: "Home",
          ),
          Tab(
              icon: new Icon(
                Icons.library_books,
                color: Colors.black,
              ),
              text: "Request"),
        ],
      );
  Widget appBar() => new AppBar( title: Text("Blood Stream"),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.exit_to_app,
              color: Colors.white,
            ),
            onPressed: () {
              _signOut();
            },
          )
        ],
      );
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new MaterialApp(
      routes: routes,
      color: Colors.yellow,
      home: DefaultTabController(
        length: 3,
        child: SafeArea(
          child: Scaffold(
              appBar: appBar(),
              body: TabBarView(
                children: <Widget>[
                  new home.HomeScreen(),
                  new request.RequestScreen(),
                ],
              ),
              floatingActionButton: new FloatingActionButton(
                onPressed: () => goToRequest(context),
                elevation: 5.0,
                tooltip: "adada",
                child: const Icon(Icons.add),
              ),
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.endFloat,
              bottomNavigationBar: bottomNavigator()),
        ),
      ),
    );
  }
}
