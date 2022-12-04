import 'package:flutter/material.dart';
import 'package:fys/builders.dart';
import 'package:fys/pages/homepage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.purple,
        scaffoldBackgroundColor: Color.fromARGB(255, 94, 28, 94),
        visualDensity: VisualDensity.adaptivePlatformDensity,
        textTheme: TextTheme(
          bodyText1: TextStyle(
            color: Colors.white,
            fontFamily: 'Times New Roman',
            fontSize: 20,
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            primary: Colors.green,
            onPrimary: Color.fromARGB(255, 232, 255, 225),
            minimumSize: Size(130, 130),
            textStyle: TextStyle(fontSize: 10, fontFamily: 'alagard'),
          ),
        ),
      ),
      home: MyHomePage(),
    );
  }
}
