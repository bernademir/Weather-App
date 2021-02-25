import 'package:flutter/material.dart';
import 'package:weatherapp/views/home_page_view.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather App',
      debugShowCheckedModeBanner: false,
      home: HomePageView(),
    );
  }
}
