import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:laboratorio/provider.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    
    var appdata = context.watch<AppData>();

    Widget content = Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text('Acerca de la aplicación.'),
        SizedBox(height: 20,),
      ],
    );
      

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Acerca de')),
      body: Container(
        padding: EdgeInsets.all(20),
        child: 
          Column(
            children: [
              Expanded(child: content),
            ]
          )
      )
    );
  }
}