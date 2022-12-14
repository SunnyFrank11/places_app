import 'package:flutter/material.dart';
import 'package:places_app/models/place.dart';
import 'package:places_app/providers/great_places.dart';
import 'package:places_app/screens/map_screen.dart';
import 'package:provider/provider.dart';

class PlaceDetailScreen extends StatelessWidget {
  const PlaceDetailScreen({Key? key}) : super(key: key);

  static const routeName = '/detail_screen';

  @override
  Widget build(BuildContext context) {
    final id = ModalRoute.of(context)?.settings.arguments as String;
    final place = Provider.of<GreatPlaces>(context, listen: false);
    final userSelectedPlace =
        place.items.firstWhere((element) => element.id == id);
    return Scaffold(
      appBar: AppBar(
        title: Text(userSelectedPlace.title),
      ),
      body: SingleChildScrollView(
        child: Column(children: [
          Hero(
            tag: userSelectedPlace.id!,
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20), topRight: Radius.circular(20)),
              child: Image.file(
                userSelectedPlace.image!,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            height: 5,
            color: Theme.of(context).colorScheme.primary,
          ),
          Container(
            decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.secondaryContainer,
                borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20))),
            height: 120,
            width: double.infinity,
            child: Column(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  child: FittedBox(
                    child: Text(
                      userSelectedPlace.location!.address!,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  child: OutlinedButton.icon(
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(width: 2),
                      ),
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) {
                            return MapScreen(
                              initialPosition: PlaceLocation(
                                latitute: userSelectedPlace.location!.latitute,
                                longitude:
                                    userSelectedPlace.location!.longitude,
                              ),
                            );
                          },
                          fullscreenDialog: true,
                        ));
                      },
                      icon: const Icon(Icons.map_outlined),
                      label: const Text(
                        'View on map',
                        style: TextStyle(fontSize: 20),
                      )),
                )
              ],
            ),
          )
        ]),
      ),
    );
  }
}
