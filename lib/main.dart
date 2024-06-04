import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:camera/camera.dart';
import 'home.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  List<CameraDescription> cameras;
  CameraDescription? firstCamera;

  try {
    cameras = await availableCameras();

    if (cameras.isEmpty) {
      throw Exception('No camera found');
    }

    firstCamera = cameras.first;
  } catch (e) {
    // ignore: avoid_print
    print('Error: $e');
  }

  runApp(MyApp(camera: firstCamera));
}

class MyApp extends StatelessWidget {
  final CameraDescription? camera;
  const MyApp({super.key, required this.camera});

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
      home: Home(camera: camera),
    );
  }
}
