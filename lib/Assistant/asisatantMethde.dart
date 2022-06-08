import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

class AssistanMethds {
  String address = 'home';
  Future<void> searchCordinateAdress(Position position) async {
    List<Placemark> placemarks =
        await placemarkFromCoordinates(position.altitude, position.longitude);
    print(placemarks);
    Placemark place = placemarks[0];
    address =
        '${place.street},${place.subLocality},${place.locality},${place.postalCode},${place.country}';
  }
}
