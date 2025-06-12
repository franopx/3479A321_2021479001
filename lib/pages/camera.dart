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
        child: 
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // photo
              FractionallySizedBox(
                widthFactor: 0.8,
                child:
                  FloatingActionButton(
                    child: const Text('Tomar fotografía'),
                    onPressed: () async {
                      try {
                        await _initializeControllerFuture;
                        final image = await _controller.takePicture();

                        if (!context.mounted) return;
                        await Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => PreviewPictureScreen(
                              imagePath: image.path,
                            ),
                          ),
                        );
                      } catch (e) {
                        print(e);
                      }
                    }
                  )
              ),
            ],
          )
      ,) 
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