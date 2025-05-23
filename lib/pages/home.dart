import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:laboratorio/pages/list_content.dart';
import 'package:laboratorio/provider.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() {
    return _MyHomePageState();
  }

  
}

class _MyHomePageState extends State<MyHomePage> {
  
  var logger = Logger();
 

  @override
  void initState() {
    super.initState();
    logger.d('initState override');
    logger.d('El widget se encuentra en el arbol: $mounted');
  }


  String tapIcon = 'assets/icons/tap_icon.svg';
  String removeIcon = 'assets/icons/minus_icon.svg';
  String resetIcon = 'assets/icons/reset_icon.svg';

  @override
  Widget build(BuildContext context) {
    var appdata = context.watch<AppData>();


    // Widget carta
    Card titleCard = Card(
      color:const Color.fromARGB(255, 244, 162, 97),
      margin: const EdgeInsets.all(20),
      child: 
      Container( 
        padding: const EdgeInsets.all(20),
        child:
          Column(
            children: <Widget>[
              Text('User: ${appdata.userName}'),
              const Icon(Icons.gamepad, size: 50.0),
              const Text(textAlign: TextAlign.left, 'Todavía no se sabe si has ganado o perdido.'),
              const SizedBox(height: 200),
              Text('Contador: ${appdata.counter}'),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  ElevatedButton(onPressed: context.read<AppData>().incrementCounter, child: SvgPicture.asset(tapIcon, width: 32.0)),
                  ElevatedButton(onPressed: context.read<AppData>().decreaseCounter, child: SvgPicture.asset(removeIcon, width: 32.0)),
                  ElevatedButton(onPressed: appdata.isResetEnabled ? context.read<AppData>().resetCounter : null, child: SvgPicture.asset(resetIcon, width: 32.0)),
                ]
              ),
            ]
          )
      )
    );

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Home'),
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: <Widget>[

            // Carta
            Expanded(child: titleCard),
            
            // Botones de abajo
            Container(
              padding: const EdgeInsets.all(20),
              child:
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const SizedBox(),
                    SizedBox(width: 160,
                      child: 
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context, 
                              MaterialPageRoute(
                                builder: (context) => ListContentPage()
                              )
                            );
                          }, 
                          child: const Text('Pagina 1'),
                        )
                    )
                  ],
                ),
            )
          ]
        ),
      ),
    );
  }




}