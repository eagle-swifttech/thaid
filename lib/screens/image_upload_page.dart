import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'full_screen_image_page.dart';

class ImageUploadPage extends StatefulWidget {
  const ImageUploadPage({super.key});

  @override
  _ImageUploadPageState createState() => _ImageUploadPageState();
}

class _ImageUploadPageState extends State<ImageUploadPage> {
  final ImagePicker _picker = ImagePicker();
  List<XFile?> images = [null, null, null];

  Future<void> _pickImage(int index) async {
    final XFile? pickedFile =
    await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      images[index] = pickedFile;
    });

    if (images.every((image) => image != null)) {
      _showFullScreenImages(images);
    }
  }

  void _showFullScreenImages(List<XFile?> images) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FullScreenImagePage(images: images),
      ),
    );
  }

  Widget _buildImageDisplay() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: images.map((image) {
        return image != null
            ? Image.file(File(image.path), width: 100, height: 100)
            : Container();
      }).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Upload Images'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: List.generate(3, (index) {
              return SizedBox(
                width: 60, // Set the width of the button
                height: 30, // Set the height of the button
                child: ElevatedButton(
                  onPressed: () => _pickImage(index), // Change button text
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.zero, // Remove padding
                    minimumSize: Size.zero, // Remove minimum size constraint
                  ),
                  child: Text('Img ${index + 1}'),
                ),
              );
            }),
          ),
          const SizedBox(height: 20),
          _buildImageDisplay(),
        ],
      ),
    );
  }
}
