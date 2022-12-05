const apiKey = 'AIzaSyAiY9cmxxn9V51u0r_bVg5wy8HpkHJRb6Y';

class LocationHelper {
  static String generateLocationPreviewImage(
      {required double latitude, required double longitude}) {
    return 'https://maps.googleapis.com/maps/api/staticmap?center=$latitude,$longitude&zoom=13&size=600x500&maptype=roadmap&markers=color:red%7Clabel:S%7C$latitude,$longitude&key=$apiKey';
  }
}
