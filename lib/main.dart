import 'package:flutter/material.dart';
import 'package:laboratorio/provider.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
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


    
    return ChangeNotifierProvider<AppData>(
      create: (context) => AppData(),
      child: MaterialApp(
        title: 'Tap App',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.red),
          useMaterial3: true,
        ),
        home: const MyHomePage(title: 'Contador')
      )
    );
    
    /*
    return MaterialApp(
      title: 'Tap App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.red),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Contador'),
    );
    */
  }
}


