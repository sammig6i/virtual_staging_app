import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'photo_capture.dart';
import 'photo_gallery.dart';

class Home extends StatelessWidget {
  const Home({super.key, required this.camera, required this.pickedImage});
  final CameraDescription? camera;
  final File? pickedImage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: false,
        title: const Padding(
          padding: EdgeInsets.symmetric(horizontal: 5.0),
          child: Text(
            'StageStudio AI',
            style: TextStyle(
              color: Colors.black,
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              width: MediaQuery.of(context).size.width * 0.9,
              height: MediaQuery.of(context).size.height * 0.70,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                image: const DecorationImage(
                  image: AssetImage('assets/staged_room.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.only(bottom: 30.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FloatingActionButton(
                    heroTag: 'takePhoto',
                    onPressed: camera == null
                        ? () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: const Text('Error'),
                                  content: const Text('No camera found'),
                                  actions: <Widget>[
                                    TextButton(
                                      child: const Text('OK'),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                  ],
                                );
                              },
                            );
                          }
                        : () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      PhotoCaptureScreen(camera: camera!)),
                            );
                          },
                    tooltip: 'Take Photo',
                    child: const Icon(Icons.add),
                  ),
                  const SizedBox(width: 20),
                  _PickPhotoButton(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PickPhotoButton extends StatefulWidget {
  @override
  State<_PickPhotoButton> createState() => _PickPhotoButtonState();
}

class _PickPhotoButtonState extends State<_PickPhotoButton> {
  Future<void> _pickImageFromGallery() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedFile != null && mounted) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PhotoGalleryScreen(
            pickedImage: File(pickedFile.path),
          ),
        ),
      );
    } else {
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      heroTag: 'pickPhoto',
      onPressed: _pickImageFromGallery,
      tooltip: 'Pick Photo from Gallery',
      child: const Icon(Icons.image),
    );
  }
}
