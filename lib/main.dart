import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'pages/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {

    var logger = Logger();
    logger.d("Logger is working!");

    return MaterialApp(
      title: 'Tap App',
      theme: ThemeData(
        fontFamily: 'National Park',
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.red),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Contador'),
    );
  }
}


