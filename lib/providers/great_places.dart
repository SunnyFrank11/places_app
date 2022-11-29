import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:places_app/helpers/db_helper.dart';

import '../models/place.dart';

class GreatPlaces with ChangeNotifier {
  List<Place> _items = [];

  List<Place> get items {
    return [..._items.reversed];
  }

  void addPlace(String pickedTitle, File pickedImage) {
    final newPlace = Place(
        id: DateTime.now().toString(),
        title: pickedTitle,
        // location: null,
        image: pickedImage);
    _items.add(newPlace);
    notifyListeners();

    //! sqflite implemetation for saving data on device;
    DBHelper.insertData('user_places', {
      'id': newPlace.id!,
      'title': newPlace.title,
      'image': newPlace.image!.path,
      // 'location': newPlace.location!
    });
  }

  Future<void> fetchAndSetPlaces() async {
    final dataList = await DBHelper.getData('user_places');
    _items = dataList
        .map(
          (item) => Place(
            id: item['id'],
            title: item['title'],
            // location: null,
            image: File(item['image']),
          ),
        )
        .toList();
    notifyListeners();
  }

  Future<void> deletePlaces(String id) async {
    final placeId = _items.firstWhere((element) => element.id == id);
    _items.remove(placeId);

    DBHelper.removeData(id);
    notifyListeners();
  }
}
