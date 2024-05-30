import 'package:flutter/material.dart';

class PhotoGalleryScreen extends StatelessWidget {
  const PhotoGalleryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gallery'),
        backgroundColor: const Color(0xFFFFF1D0),
        elevation: 0,
      ),
      body: const Center(
        child: Text(
          'Photo Gallery Screen Placeholder',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
