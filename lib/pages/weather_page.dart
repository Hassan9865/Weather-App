import 'package:flutter/material.dart';
import 'package:weather_app/pages/weather_modal/modal.dart';
import 'package:weather_app/pages/weather_services/service.dart';

class weatherPage extends StatefulWidget {
  const weatherPage({super.key});

  @override
  State<weatherPage> createState() => _weatherPageState();
}

class _weatherPageState extends State<weatherPage> {
  final _weatherservice = WeatherServices("9963003f5c7bb992b5b7e40babe3b5ef");
  Weather? _weather;

  _fecthweather() async {
    String cityName = await _weatherservice.getCurrentCity();

    try {
      final Weather = await _weatherservice.getweather(cityName);
      setState(() {
        _weather = Weather;
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();

    _fecthweather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(_weather?.cityName ?? "loading city"),
            Text('${_weather?.temperature.round()} C'),
          ],
        ),
      )),
    );
  }
}
