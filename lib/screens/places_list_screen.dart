import 'package:flutter/material.dart';
import 'package:places_app/providers/great_places.dart';
import 'package:places_app/screens/add_place_screen.dart';
import 'package:places_app/screens/detail_screen.dart';
import 'package:provider/provider.dart';

class PlacesListScreen extends StatelessWidget {
  static const String routeName = '/places_list_screen';
  const PlacesListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Your place',
        ),
        actions: [
          IconButton(
            padding: const EdgeInsets.only(right: 25),
            onPressed: () {
              Navigator.of(context).pushNamed(AddPlaceScreen.routeName);
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: FutureBuilder(
        future: Provider.of<GreatPlaces>(context, listen: false)
            .fetchAndSetPlaces(),
        builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return Consumer<GreatPlaces>(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('You have not added any place yet.\n Add some?',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Colors.red)),
                    const SizedBox(
                      height: 20,
                    ),
                    OutlinedButton(
                      style: OutlinedButton.styleFrom(
                          side: const BorderSide(width: 2),
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 20),
                          shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)))),
                      onPressed: (() {
                        Navigator.of(context)
                            .pushNamed(AddPlaceScreen.routeName);
                      }),
                      child: const Text(
                        'Add New Place',
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                  ],
                ),
              ),
              builder: (context, greatPlaces, ch) {
                return greatPlaces.items.isEmpty
                    ? ch!
                    : ListView.builder(
                        key: ValueKey(greatPlaces.items),
                        physics: const BouncingScrollPhysics(),
                        itemCount: greatPlaces.items.length,
                        itemBuilder: (context, i) {
                          return Card(
                            child: ListTile(
                              contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 10),
                              leading: Hero(
                                tag: greatPlaces.items[i].id!,
                                child: CircleAvatar(
                                  maxRadius: 30,
                                  backgroundImage: FileImage(
                                    greatPlaces.items[i].image!,
                                  ),
                                ),
                              ),
                              title: Text(
                                  greatPlaces.items[i].title.toUpperCase()),
                              trailing: IconButton(
                                icon: Icon(
                                  Icons.delete_sharp,
                                  size: 30,
                                  color: Theme.of(context).errorColor,
                                ),
                                onPressed: () {
                                  showDialog(
                                      context: context,
                                      builder: ((context) {
                                        return AlertDialog(
                                          title: const Text('Delete Place?'),
                                          content: const Text(
                                              'Do you want to delete this place from you list'),
                                          actions: [
                                            TextButton(
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                },
                                                child: const Text('NO')),
                                            TextButton(
                                                onPressed: () {
                                                  greatPlaces.deletePlaces(
                                                      greatPlaces.items[i].id!);

                                                  Navigator.of(context).pop();
                                                },
                                                child: const Text('YES'))
                                          ],
                                        );
                                      }));
                                },
                              ),
                              onTap: (() {
                                Navigator.of(context).pushNamed(
                                    DetailScreen.routeName,
                                    arguments: greatPlaces.items[i].id);
                              }),
                            ),
                          );
                        },
                      );
              },
            );
          }
        },
      ),
    );
  }
}
