import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class PhotoCaptureScreen extends StatelessWidget {
  const PhotoCaptureScreen({
    super.key,
    required this.camera,
  });

  final CameraDescription camera;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Capture Photo'),
        backgroundColor: const Color(0xFFFFF1D0),
        elevation: 0,
      ),
      body: Center(
        child: Text(
          'Camera: ${camera.name}',
        ),
      ),
    );
  }
}
