import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../widgets/weather_info.dart';

class WeatherScreenContent extends StatefulWidget {
  @override
  _WeatherScreenContentState createState() => _WeatherScreenContentState();
}

class _WeatherScreenContentState extends State<WeatherScreenContent> {
  Location location = Location();
  String apiKey = 'd6252210c5c5d0de96584180e2e59732';
  double? latitude;
  double? longitude;
  String cityName = '';
  String mainWeather = '';
  String weatherDescription = '';
  double temperature = 0;
  double humidity = 0;
  String weatherIconUrl = '';
  String mainWeatherImageUrl = ''; // Replace with the actual image URL

  @override
  void initState() {
    super.initState();
    getLocationAndWeather();
  }

  Future<void> getLocationAndWeather() async {
    LocationData locationData = await location.getLocation();
    latitude = locationData.latitude!;
    longitude = locationData.longitude!;

    await fetchWeatherData();
  }

  Future<void> fetchWeatherData() async {
    final response = await http.get(
      Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?lat=$latitude&lon=$longitude&appid=$apiKey',
      ),
    );

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      final iconCode = jsonData['weather'][0]['icon'];
      cityName = jsonData['name'];
      mainWeather = jsonData['weather'][0]['main'];
      weatherDescription = jsonData['weather'][0]['description'];
      temperature = jsonData['main']['temp'];
      humidity = jsonData['main']['humidity'];
      weatherIconUrl = 'http://openweathermap.org/img/w/$iconCode.png';
      mainWeatherImageUrl = 'https://cdn-icons-png.flaticon.com/512/4834/4834559.png';

      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    double celsiusTemperature = temperature - 273;

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFF396afc),
            Color(0xFF2948ff),
          ],
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            cityName,
            style: TextStyle(fontSize: 32, color: Colors.white),
          ),
          SizedBox(height: 16),
          if (weatherIconUrl.isNotEmpty)
            GridView.count(
              crossAxisCount: 2, 
              shrinkWrap: true,
              children: [
                buildWeatherInfoBox('Main Weather', Image.network(mainWeatherImageUrl,width: 50,), null),
                Center(
                  child: buildWeatherInfoBox(
                    'Description',
                    Center(
                      child: Center(
                        child: Row(
                          children: [
                            Image.network(weatherIconUrl, width: 30, height: 30),
                            SizedBox(width: 8),
                            Text(
                              weatherDescription,
                              style: TextStyle(fontSize: 18, color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    ),
                    null,
                  ),
                ),
                buildWeatherInfoBox(
                  'Temperature',
                  Text(
                    '${celsiusTemperature.toStringAsFixed(1)}°C',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                  Icons.thermostat,
                ),
                buildWeatherInfoBox(
                  'Humidity',
                  Text(
                    '${humidity.toStringAsFixed(1)}%',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                  Icons.opacity,
                ),
              ],
            ),
        ],
      ),
    );
  }

 
}