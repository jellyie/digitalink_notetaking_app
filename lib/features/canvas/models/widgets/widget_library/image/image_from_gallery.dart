import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../../../providers.dart';

enum ImageSourceType { gallery, camera }

// ignore: must_be_immutable
class ImageFromGallery extends ConsumerStatefulWidget {
  const ImageFromGallery({Key? key, required imageFile}) : super(key: key);

  static XFile? imageFile;

  @override
  _ImageFromGalleryState createState() => _ImageFromGalleryState();
}

class _ImageFromGalleryState extends ConsumerState<ImageFromGallery> {
  late ImagePicker imagePicker;

  @override
  void initState() {
    super.initState();
    imagePicker = ImagePicker();
  }

  @override
  Widget build(BuildContext context) {
    XFile? image;
    final notifier = ref.watch(widgetNotifierProvider.notifier);
    return Column(
      children: [
        const SizedBox(height: 52.0),
        Center(
          child: GestureDetector(
            onTap: () async {
              var source = ImageSource.gallery;
              image = await imagePicker.pickImage(
                  source: source,
                  imageQuality: 50,
                  preferredCameraDevice: CameraDevice.front);
              notifier.updateWidgetData('',
                  img: (ImageFromGallery.imageFile = image));
            },
            child: Container(
              width: 200.0,
              height: 200.0,
              decoration: BoxDecoration(color: Colors.red[200]),
              child: (image != null)
                  ? Image.file(File(ImageFromGallery.imageFile!.path),
                      width: 200.0, height: 200.0, fit: BoxFit.fitHeight)
                  : Container(
                      decoration: BoxDecoration(color: Colors.red[200]),
                      width: 200.0,
                      height: 200.0,
                      child: Icon(
                        Icons.camera_alt,
                        color: Colors.grey[800],
                      )),
            ),
          ),
        ),
      ],
    );
  }
}
