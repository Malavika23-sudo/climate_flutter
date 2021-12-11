import 'package:clima/screens/city_screen.dart';
import 'package:flutter/material.dart';
import 'package:clima/utilities/constants.dart';
import 'package:clima/services/weather.dart';
import 'package:geolocator/geolocator.dart';

class LocationScreen extends StatefulWidget {
  var networkingData;
  LocationScreen({this.networkingData});
  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  dynamic id;
  var test;
  double temp;
  String place;
  Position position;

  @override
  void initState() {
    updateUI(widget.networkingData);
  }

  void updateUI(var weatherData) {
    setState(() {
      id = weatherData["weather"][0]['id'];
      print('id=================> $id');
      temp = weatherData["main"]['temp'];
      print('temperature=================> $temp');
      place = weatherData["name"];
      print('place=================> $place');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/location_background.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.8), BlendMode.dstATop),
          ),
        ),
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    MaterialButton(
                      onPressed: () async {
                        var weatherData = WeatherModel();

                        var locationData =
                            await weatherData.getLocationByLatAndLong();
                        print(
                            'Whether of current location========================== $locationData');
                        updateUI(locationData);
                      },
                      child: Icon(
                        Icons.near_me,
                        size: 50.0,
                      ),
                    ),
                    MaterialButton(
                      onPressed: () async {
                        print('city icon pressed');
                        var cityTitle = await Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return CityScreen();
                        }));
                        print('cityTitle $cityTitle');
                        if (cityTitle != null) {
                          var networkData = await WeatherModel()
                              .getLocationByCity(cityTitle.toString());
                          print(
                              'networkData inside location screen $networkData');
                          updateUI(networkData);
                        }
                      },
                      child: Icon(
                        Icons.location_city,
                        size: 50.0,
                      ),
                    ),
                  ],
                ),
                Text(
                  WeatherModel().getMessage(temp.toInt()),
                  style: MessageTextStyle,
                ),
                // Container(
                //   color: Colors.amber,
                // ),
                // SizedBox(),
                Text(
                  temp.toString(),
                  style: kConditionTextStyle,
                ),
                Padding(
                  padding: EdgeInsets.only(right: 15.0),
                  child: Text(
                    "It's ${WeatherModel().getWeatherIcon(id)} time in $place",
                    textAlign: TextAlign.right,
                    style: kMessageTextStyle,
                  ),
                ),
                SizedBox(
                  height: 30,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
