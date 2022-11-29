import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as syspath;

class ImageInput extends StatefulWidget {
  const ImageInput({Key? key, required this.onSelectImage}) : super(key: key);

  final Function onSelectImage;

  @override
  State<ImageInput> createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  File? _storedImage;

  Future<void> _takePicture() async {
    final picker = ImagePicker();
    final XFile? imageFile = await picker.pickImage(
      source: ImageSource.camera,
      imageQuality: 100,
    );
    if (imageFile == null) {
      return;
    }
    setState(() {
      _storedImage = File(imageFile.path);
    });

    final appDir = await syspath.getApplicationDocumentsDirectory();
    //! gets the directory or folder in the sysetem where the file is saved
    final fileName = path.basename(_storedImage!.path);
    //! gets the name of the file is saved with;
    final savedImage = await _storedImage!.copy('${appDir.path}/$fileName');
    //! saves a copy of the file to directory with the name;
    // print(_storedImage);
    widget.onSelectImage(savedImage);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          height: 150,
          width: 150,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(22)),
            border: Border.all(
              width: 2.5,
            ),
          ),
          alignment: Alignment.center,
          child: _storedImage != null
              ? Stack(children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(19),
                    ),
                    child: Image.file(
                      _storedImage!,
                      fit: BoxFit.cover,
                      width: double.infinity,
                    ),
                  ),
                  Positioned(
                    top: -5,
                    left: 95,
                    child: SizedBox(
                      child: IconButton(
                        iconSize: 40,
                        icon: Icon(
                          Icons.cancel_outlined,
                          color: Theme.of(context).errorColor,
                        ),
                        onPressed: () {
                          setState(() {
                            _storedImage = null;
                          });
                        },
                      ),
                    ),
                  )
                ])
              : const Text(
                  'No Image taken',
                  textAlign: TextAlign.center,
                ),
        ),
        const SizedBox(
          width: 10,
        ),
        Expanded(
          child: ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.secondary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0),
              ),
              padding: const EdgeInsets.all(15),
            ),
            onPressed: _takePicture,
            icon: const Icon(
              Icons.camera_alt_outlined,
              color: Colors.white,
              size: 30,
            ),
            label: const Text(
              'Take Picture',
              style: TextStyle(
                fontSize: 16,
                color: Colors.white,
              ),
            ),
          ),
        )
      ],
    );
  }
}
