import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:laboratorio/pages/about.dart';
import 'package:laboratorio/pages/list_content.dart';
import 'package:logger/logger.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  // ignore: no_logic_in_create_state
  State<MyHomePage> createState() {
    var logger = Logger();
    logger.d("create_state");
    return _MyHomePageState();
  }

  
}

class _MyHomePageState extends State<MyHomePage> {
  
var logger = Logger();
  
  @override
  void initState() {
    super.initState();
    logger.d('initState override');
  }
  

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    logger.d('didChangeDependencies override');
  }
  

  @override
  void setState(VoidCallback fn) {
    super.setState(fn);
    logger.d('setState override');
  }

  @override
  void didUpdateWidget(covariant MyHomePage oldWidget) {
    super.didUpdateWidget(oldWidget);
    logger.d('didUpdateWidget override');
  }

  @override
  void deactivate() {
    super.deactivate();
    logger.d('deactivate override');
  }
  
  @override
  void dispose() {
    super.dispose();
    logger.d('dispose override');
  }
  
  @override
  void reassemble() {
    super.reassemble();
    logger.d('reassemble override');
  }

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
    logger.d("Widget built");

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
              const Icon(Icons.gamepad, size: 50.0),
              const Text(textAlign: TextAlign.left, 'Todavía no se sabe si has ganado o perdido.'),
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