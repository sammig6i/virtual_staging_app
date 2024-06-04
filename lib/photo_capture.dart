import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class PhotoCaptureScreen extends StatefulWidget {
  const PhotoCaptureScreen({super.key, required this.camera});

  final CameraDescription camera;

  @override
  State<PhotoCaptureScreen> createState() => _PhotoCaptureScreenState();
}

class _PhotoCaptureScreenState extends State<PhotoCaptureScreen> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;

  @override
  void initState() {
    super.initState();
    _controller = CameraController(
      widget.camera,
      ResolutionPreset.high,
    );
    _initializeControllerFuture = _controller.initialize();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _takePicture() async {
    // TODO: update image paths for feeding to DB and AI model
    // TODO: Allow 2 options after user takes photo - retake picture or generate AI staged photo
    try {
      await _initializeControllerFuture;
      final image = await _controller.takePicture();

      final directory = await getTemporaryDirectory();

      final imagePath = '${directory.path}/${DateTime.now()}.png';
      await image.saveTo(imagePath);

      if (!mounted) return;
      // You can now use the captured image file.
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => DisplayPictureScreen(imagePath: imagePath)),
      );
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Capture Photo'),
        backgroundColor: const Color(0xFFFFF1D0),
        elevation: 0,
      ),
      body: FutureBuilder<void>(
        future: _initializeControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return CameraPreview(_controller);
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: _takePicture,
        child: const Icon(Icons.camera),
      ),
    );
  }
}

// A widget that displays the picture taken by the user.
class DisplayPictureScreen extends StatelessWidget {
  final String imagePath;

  const DisplayPictureScreen({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Display Picture'),
        backgroundColor: const Color(0xFFFFF1D0),
        elevation: 0,
      ),
      body: Center(
        child: Image.file(File(imagePath)),
      ),
    );
  }
}
