import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

typedef OnImageSelected = Function(File imageFile);

class ImagePickerWidget extends StatelessWidget {
  File? imageFile;

  final _picker = ImagePicker();

  final OnImageSelected? onImageSelected;

  ImagePickerWidget({Key? key, this.imageFile, this.onImageSelected})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [
              Colors.cyan,
              Colors.black,
            ],
          ),
          image: imageFile != null
              ? DecorationImage(
                  image: FileImage(imageFile!),
                  fit: BoxFit.cover,
                )
              : null),
      child: IconButton(
        icon: const Icon(Icons.camera_alt),
        onPressed: () {
          _showPictureOptions(context);
        },
        iconSize: 90,
        color: Colors.white,
      ),
    );
  }

  void _showPictureOptions(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Selecciona una opción"),
            actions: [
              ListTile(
                title: const Text('Camera'),
                leading: const Icon(Icons.camera),
                onTap: () {
                  Navigator.of(context).pop();
                  _getImage(ImageSource.camera);
                },
              ),
              ListTile(
                title: const Text('Gallery'),
                leading: const Icon(Icons.browse_gallery),
                onTap: () {
                  Navigator.of(context).pop();
                  _getImage(ImageSource.gallery);
                },
              ),
            ],
          );
        });
  }

  void _getImage(ImageSource source) async {
    try {
      PickedFile _img = await _picker.getImage(source: source);
      imageFile = File(_img.path);
      this.onImageSelected!(imageFile!);
    } catch (e) {}
  }
}
