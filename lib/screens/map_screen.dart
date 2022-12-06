// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:places_app/models/place.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({
    Key? key,
    this.initialPosition = const PlaceLocation(
      latitute: 5.4092,
      longitude: 6.9650,
    ),
    this.isSelecting = false,
  }) : super(key: key);

  final PlaceLocation initialPosition;
  final bool isSelecting;
  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  LatLng? _pickeLocation;

  void _selectLocation(LatLng position) {
    setState(() {
      _pickeLocation = position;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          if (_pickeLocation != null)
            IconButton(
                onPressed: () {
                  Navigator.of(context).pop(_pickeLocation);
                },
                icon: const Icon(Icons.check_box))
        ],
        title: const Text('Map'),
      ),
      body: GoogleMap(
        trafficEnabled: true,
        buildingsEnabled: true,
        initialCameraPosition: CameraPosition(
          zoom: 15,
          target: LatLng(widget.initialPosition.latitute,
              widget.initialPosition.longitude),
        ),
        onTap: widget.isSelecting ? _selectLocation : null,
        markers: _pickeLocation == null
            ? {}
            : {
                Marker(
                  markerId: const MarkerId('P1'),
                  position: LatLng(
                      _pickeLocation!.latitude, _pickeLocation!.longitude),
                ),
              },
      ),
    );
  }
}
