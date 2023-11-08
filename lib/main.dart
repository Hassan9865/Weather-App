import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: WeatherApp(),
    );
  }
}

class WeatherApp extends StatefulWidget {
  @override
  _WeatherAppState createState() => _WeatherAppState();
}

class _WeatherAppState extends State<WeatherApp> {
  String apiKey = '9963003f5c7bb992b5b7e40babe3b5ef';
  String city = 'karachi'; // Change to the desired city
  String weatherDescription = '';
  double temperature = 0.0;

  void fetchWeatherData() async {
    final response = await http.get(Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?q=$city&appid=$apiKey&units=metric'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        weatherDescription = data['weather'][0]['description'];
        temperature = data['main']['temp'];
      });
    }
  }

  @override
  void initState() {
    super.initState();
    fetchWeatherData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Weather App'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'City: $city',
              style: TextStyle(fontSize: 20),
            ),
            Text(
              'Description: $weatherDescription',
              style: TextStyle(fontSize: 20),
            ),
            Text(
              'Temperature: $temperature°C',
              style: TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}
