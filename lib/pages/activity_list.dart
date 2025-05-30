import 'package:flutter/material.dart';


class ActivityListPage extends StatefulWidget {
  const ActivityListPage({super.key});
  
  @override
  State<StatefulWidget> createState() {
    return _ActivityListPage();
  }
}

class _ActivityListPage extends State<ActivityListPage> {
  
  final List<String> elements = [
    'Primer elemento',
    'Segundo elemento',
    'Tercer elemento',
    'Cuarto elemento'
  ];
  
  @override
  Widget build(BuildContext context) {
    
    // Contenido
    Widget list = ListView.builder(
      itemCount: elements.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(elements[index])
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
            Expanded(child: list),
          ],
        )
      )
    );
  }
}