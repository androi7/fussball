import 'package:geocode/geocode.dart';
import 'package:location/location.dart';

class LocationService {
  Future<String?> erhalteLandName() async {
    Location location = Location();

    bool serviceEnabled;
    PermissionStatus permissionGranted;
    LocationData locationData;

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return null;
      }
    }

    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return null;
      }
    }

    locationData = await location.getLocation();

    GeoCode geoCode = GeoCode();

    try {
      if (locationData.latitude != null && locationData.longitude != null) {
        var address = await geoCode.reverseGeocoding(
            latitude: locationData.latitude!,
            longitude: locationData.longitude!);

        return address.countryCode;
      } else {
        return null;
      }
    } catch (e) {
      print(e);
    }
  }
}
