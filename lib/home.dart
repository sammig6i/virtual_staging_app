import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'photo_capture.dart';
import 'photo_gallery.dart';

class Home extends StatelessWidget {
  final CameraDescription? camera;

  const Home({super.key, required this.camera});

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
        child: camera == null
            ? const Text('No camera found')
            : Column(
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
                              ? null
                              : () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            PhotoCaptureScreen(
                                                camera: camera!)),
                                  );
                                },
                          tooltip: 'Take Photo',
                          child: const Icon(Icons.add),
                        ),
                        const SizedBox(width: 20),
                        FloatingActionButton(
                          heroTag: 'pickPhoto',
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const PhotoGalleryScreen()),
                            );
                          },
                          tooltip: 'Pick Photo from Gallery',
                          child: const Icon(Icons.image),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
