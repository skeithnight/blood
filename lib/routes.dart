import 'package:flutter/material.dart';
import 'package:blood/screens/main_screen.dart';
import 'package:blood/screens/login_screen.dart';
import 'package:blood/screens/splash_screen.dart';

final routes = {
  '/login':         (BuildContext context) => new LoginScreen(),
  '/main':         (BuildContext context) => new MainScreen(),
  '/a' :          (BuildContext context) => new SplashScreen(),
};