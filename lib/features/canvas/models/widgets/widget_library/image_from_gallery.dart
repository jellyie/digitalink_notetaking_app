import 'package:digitalink_notetaking_app/features/canvas/models/widgets/widget_data.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

enum ImageSourceType { gallery, camera }

class ImageFromGalleryEx extends StatefulWidget {
  final WidgetData widgetData;
  final int index;

  const ImageFromGalleryEx(
      {Key? key, required this.widgetData, required this.index})
      : super(key: key);
  //ImageFromGalleryEx(this.widgetData, this.index);

  @override
  ImageFromGalleryExState createState() => ImageFromGalleryExState();
}

class ImageFromGalleryExState extends State<ImageFromGalleryEx> {
  var imagePicker;

  //ImageFromGalleryExState(this.widgetData, this.index);

  @override
  void initState() {
    super.initState();
    imagePicker = ImagePicker();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        const SizedBox(
          height: 52,
        ),
        Center(
          child: GestureDetector(
            onTap: () async {
              // var source = type == ImageSourceType.camera
              //     ? ImageSource.camera
              //     : ImageSource.gallery;
              var source = ImageSource.gallery;
              XFile image = await imagePicker.pickImage(
                  source: source,
                  imageQuality: 50,
                  preferredCameraDevice: CameraDevice.front);
              setState(() {
                //_image = File(image.path);
                widget.widgetData.setImagePath(image.path, widget.index);
              });
            },
            child: Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(color: Colors.red[200]),
              child: widget.widgetData.getParam(widget.index) != 0
                  ? Image.file(
                      File(widget.widgetData.getImagePath(widget.index)),
                      width: 200.0,
                      height: 200.0,
                      fit: BoxFit.fitHeight,
                    )
                  : Container(
                      decoration: BoxDecoration(color: Colors.red[200]),
                      width: 200,
                      height: 200,
                      child: Icon(
                        Icons.camera_alt,
                        color: Colors.grey[800],
                      ),
                    ),
            ),
          ),
        )
      ],
    );
  }
}
