import 'package:flutter/material.dart';
import 'package:location/location.dart';

class LocationInput extends StatefulWidget {
  const LocationInput({Key? key}) : super(key: key);

  @override
  State<LocationInput> createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  String? _previewImageUrl;

  _getCurrentLocation() async {
    final locationData = Location.instance;
    final locData = await locationData.getLocation();
    print(locData.latitude);
    print(locData.longitude);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
              color:
                  Theme.of(context).colorScheme.errorContainer.withOpacity(0.8),
              borderRadius: BorderRadius.circular(20)),
          alignment: Alignment.center,
          height: 170,
          width: double.infinity,
          child: _previewImageUrl == null
              ? const Text(
                  'No Location chosen',
                  style: TextStyle(fontSize: 15),
                  textAlign: TextAlign.center,
                )
              : Image.network(
                  _previewImageUrl!,
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
        ),
        const SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            TextButton.icon(
                onPressed: _getCurrentLocation,
                icon: const Icon(
                  Icons.location_on,
                  size: 30,
                ),
                label: const Text(
                  'Current Location',
                  style: TextStyle(fontSize: 15),
                )),
            TextButton.icon(
                onPressed: () {},
                icon: const Icon(
                  Icons.map,
                  size: 30,
                ),
                label: const Text(
                  'Choose on Map',
                  style: TextStyle(fontSize: 15),
                ))
          ],
        )
      ],
    );
  }
}
