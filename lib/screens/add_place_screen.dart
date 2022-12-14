import 'dart:io';

import 'package:flutter/material.dart';
import 'package:places_app/models/place.dart';
import 'package:places_app/providers/great_places.dart';
import 'package:places_app/widget/image_input.dart';
import 'package:places_app/widget/location_input.dart';
import 'package:provider/provider.dart';

class AddPlaceScreen extends StatefulWidget {
  const AddPlaceScreen({Key? key}) : super(key: key);

  static const routeName = '/add-place';

  @override
  State<AddPlaceScreen> createState() => _AddPlaceScreenState();
}

class _AddPlaceScreenState extends State<AddPlaceScreen> {
  File? _pickedImage;
  PlaceLocation? _pickedLocation;

  final TextEditingController _titleController = TextEditingController();

  void _selectImage(File? pickedImage) {
    _pickedImage = pickedImage!;
  }

  void _notificationError() {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      padding: const EdgeInsets.all(20),
      content: const Text(
        'Your input is incomplete',
        style: TextStyle(fontSize: 18),
      ),
      backgroundColor: Theme.of(context).errorColor,
      duration: const Duration(seconds: 3),
    ));
  }

  void _selectPlace(double lat, double lng) {
    _pickedLocation = PlaceLocation(latitute: lat, longitude: lng);
  }

  void _savePlace() {
    if (_titleController.text.isEmpty ||
        _pickedImage == null ||
        _pickedLocation == null) {
      _notificationError();
      return;
    } else {
      Provider.of<GreatPlaces>(context, listen: false)
          .addPlace(_titleController.text, _pickedImage!, _pickedLocation!);
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Place'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(
            height: 10,
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    TextField(
                      // autofocus: true,
                      decoration: const InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(25),
                          ),
                          borderSide:
                              BorderSide(width: 2.0, color: Colors.green),
                        ),
                        labelText: 'Title',
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(width: 2.0),
                          borderRadius: BorderRadius.all(
                            Radius.circular(25),
                          ),
                        ),
                      ),
                      controller: _titleController,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    ImageInput(
                      onSelectImage: _selectImage,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    LocationInput(
                      onSelectPlace: _selectPlace,
                    ),
                  ],
                ),
              ),
            ),
          ),
          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              backgroundColor: Theme.of(context).colorScheme.secondary,
              padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * 0.3,
                vertical: 15,
              ),
              elevation: 0,
            ),
            onPressed: _titleController.text.isEmpty ? null : _savePlace,
            icon: Icon(
              Icons.add,
              color:
                  _titleController.text.isNotEmpty ? Colors.white : Colors.grey,
            ),
            label: Text(
              'Add Place',
              style: TextStyle(
                  fontSize: 20,
                  color: _titleController.text.isNotEmpty
                      ? Colors.white
                      : Colors.grey),
            ),
          )
        ],
      ),
    );
  }
}
