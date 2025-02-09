// import 'dart:html';
// ignore_for_file: must_be_immutable, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class ImageViewScreen extends StatelessWidget {
  ImageViewScreen(this.img, {super.key, this.imageLoc});
  String img;
  final imageLoc;
  static const String routeName = 'imageviewscreen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PhotoView(
        minScale: PhotoViewComputedScale.contained,
        maxScale: PhotoViewComputedScale.contained,
        basePosition: Alignment.center,
        // enableRotation: true,
        imageProvider: NetworkImage(
          img.toString(),
        ),
      ),
    );
  }
}
