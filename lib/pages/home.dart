import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:laboratorio/pages/activity_list.dart';
import 'package:laboratorio/pages/camera.dart';

import 'package:laboratorio/pages/preferences.dart';
import 'package:laboratorio/pages/list_content.dart';
import 'package:laboratorio/pages/about.dart';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:laboratorio/provider.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';


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

  Future<void> _loadPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _isResetEnabled = prefs.getBool('isResetEnabled') ?? false;
    });
  }


  late CameraDescription firstCamera;
  Future<void> _loadCamera() async
  {
    List<CameraDescription> cameras = await availableCameras();
    setState(() {
      firstCamera = cameras.first;
    });
  }

  @override
  void initState() {
    super.initState();
    _loadPreferences(); 
  }



  String tapIcon = 'assets/icons/tap_icon.svg';
  String removeIcon = 'assets/icons/minus_icon.svg';
  String resetIcon = 'assets/icons/reset_icon.svg';

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
              const Icon(Icons.gamepad, size: 50.0),
              const Text(textAlign: TextAlign.left, 'Todavía no se sabe si has ganado o perdido.'),
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


    Future<void> _navigateToCamera() async {
      await _loadCamera();

      if(!context.mounted) return;
      Navigator.of(context).pop(); // cerrar el drawer
      final result = await Navigator.push(
        context, 
        MaterialPageRoute(
          builder: (context) => CameraPage(camera: firstCamera)
        )
      );
    }

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
              title: const Text('Cámara'),
              onTap: () {
                _navigateToCamera();
              },
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