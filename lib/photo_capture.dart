import 'package:flutter/material.dart';

class PhotoCaptureScreen extends StatelessWidget {
  const PhotoCaptureScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Capture Photo'),
        backgroundColor: const Color(0xFFFFF1D0),
        elevation: 0,
      ),
      body: const Center(
        child: Text(
          'Photo Capture Screen Placeholder',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
