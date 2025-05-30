import 'package:flutter/material.dart';
import 'package:laboratorio/services/database_helper.dart';
import 'package:laboratorio/entity/activity.dart';
import 'package:logger/logger.dart';
import 'package:path/path.dart';

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

  String newName = '';
  Future<void> changeNameDialog(BuildContext context){
    return showDialog(
      context: context, 
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Cambiar nombre'),
          content: TextField(                
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Cambiar User Name',
              ),
            onChanged: (text) => {
              setState(() {
                newName = text;
            },)
            },
          ),
          actions: [
            TextButton(
              onPressed: () {
                deleteActivity(currentActivity.id);
                Navigator.of(context).pop();
              },
              child: Text('Delete')
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              }, 
              child: Text('No')
            ),
            TextButton(
              onPressed: () {
                Activity newActivity = Activity(currentActivity.id, currentActivity.date, newName);
                updateDog(newActivity);
                setState(() {
                  
                });
                Navigator.of(context).pop();
              }, 
              child: Text('Yes')
            ),
          ]
        );
      }
    );
  }

  Activity currentActivity = Activity(-1, '', '');
  Future<void> updateDog(Activity activity) async {
    final db = await _dbHelper.database;

    await db.update(
      'activities',
      activity.toMap(),
      where: 'id = ?',
      whereArgs: [activity.id],
    );
  }

  Future<void> deleteActivity(int id) async {
  // Get a reference to the database.
  final db = await _dbHelper.database;

  await db.delete(
    'activities',
    where: 'id = ?',
    whereArgs: [id],
  );
}

  @override
  Widget build(BuildContext context) {

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

                  final activities = snapshot.data!;
                  return ListView.builder(
                    itemCount: activities.length,
                    itemBuilder: (context, index) {
                      final actv = activities[index];
                      return ListTile(
                        title: Text(actv.name),
                        subtitle: Text(actv.date),
                        onTap: () {
                          setState(() {
                            currentActivity = actv;
                          });
                          changeNameDialog(context);
                        },
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

