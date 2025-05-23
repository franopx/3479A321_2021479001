import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:laboratorio/provider.dart';

class PreferencesPage extends StatelessWidget {
  const PreferencesPage({super.key});

  @override
  Widget build(BuildContext context) {
    
    Widget navigationButtons = Container(
      padding: const EdgeInsets.all(20),
      child:
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(width: 160,
              child:
                ElevatedButton(
                  onPressed: () {Navigator.pop(context);}, 
                  child: const Text('Volver')
                )
            ),
            SizedBox(width: 160)
          ],
        ),
    );


    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Preferencias')),
      body: Container(
        padding: EdgeInsets.all(20),
        child: 
          Column(
            children: [
              navigationButtons
            ]
          )
      )
    );
    
  }
}