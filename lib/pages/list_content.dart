import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:logger/logger.dart';

class ListContentPage extends StatelessWidget {

  void onPressed() {
    return;
  }


  @override
  Widget build(BuildContext context) {
    
    Widget list = ListView(
      children: [
        ElevatedButton(onPressed: onPressed, child: const Text('Lista'))
      ],
    );

    return Scaffold(
      body: Container(
         child: list
      )
    );
  }
}