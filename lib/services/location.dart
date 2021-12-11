import 'package:geolocator/geolocator.dart';

class LocationData {
  Position position;
  Future<dynamic> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;
    try {
      serviceEnabled = await Geolocator.isLocationServiceEnabled();
      print("reached start of try block");
      if (!serviceEnabled) {
        print("reached start of try block");
        return Future.error('Location services are disabled.');
      }

      permission = await Geolocator.checkPermission();
      print("reached start of try block");
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          return Future.error('Location permissions are denied');
        }
      }

      if (permission == LocationPermission.deniedForever) {
        return Future.error(
            'Location permissions are permanently denied, we cannot request permissions.');
      }

      var pos = await Geolocator.getCurrentPosition(
          // forceAndroidLocationManager: true,
          desiredAccuracy: LocationAccuracy.low);
      print("reached start of try block");
      print('current position ${pos.latitude}.');
      return pos;
    } catch (e) {
      print(e);
      return e;
    }
  }
}
