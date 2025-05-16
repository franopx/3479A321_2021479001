import 'package:flutter/material.dart';
import 'package:laboratorio/pages/about.dart';

class ListContentPage extends StatelessWidget {

  void onPressed() {
    return;
  }

  final List<String> elements = [
    'Primer elemento',
    'Segundo elemento',
    'Tercer elemento',
    'Cuarto elemento'
  ];

  ListContentPage({super.key});

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