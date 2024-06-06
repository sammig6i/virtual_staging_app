import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:camera/camera.dart';
import 'home.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  List<CameraDescription> cameras;
  CameraDescription? firstCamera;
  File? pickedImage;

  try {
    cameras = await availableCameras();

    if (cameras.isEmpty) {
      throw Exception('No camera found');
    }

    firstCamera = cameras.first;
  } catch (e) {
    print('Error: $e');
  }

  runApp(MyApp(camera: firstCamera, pickedImage: pickedImage));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.camera, required this.pickedImage});
  final CameraDescription? camera;
  final File? pickedImage;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'StageStudio AI',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFFFFF1D0),
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: Color(0xFFFFF1D0),
            statusBarIconBrightness: Brightness.dark,
            statusBarBrightness: Brightness.light,
          ),
        ),
        scaffoldBackgroundColor: const Color(0xFFFFF1D0),
      ),
      home: Home(camera: camera, pickedImage: pickedImage),
    );
  }
}
