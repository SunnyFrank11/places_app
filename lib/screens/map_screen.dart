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
        centerTitle: true,
        title: const Text('Map'),
      ),
      body: Stack(children: [
        GoogleMap(
          trafficEnabled: true,
          buildingsEnabled: true,
          initialCameraPosition: CameraPosition(
            zoom: 16,
            target: LatLng(
              widget.initialPosition.latitute,
              widget.initialPosition.longitude,
            ),
          ),
          onTap: widget.isSelecting ? _selectLocation : null,
          markers: _pickeLocation == null
              ? {}
              : {
                  Marker(
                    markerId: const MarkerId('P1'),
                    position: LatLng(
                      _pickeLocation!.latitude,
                      _pickeLocation!.longitude,
                    ),
                  ),
                },
        ),
        Positioned(
          // height: 45,
          bottom: 50,
          left: 120,
          child: _pickeLocation == null
              ? Container()
              : ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop(_pickeLocation);
                  },
                  style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Theme.of(context)
                          .colorScheme
                          .secondary
                          .withOpacity(0.5)),
                  child: const Text('COMFIRM LOCATION'),
                ),
        ),
      ]),
    );
  }
}
