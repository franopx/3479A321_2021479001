import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:laboratorio/pages/list_content.dart';
import 'package:logger/logger.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  String tapIcon = 'assets/icons/tap_icon.svg';
  String removeIcon = 'assets/icons/minus_icon.svg';
  String resetIcon = 'assets/icons/reset_icon.svg';

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  void _decreaseCounter() {
    setState(() {
      _counter--;
    });
  }

  void _resetCounter() {
    setState(() {
      _counter = 0;
    });
  }


  @override
  Widget build(BuildContext context) {

    var logger = Logger();
    logger.d("Logger is working on MyHomePage widget!");

    // Widget carta
    Card titleCard = Card(
      color:const Color.fromARGB(255, 244, 162, 97),
      margin: const EdgeInsets.all(20),
      child: 
      Container( 
        padding: const EdgeInsets.all(20),
        child:
          Column(
            spacing: 10.0,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              const Text(textAlign: TextAlign.left, 'Flutter es un framework de código abierto de Google para crear hermosas aplicaciones multiplataforma compiladas de forma nativa a partir de una única base de código.'),
              const SizedBox(height: 200),
              Text('Contador: $_counter'),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  ElevatedButton(onPressed: _incrementCounter, child: SvgPicture.asset(tapIcon, width: 32.0)),
                  ElevatedButton(onPressed: _decreaseCounter, child: SvgPicture.asset(removeIcon, width: 32.0)),
                  ElevatedButton(onPressed: _resetCounter, child: SvgPicture.asset(resetIcon, width: 32.0)),
                ]
              ),
            ]
          )
      )
    );

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      //drawer: Drawer(child: const Text('holanda')),
      body: Center(
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
                    SizedBox( width: 160,
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