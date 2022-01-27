import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as syspaths;

class ImageInput extends StatefulWidget {
  final Function _setImage;

  ImageInput(this._setImage);

  @override
  _ImageInputState createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  File? _image;
  Future<void> _takePicture() {
    final picker = ImagePicker();
    return picker
        .pickImage(source: ImageSource.camera, maxWidth: 600)
        .then((img) {
      if (img == null) {
        return;
      }
      final imageFile = File(img.path);
      setState(() => _image = imageFile);
      syspaths.getApplicationDocumentsDirectory().then((appDir) {
        final fileName = path.basename(imageFile.path);
        imageFile
            .copy('${appDir.path}/$fileName')
            .then((savedImage) => widget._setImage(savedImage));
      });
    });
  }

  @override
  Widget build(BuildContext context) => Row(
        children: [
          Container(
            width: 150,
            height: 100,
            decoration: BoxDecoration(
              border: Border.all(
                width: 1,
                color: Colors.grey,
              ),
            ),
            alignment: Alignment.center,
            child: (_image == null)
                ? const Text(
                    'No Image taken',
                    textAlign: TextAlign.center,
                  )
                : Image.file(
                    _image!,
                    fit: BoxFit.cover,
                    width: double.infinity,
                  ),
          ),
          const SizedBox(
            width: 10,
          ),
          Expanded(
            child: TextButton.icon(
              icon: const Icon(Icons.camera),
              label: const Text('Take Picture'),
              onPressed: _takePicture,
            ),
          ),
        ],
      );
}
