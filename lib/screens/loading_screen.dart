import 'package:clima/screens/location_screen.dart';
import 'package:clima/services/weather.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    super.initState();
    getLocation();
  }

  void getLocation() async {
    var weatherData = await WeatherModel().getLocationByLatAndLong();
    print('weatherData========================> $weatherData');
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return LocationScreen(networkingData: weatherData);
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: SpinKitSpinningLines(
        color: Colors.green,
        size: 100.0,
        itemCount: 10,
        // controller:
        //     AnimationController(duration: const Duration(milliseconds: 1200)),
      ),
    ));
  }
}
