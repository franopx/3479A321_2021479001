import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
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

  void _pageChange() {

  }


  @override
  Widget build(BuildContext context) {

    var logger = Logger();
    logger.d("Logger is working on MyHomePage widget!");

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              const Text('Titulo'),
              Card(
                color:const Color.fromARGB(255, 244, 162, 97),
                margin: const EdgeInsets.all(50.0),
                child: Column(
                  children: <Widget>[
                    const Text(textAlign: TextAlign.center, 'Flutter is an open source framework for building beautiful, natively compiled, multi-platform applications from a single codebase.'),
                    Text('Contador: $_counter'),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        FloatingActionButton(onPressed: _incrementCounter, child: SvgPicture.asset(tapIcon, width: 32.0)),
                        FloatingActionButton(onPressed: _decreaseCounter, child: SvgPicture.asset(removeIcon, width: 32.0)),
                        FloatingActionButton(onPressed: _resetCounter, child: SvgPicture.asset(resetIcon, width: 32.0)),
                      ]
                    ),
                  ]
                )
              ),
              FloatingActionButton(onPressed: _pageChange, child: const Text('Pagina 1'))
            ]
          ),
        ),
      );
    }
}