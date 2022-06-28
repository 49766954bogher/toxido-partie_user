import 'package:geolocator/geolocator.dart';

Future<Position> _determinePosition() async {
  bool serviceEnabled;
  LocationPermission permission;

  // Test if location services are enabled.
  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    return Future.error('Servive de localisation est descativée!');
  }

  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      return Future.error('Servive de localisation est refusée!');
    }
  }

  if (permission == LocationPermission.deniedForever) {
    return Future.error(
        'Servive de localisation est refusée!, on peut plus accedée a votre position.');
  }

  return await Geolocator.getCurrentPosition();
}
