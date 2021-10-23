import 'dart:convert';

import 'package:dart_ipify/dart_ipify.dart';
import 'package:epic_weather/util/constants.dart';
import 'package:epic_weather/util/weather-helper.dart';
import 'package:http/http.dart' as http;

class WeatherService {
  Future<dynamic> fetchCurrentLocationWeather() async {
    final ipv4 = await Ipify.ipv4();
    var url = Uri.parse('http://api.ipstack.com/$ipv4?access_key=$kIpApiKey');
    var response = await http.get(url);
    var city = jsonDecode(response.body)['city'];

    var currentWeatherUrl = Uri.parse(
        "http://api.weatherapi.com/v1/forecast.json?key=$kWeatherApiKey&q=$city&aqi=no");
    var currentWeatherResponse = await http.get(currentWeatherUrl);

    return jsonDecode(currentWeatherResponse.body);
  }

  Future<dynamic> fetchMultipleLocationWeather() async {
    var citiesMap = Map();
    WeatherHelper.europeanCountries.forEach((element) async {
      var currentWeatherUrl = Uri.parse(
          "http://api.weatherapi.com/v1/forecast.json?key=$kWeatherApiKey&q=$element&aqi=no");
      var currentWeatherResponse = await http.get(currentWeatherUrl);
      citiesMap['$element'] = jsonDecode(currentWeatherResponse.body);
    });
    dynamic currentLocation = await fetchCurrentLocationWeather();
    citiesMap['$kcurrentCityKey'] = currentLocation;
    return citiesMap;
  }
}
