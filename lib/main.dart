// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:news_flutter/views/home.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "WhatTheLeak",
      home: Home(),
      theme: ThemeData(
        platform: TargetPlatform.iOS,
        appBarTheme: AppBarTheme(
          color: Colors.white,
        ),
        primaryColor: Colors.white,
      ),
    );
  }
}
