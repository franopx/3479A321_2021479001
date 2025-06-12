import 'dart:io';

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
  bool localImage = false;

  String tapIcon = 'assets/icons/tap_icon.svg';
  String removeIcon = 'assets/icons/minus_icon.svg';
  String resetIcon = 'assets/icons/reset_icon.svg';
  String caretLeft = 'assets/icons/caret-left.svg';
  String caretRight = 'assets/icons/caret-right.svg';

  String imageUrl = 'https://picsum.photos/640?image=1';
  void _getNewImage() async {
    var randomId = Random().nextInt(100);
    _imagePath = 'null';
    setState(() {
      localImage = false;
    });
    final newImageUrl = 'https://picsum.photos/640?image=$randomId';
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

  late List<String> imagePaths = [];
  late String _imagePath = 'null';
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

  @override
  Widget build(BuildContext context) {
    var appdata = context.watch<AppData>();

    Future<void> _navigateToCamera() async {
      await _loadCamera();

      if(!context.mounted) return;
      final result = await Navigator.push(
        context, 
        MaterialPageRoute(
          builder: (context) => CameraPage(camera: firstCamera)
        )
      );

      if(!context.mounted) return;
      setState(() {
        if(result != null) {
          
          _imagePath = result;
          imagePaths.add(_imagePath);
          setState(() {
            appdata.setCounter(imagePaths.length-1);
            localImage = true;
          });
          
        }  
      });
    }

    // Widget carta
    Card titleCard = Card(
      color:const Color.fromARGB(255, 244, 162, 97),
      margin: const EdgeInsets.all(10),
      child: 
      Padding( 
        padding: const EdgeInsets.all(20),
        child:
          Column(
            children: [
              SizedBox(height: 5,),              
                
              Flexible(
                child:
                  AspectRatio(
                    aspectRatio: 9 / 16,
                    child:
                      imagePaths.isEmpty || !localImage ?
                        Image.network(imageUrl.isNotEmpty ? imageUrl : '',
                          width: 360,
                          height: 640,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, StackTrace) {
                            return Center(
                              child: Text(
                                'Failed to load image, try again.',
                                style: TextStyle(color: Colors.red),
                              )
                            );
                          },
                        ) :
                        Image.file(
                          File(imagePaths[appdata.counter]),
                          width: 360,
                          height: 640,
                          fit: BoxFit.cover
                        ),
                  )
              ),
              
              const SizedBox(height: 10),
              
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(onPressed: () {setState(() {_getNewImage(); localImage = false;});}, child: const Text('Imagen de internet')),
                  SizedBox(width: 5,),
                  ElevatedButton(onPressed: () async {await _navigateToCamera();}, child: const Text('Abrir cámara'))
                ],
                ),
              
              const SizedBox(height: 10),
              Text('Imagen en el dispositivo: ${appdata.counter+1}'),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  ElevatedButton(onPressed: () {
                    context.read<AppData>().decreaseCounter();
                      setState(() {
                        if(imagePaths.isNotEmpty) localImage = true;
                      });},
                    child: SvgPicture.asset(caretLeft, width: 32.0)),
                  ElevatedButton(onPressed: () {
                    if (appdata.counter<imagePaths.length-1) {
                      context.read<AppData>().incrementCounter();
                      setState(() {
                        if(imagePaths.isNotEmpty) localImage = true;
                      });}
                    },
                    child: SvgPicture.asset(caretRight, width: 32.0)),
                  //ElevatedButton(onPressed: _isResetEnabled ? context.read<AppData>().resetCounter : null, child: SvgPicture.asset(resetIcon, width: 32.0)),
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
              title: const Text('Cámara'),
              onTap: () {
                Navigator.of(context).pop(); // cerrar el drawer
                _navigateToCamera();
              },
            ),
            /*
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
            */
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
        padding: const EdgeInsets.all(5),
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