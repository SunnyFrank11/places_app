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
      body: Stack(
        alignment: Alignment.center,
        children: [
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
            //! if the map screen is on preview mode vs select mode
            markers: (_pickeLocation == null && widget.isSelecting)
                ? {}
                : {
                    Marker(
                      markerId: const MarkerId('P1'),
                      position: _pickeLocation ??
                          LatLng(widget.initialPosition.latitute,
                              widget.initialPosition.longitude),
                    ),
                  },
          ),
          Positioned(
            bottom: 30,
            child: _pickeLocation == null
                ? Container()
                : ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop(_pickeLocation);
                    },
                    style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor:
                            Theme.of(context).colorScheme.secondary),
                    child: const Text('COMFIRM LOCATION'),
                  ),
          ),
        ],
      ),
    );
  }
}
