// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mockito/mockito.dart';

import 'package:virtual_staging_app/main.dart';

class MockImagePicker extends Mock implements ImagePicker {}

void main() {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    const CameraDescription dummyCamera = CameraDescription(
        name: 'dummy',
        lensDirection: CameraLensDirection.back,
        sensorOrientation: 0);

    final mockFile = File('assets/staged_room.png');

    final mockImagePicker = MockImagePicker();

    when(mockImagePicker.pickImage(source: ImageSource.gallery))
        .thenAnswer((_) async => XFile(mockFile.path));

    // Build our app and trigger a frame.
    await tester.pumpWidget(MyApp(
      camera: dummyCamera,
      pickedImage: mockFile,
    ));
  });
}
