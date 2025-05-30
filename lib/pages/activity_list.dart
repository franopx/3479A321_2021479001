import 'package:flutter/material.dart';
import 'package:laboratorio/services/database_helper.dart';
import 'package:laboratorio/entity/activity.dart';
import 'package:logger/logger.dart';

class ActivityListPage extends StatefulWidget {
  const ActivityListPage({super.key});
  
  @override
  State<StatefulWidget> createState() {
    return _ActivityListPage();
  }

  
}

class _ActivityListPage extends State<ActivityListPage> {
  
  final DatabaseHelper _dbHelper = DatabaseHelper();
  List<Activity> _activities = [];

  var logger = Logger();

  @override
  void initState() {
    loadActivities();
    super.initState();
  }
  
  void loadActivities() async {
    _activities = await getActivities();
    logger.d(_activities);
  }

  Future<List<Activity>> getActivities() async {
    final db = await _dbHelper.database;

    final List<Map<String, Object?>> activityMap = await db.query('activities');
    return [
      for (final {'id': id as int, 'date': date as String, 'name': name as String} in activityMap)
      Activity(id, date, name),
    ];
  }


  @override
  Widget build(BuildContext context) {
    
    // Contenido
    Widget list = ListView.builder(
      itemCount: _activities.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(_activities[index].name)
        );
      },
    );

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Lista')),
      body: Container(
        padding: const EdgeInsets.all(20),
        child:
        Column(
          children: [
            Expanded(
              child: FutureBuilder<List<Activity>>(
                future: getActivities(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Center(child: Text('No hay actividades'));
                  }

                  final actividades = snapshot.data!;
                  return ListView.builder(
                    itemCount: actividades.length,
                    itemBuilder: (context, index) {
                      final actividad = actividades[index];
                      return ListTile(
                        title: Text(actividad.name),
                        subtitle: Text(actividad.date),
                      );
                    },
                  );
                },
              ),
              ),
          ],
        )
      )
    );
  }
}