import 'dart:convert';

import 'package:http/http.dart' as http;

const apiKey = 'AIzaSyAiY9cmxxn9V51u0r_bVg5wy8HpkHJRb6Y';

class LocationHelper {
  static String generateLocationPreviewImage(
      {required double latitude, required double longitude}) {
    return 'https://maps.googleapis.com/maps/api/staticmap?center=$latitude,$longitude&zoom=16&size=600x500&maptype=roadmap&markers=color:red%7Alabel:S%7C$latitude,$longitude&key=$apiKey';
  }

  static Future<String> getPlaceAddress({double? lat, double? lng}) async {
    final url =
        'https://maps.googleapis.com/maps/api/geocode/json?latlng=$lat,$lng&key=$apiKey';
    var mapUrl = Uri.parse(url);
    final response = await http.get(mapUrl);
    final address =
        jsonDecode(response.body)['results'][0]['formatted_address'];
    return address;
  }
}
