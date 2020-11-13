import 'package:flutter/material.dart';
import 'package:movie_app_yt/pages/home/home.page.dart';
import 'package:movie_app_yt/pages/login/signUp.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: SignupPage(),
    );
  }
}
