import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:laboratorio/pages/camera.dart';
import 'package:laboratorio/provider.dart';
import 'package:laboratorio/services/database_helper.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'pages/home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DatabaseHelper().initializeDatabase();


  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key}); 

  @override
  Widget build(BuildContext context) {
    
    return ChangeNotifierProvider<AppData>(
      create: (context) => AppData(),
      child: MaterialApp(
        title: 'Tap App',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.red),
          useMaterial3: true,
        ),
        home: MyHomePage(title: 'Tap App'))//const MyHomePage(title: 'Contador')
      );
    
  }
}


