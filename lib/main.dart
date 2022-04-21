import 'package:flutter/material.dart';
import 'package:showcase_demo/home.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Tutorial',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const HomePage(title: 'Tutorial'),
    );
  }
}
