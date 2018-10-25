import 'package:flutter/material.dart';
import 'package:blood/screens/home_screen.dart' as home;
import 'package:blood/screens/request_screen.dart' as request;
import 'package:blood/screens/profile_screen.dart' as profile;

class MainScreen extends StatelessWidget {
  static String tag = 'main-page';
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new MaterialApp(
      color: Colors.yellow,
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
            body: TabBarView(
              children: <Widget>[
                new home.HomeScreen(),
                new request.RequestScreen(),
                new profile.ProfileScreen(),
              ],
            ),
            bottomNavigationBar: TabBar(
              labelColor: Colors.black,
              tabs: <Widget>[
                Tab(icon: new Icon(Icons.home,color: Colors.black,),text: "Home",),
                Tab(icon: new Icon(Icons.library_books,color: Colors.black,),text: "Request"),
                Tab(icon: new Icon(Icons.people,color: Colors.black,),text: "Profile"),
              ],
            )),
      ),
    );
  }
}
