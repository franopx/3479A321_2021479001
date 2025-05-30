import 'package:flutter/material.dart';
import 'package:laboratorio/pages/activity_list.dart';

import 'package:laboratorio/pages/preferences.dart';
import 'package:laboratorio/pages/list_content.dart';
import 'package:laboratorio/pages/about.dart';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:laboratorio/provider.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'dart:math';
import 'package:http/http.dart' as http;

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() {
    return _MyHomePageState();
  }
  
}

class _MyHomePageState extends State<MyHomePage> {
  
  var logger = Logger();  
  bool _isResetEnabled = true;

  String tapIcon = 'assets/icons/tap_icon.svg';
  String removeIcon = 'assets/icons/minus_icon.svg';
  String resetIcon = 'assets/icons/reset_icon.svg';

  String imageUrl = 'https://picsum.photos/250?image=1';
  void _getNewImage() async {
    var randomId = Random().nextInt(100);    
    final newImageUrl = 'https://picsum.photos/250?image=$randomId';
    logger.d(newImageUrl);
    try {
      final response = await http.head(Uri.parse(newImageUrl));
      if (response.statusCode == 200 || response.statusCode == 404) {
        setState(() {
          imageUrl = newImageUrl;
        });
      } else {
        setState(() {
          imageUrl = '';
        });
      }
    } catch (e) {
      setState(() {
        imageUrl = '';
      });
    }
  }

  Future<void> _loadPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _isResetEnabled = prefs.getBool('isResetEnabled') ?? false;
    });
  }

  @override
  void initState() {
    super.initState();
    _loadPreferences();
  }

  @override
  Widget build(BuildContext context) {
    var appdata = context.watch<AppData>();


    // Widget carta
    Card titleCard = Card(
      color:const Color.fromARGB(255, 244, 162, 97),
      margin: const EdgeInsets.all(20),
      child: 
      Container( 
        padding: const EdgeInsets.all(20),
        child:
          Column(
            children: <Widget>[
              Text('User: ${appdata.userName}'),
              Image.network(imageUrl.isNotEmpty ? imageUrl : '',
                width: 250,
                height: 250,
                fit: BoxFit.cover,
                errorBuilder: (context, error, StackTrace) {
                  return Center(
                    child: Text(
                      'Failed to load image',
                      style: TextStyle(color: Colors.red),
                    )
                  );
                },
              ),
              ElevatedButton(onPressed: () {setState(() {_getNewImage();});}, child: const Text('Buscar otra imagen')),
              const SizedBox(height: 200),
              Text('Contador: ${appdata.counter}'),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  ElevatedButton(onPressed: context.read<AppData>().incrementCounter, child: SvgPicture.asset(tapIcon, width: 32.0)),
                  ElevatedButton(onPressed: context.read<AppData>().decreaseCounter, child: SvgPicture.asset(removeIcon, width: 32.0)),
                  ElevatedButton(onPressed: _isResetEnabled ? context.read<AppData>().resetCounter : null, child: SvgPicture.asset(resetIcon, width: 32.0)),
                ]
              ),
            ]
          )
      )
    );

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Home'),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const SizedBox(height: 100, child: DrawerHeader(child: Text('Páginas', style: TextStyle(fontWeight: FontWeight.bold)))),
            
            ListTile(
              title: const Text('Home'),
              onTap: () {
                Navigator.push(
                  context, 
                  MaterialPageRoute(
                    builder: (context) => MyHomePage(title: 'Home',)
                  )
                );
              } 
            ),
            
            ListTile(
              title: const Text('Lista de elementos'),
              onTap: () {
                Navigator.of(context).pop(); // cerrar el drawer
                Navigator.push(
                  context, 
                  MaterialPageRoute(
                    builder: (context) => ActivityListPage()
                  )
                );
              } 
            ),

            ListTile(
              title: const Text('Preferencias'),
              onTap: () {
                Navigator.of(context).pop(); // cerrar el drawer
                Navigator.push(
                  context, 
                  MaterialPageRoute(
                    builder: (context) => PreferencesPage()
                  )
                ).then((_) {
                  _loadPreferences();
                });
              } 
            ),

            ListTile(
              title: const Text('Acerca de'),
              onTap: () {
                Navigator.of(context).pop(); // cerrar el drawer
                Navigator.push(
                  context, 
                  MaterialPageRoute(
                    builder: (context) => AboutPage()
                  )
                );
              } 
            )
          ],
        )
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: <Widget>[

            // Carta
            Expanded(child: titleCard),

          ]
        ),
      ),
    );
  }




}