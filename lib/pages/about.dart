import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:logger/logger.dart';

class AboutPage extends StatelessWidget {

  void onPressed() {
    return;
  }


  @override
  Widget build(BuildContext context) {
    
    Widget content = Container(
      child:
        Text('Acerca de la aplicación.'),
    );

// Botones de navegación
    Widget navigation_buttons = Container(
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
        title: const Text('Acerca de')),
      body: Container(
        padding: EdgeInsets.all(20),
        child: 
          Column(
            children: [
              Expanded(child: content),
              navigation_buttons
            ]
          )
      )
    );
  }
}