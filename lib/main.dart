import 'package:flutter/material.dart';
import 'routes.dart';

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
