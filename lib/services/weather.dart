import 'package:clima/services/location.dart';
import 'package:clima/services/networking.dart';
import 'package:geolocator/geolocator.dart';

const appId = 'e5537820b68de308392ede6bcd23c629&units=metric';
const basUrl = 'https://api.openweathermap.org/data/2.5/weather?';

class WeatherModel {
  WeatherModel({this.weatherDatas});
  var weatherDatas;
  int id;
  String des;
  String place;

  Future<dynamic> getLocationByLatAndLong() async {
    LocationData instance = LocationData();
    Position position = await instance.determinePosition();
    print('locationData========================== $position');
    Networking networkData = await Networking(
        url:
            '${basUrl}lat=${position.latitude}&lon=${position.longitude}&appid=$appId');
    var netdata = networkData.getData();
    print('============================================================');
    print('netdata   $netdata');
    return netdata;
  }

  Future<dynamic> getLocationByCity(String cityName) async {
    // LocationData instance = LocationData();
    // Position position = await instance.determinePosition();
    // print('cityName inside whetherModel $cityName');

    Networking networkData =
        Networking(url: '${basUrl}q=${cityName}&appid=$appId');
    var netdata = await networkData.getData();
    print('networkData inside whetherModel============ $netdata');
    return netdata;
  }

  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return '🌩';
    } else if (condition < 400) {
      return '🌧';
    } else if (condition < 600) {
      return '☔️';
    } else if (condition < 700) {
      return '☃️';
    } else if (condition < 800) {
      return '🌫';
    } else if (condition == 800) {
      return '☀️';
    } else if (condition <= 804) {
      return '☁️';
    } else {
      return '🤷‍';
    }
  }

  String getMessage(int temp) {
    if (temp > 25) {
      return 'It\'s 🍦 time';
    } else if (temp > 20) {
      return 'Time for shorts and 👕';
    } else if (temp < 10) {
      return 'You\'ll need 🧣 and 🧤';
    } else {
      return 'Bring a 🧥 just in case';
    }
  }
}
