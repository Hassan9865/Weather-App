import 'dart:convert';

import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:weather_app/pages/weather_modal/modal.dart';

class WeatherServices {
  static const base_url = "";
  final String api_key;

  WeatherServices(this.api_key);

  Future<Weather> getweather(String cityName) async {
    final Response =
        await http.get(Uri.parse('https://home.openweathermap.org/api_keys'));

    if (Response.statusCode == 200) {
      return Weather.fromJson(jsonDecode(Response.body));
    } else {
      throw Exception("failed to load weather data..");
    }
  }

  Future<String> getCurrentCity() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
    List<Placemark> Placemarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);

    String? city = Placemarks[0].locality;

    return city ?? "";
  }
}
