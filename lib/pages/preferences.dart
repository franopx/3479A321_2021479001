import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:laboratorio/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:logger/logger.dart';

import 'package:laboratorio/services/database_helper.dart';
import 'package:laboratorio/entity/activity.dart';

class PreferencesPage extends StatefulWidget {
  const PreferencesPage({super.key});

  @override
  State<PreferencesPage> createState() {
    return _PreferencesPage();
  }
  
}


class _PreferencesPage extends State<PreferencesPage> {

  final DatabaseHelper _dbHelper = DatabaseHelper();
  bool _isResetEnabled = true;

  var logger = Logger();

  Future<void> _loadPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _isResetEnabled = prefs.getBool('isResetEnabled') ?? false;
    });
  }

  Future<void> _savePreferences() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isResetEnabled', _isResetEnabled);
  }

  @override
  void initState() {
    super.initState();
    _loadPreferences();
  }

  @override
  void dispose() {
    _savePreferences();
    super.dispose();
  }

  Future<void> insertActivity(Activity act) async {
    final db = await _dbHelper.database;
    await db.insert('activities', act.toMap());
  }


  @override
  Widget build(BuildContext context) {
    

    var appdata = context.watch<AppData>();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Preferencias')),
      body: Container(
        padding: EdgeInsets.all(20),
        child: 
          Column(
            children: [
              Text('Username: ${appdata.userName}'),
              TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Cambiar User Name',
                ),
                onChanged: (text) => {
                  context.read<AppData>().changeUserName(text)
                },
              ),
              Column(
                children: [
                  Container(child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Botón de reiniciar'),
                      Switch(
                        value: _isResetEnabled,
                        onChanged: (bool value) {
                          setState(() {
                            _isResetEnabled = value;
                          });

                          appdata.toggleReset(value);
                        },)
                    ],
                  ))
                ]
              ),
              SizedBox(height: 32,),
              Column(
                children: [
                  ElevatedButton(onPressed: () {
                    Activity activ1 = Activity(0, '2025-05-29', 'Actividad 1');
                    insertActivity(activ1);

                  }, child: Text('Agregar actividad 1')),
                  ElevatedButton(onPressed: () {
                    Activity activ2 = Activity(1, '2025-05-29', 'Actividad 2');
                    insertActivity(activ2);

                  }, child: Text('Agregar actividad 2'))
                ],
              )
            ],
          )    
        )
      );
  }
}