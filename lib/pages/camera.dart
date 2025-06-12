import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class CameraPage extends StatefulWidget {
  const CameraPage({super.key, required this.camera});
  
  final CameraDescription camera;

  @override
  State<StatefulWidget> createState() {
    return _CameraPageState();
  }
}

class _CameraPageState extends State<CameraPage> {

  late CameraController _controller;
  late Future<void> _initializeControllerFuture;
  late String imagePath = 'null';

  Future<CameraDescription> getCamera() async {
    final cameras = await availableCameras();
    final firstCamera = cameras.first;
    return firstCamera;
  }

  @override
  void initState() {
    super.initState();

    initializeCamera();
  }

  void initializeCamera() {
     _controller = CameraController(
      widget.camera,
      ResolutionPreset.medium,
    );
    _initializeControllerFuture = _controller.initialize();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(title: const Text('Cámara')),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: 
          Column(
            children: [

              Flexible(
                child:
                  AspectRatio(
                    aspectRatio: 9/16,
                    child:  imagePath == 'null' ?
                    Image(image: AssetImage("assets/images/no_image.jpg"), fit: BoxFit.cover, width: 360, height: 640,) :
                    Image.file(File(imagePath), fit: BoxFit.cover, width: 360, height: 640,),

                    )
              ),

              // photo
              SizedBox(height: 20,),

              FractionallySizedBox(
                widthFactor: 0.8,
                child:
                  FloatingActionButton(
                    child: const Text('Tomar fotografía'),
                    onPressed: () async {
                      try {
                        await _initializeControllerFuture;
                        final image = await _controller.takePicture();
                        /*
                        if (!context.mounted) return;
                        await Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => PreviewPictureScreen(
                              imagePath: image.path,
                            ),
                          ),
                        );
                        */
                        setState(() {
                          imagePath = image.path;
                        });
                        
                      } catch (e) {
                        print(e);
                      }
                    }
                  )
              ),
              SizedBox(height: 20,),
              FractionallySizedBox(
                widthFactor: 0.8,
                child:
                  FloatingActionButton(
                    heroTag: null,
                    child: const Text('Guardar fotografía'),
                    onPressed: () async {
                      if(!context.mounted) return;
                      if(imagePath != 'null') Navigator.pop(context, imagePath);
                    })
              ),
              SizedBox(height: 20,),
              FractionallySizedBox(
                widthFactor: 0.8,
                child:
                  FloatingActionButton(
                    heroTag: null,
                    child: const Text('Volver al home'),
                    onPressed: () async {
                      Navigator.pop(context);
                    })
              ),

              SizedBox(height: 10,)
              
            ],
          )
      ,)
      )
    );
  }
}


class PreviewPictureScreen extends StatelessWidget {
  final String imagePath;
  const PreviewPictureScreen({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Vista previa')),
      body: Image.file(File(imagePath)),
    );
  }
}