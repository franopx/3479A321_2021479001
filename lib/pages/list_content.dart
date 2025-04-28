import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:laboratorio/pages/about.dart';
import 'package:logger/logger.dart';

class ListContentPage extends StatelessWidget {

  void onPressed() {
    return;
  }

  final List<String> elementos = [
    'Primer elemento',
    'Segundo elemento',
    'Tercer elemento',
    'Cuarto elemento'
  ];

  @override
  Widget build(BuildContext context) {
    
    // Contenido
    Widget list = ListView.builder(
      itemCount: elementos.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(elementos[index])
        );
      },
    );

    // Botones de navegación
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
            SizedBox(width: 160,
              child: 

                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context, 
                      MaterialPageRoute(
                        builder: (context) => AboutPage()
                      )
                    );
                  }, 
                  child: const Text('Pagina 2'),
                )

            )
          ],
        ),
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
            navigationButtons
          ],
        )
      )
    );
  }
}