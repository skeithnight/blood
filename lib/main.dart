import 'package:flutter/material.dart';
import './pages/login_page.dart';
import './pages/home_page.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  final routes = <String, WidgetBuilder> {
    LoginPage.tag: (context) => LoginPage(),
    HomePage.tag: (context) => HomePage()
  };
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Blood",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.lightBlue, fontFamily: 'Nunito'),
      home: LoginPage(),
      routes: routes,
    );
  }
}
