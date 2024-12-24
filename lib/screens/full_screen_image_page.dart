import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:flip_card/flip_card.dart';
import 'dart:math' as math;

class FullScreenImagePage extends StatefulWidget {
  final List<XFile?> images;

  const FullScreenImagePage({super.key, required this.images});

  @override
  _FullScreenImagePageState createState() => _FullScreenImagePageState();
}

class _FullScreenImagePageState extends State<FullScreenImagePage> {
  bool isLandscape = false;


  void _toggleLandscape() {
    setState(() {
      isLandscape = !isLandscape;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          if (!isLandscape)
            widget.images[0] != null
                ? Image.file(
                    File(widget.images[0]!.path),
                    fit: BoxFit.cover,
                  )
                : Container(),

          widget.images[1] != null && widget.images[2] != null
              ? Positioned(
                  left: isLandscape ? (MediaQuery.of(context).size.width - 600) / 2 : 50,
                  right: isLandscape ? null : 50,
                  top: isLandscape
                      ? (MediaQuery.of(context).size.height - 400) / 2
                      : -210,
                  child: GestureDetector(
                    
                    onDoubleTap: _toggleLandscape,
                    child: Transform.rotate(
                      angle: isLandscape ? math.pi / 2 : 0,
                      child: SizedBox(
                        width: isLandscape ? 600 : MediaQuery.of(context).size.width - 100,
                        height: isLandscape ? 300 : 800,
                        child: FlipCard(
                          direction: FlipDirection.HORIZONTAL,
                          front: Image.file(
                            File(widget.images[1]!.path),
                            fit: BoxFit.contain,
                          ),
                          back: Image.file(
                            File(widget.images[2]!.path),
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              : Container(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pop(context);
        }, 
        tooltip: 'Upload Images',
        child: Icon(Icons.upload_file),
      ),
    );
  }
}
