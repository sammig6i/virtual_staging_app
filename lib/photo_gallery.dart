import 'dart:io';

import 'package:flutter/material.dart';

class PhotoGalleryScreen extends StatefulWidget {
  const PhotoGalleryScreen({super.key, required this.pickedImage});
  final File? pickedImage;
  @override
  State<PhotoGalleryScreen> createState() => _PhotoGalleryScreenState();
}

class _PhotoGalleryScreenState extends State<PhotoGalleryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gallery'),
        backgroundColor: const Color(0xFFFFF1D0),
        elevation: 0,
      ),
      body: Center(
        child: widget.pickedImage != null
            ? Image.file(widget.pickedImage!)
            : const Text("Please select and image from the gallery."),
      ),
    );
  }
}
