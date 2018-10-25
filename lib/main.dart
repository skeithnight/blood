import 'package:flutter/material.dart';
<<<<<<< HEAD
import './pages/login_page.dart';
import './pages/home_page.dart';
=======
import 'routes.dart';
>>>>>>> 19e428cb557be76d6c564cefd1f3a4726ad3ddbe

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Blood",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.lightBlue, fontFamily: 'Nunito'),
      routes: routes,
    );
  }
}
