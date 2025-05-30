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
  String name = "Null"; 

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
    loadActivities();
  }

  @override
  void dispose() {
    _savePreferences();
    super.dispose();
  }

  List<Activity> _activities = [];
  int lastId = 0;
  void loadActivities() async {
    _activities = await getActivities();
    lastId = _activities.length;
  }

  Future<List<Activity>> getActivities() async {
    final db = await _dbHelper.database;

    final List<Map<String, Object?>> activityMap = await db.query('activities');
    return [
      for (final {'id': id as int, 'date': date as String, 'name': name as String} in activityMap)
      Activity(id, date, name),
    ];
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
                  setState(() {
                    name = text;
                  })
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
                    Activity activ1 = Activity(lastId, '2025-05-29', name);
                    insertActivity(activ1);
                    setState(() {
                      lastId += 1;
                    });
                  }, child: Text('Agregar actividad')),
                ],
              )
            ],
          )    
        )
      );
  }
}