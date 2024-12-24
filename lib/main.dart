import 'package:flutter/material.dart';
import 'screens/image_upload_page.dart';

void main() {
  runApp(const ImageUploadApp());
}

class ImageUploadApp extends StatelessWidget {
  const ImageUploadApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Image Upload App',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const ImageUploadPage(),
    );
  }
}
