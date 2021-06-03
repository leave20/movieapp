import 'package:flutter/material.dart';
import 'package:movieapp/src/pages/home_page.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'App Movies',
      initialRoute: '/',
      routes: {
        '/':(BuildContext context)=>HomePage(),
      },
    );
  }
}