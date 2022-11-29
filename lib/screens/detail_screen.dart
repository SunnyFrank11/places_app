import 'package:flutter/material.dart';
import 'package:places_app/providers/great_places.dart';
import 'package:provider/provider.dart';

class DetailScreen extends StatelessWidget {
  const DetailScreen({Key? key}) : super(key: key);

  static const routeName = '/detail_screen';

  @override
  Widget build(BuildContext context) {
    final id = ModalRoute.of(context)?.settings.arguments as String;
    final places = Provider.of<GreatPlaces>(context, listen: false);
    final myPlace = places.items.firstWhere((element) => element.id == id);
    return Scaffold(
      appBar: AppBar(
        title: Text(myPlace.title),
      ),
      body: Column(children: [
        Hero(
          tag: myPlace.id!,
          child: Image.file(myPlace.image!),
        ),
      ]),
    );
  }
}
