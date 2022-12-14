import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:places_app/helpers/location_helper.dart';
import 'package:places_app/screens/map_screen.dart';

class LocationInput extends StatefulWidget {
  const LocationInput({Key? key, required this.onSelectPlace})
      : super(key: key);
  final Function onSelectPlace;
  @override
  State<LocationInput> createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  String? _previewImageUrl;

  void _showPreview({double? lat, double? lng}) {
    final currentLocationUrl = LocationHelper.generateLocationPreviewImage(
      latitude: lat!,
      longitude: lng!,
    );
    setState(() {
      _previewImageUrl = currentLocationUrl;
    });
  }

  Future<void> _getCurrentLocation() async {
    try {
      final locationData = Location(); //! this is from the location package
      final locData = await locationData.getLocation();

      _showPreview(lat: locData.latitude, lng: locData.latitude);
      widget.onSelectPlace(locData.latitude, locData.longitude);
    } catch (error) {
      return;
    }
  }

  Future<void> _selectOnMap() async {
    final LatLng? selectedLocation = await Navigator.of(context).push<LatLng>(
      MaterialPageRoute(
        fullscreenDialog: true,
        builder: ((context) => const MapScreen(isSelecting: true)),
      ),
    );
    if (selectedLocation == null) {
      return;
    }
    _showPreview(
        lat: selectedLocation.latitude, lng: selectedLocation.longitude);
    widget.onSelectPlace(selectedLocation.latitude, selectedLocation.longitude);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
              border: Border.all(width: 2.0),
              color: Theme.of(context)
                  .colorScheme
                  .primaryContainer
                  .withOpacity(0.5),
              borderRadius: BorderRadius.circular(20)),
          alignment: Alignment.center,
          height: 250,
          width: double.infinity,
          child: _previewImageUrl == null
              ? const Text(
                  'No Location chosen',
                  style: TextStyle(fontSize: 15),
                  textAlign: TextAlign.center,
                )
              : ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(20)),
                  child: FadeInImage.assetNetwork(
                    placeholderFit: BoxFit.contain,
                    image: _previewImageUrl!,
                    placeholder: 'assets/images/map-icon.png',
                    fit: BoxFit.cover,
                    width: double.infinity,
                  ),
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
                  Icons.location_on_outlined,
                  size: 30,
                ),
                label: const Text('Current Location',
                    style: TextStyle(fontSize: 15))),
            TextButton.icon(
                onPressed: _selectOnMap,
                icon: const Icon(
                  Icons.map_outlined,
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
