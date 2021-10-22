import 'dart:convert';

import 'package:dart_ipify/dart_ipify.dart';
import 'package:epic_weather/util/constants.dart';
import 'package:http/http.dart' as http;

class WeatherService {

    Future<dynamic> fetchSingleCityWeather(String cityId) async
    {
        var url = Uri.parse('https://example.com/whatsit/create');
        var response = await http.post(url, body: {'name': 'doodle', 'color': 'blue'});
        print('Response status: ${response.statusCode}');
        print('Response body: ${response.body}');

        print(await http.read(Uri.parse('https://example.com/foobar.txt')));
        return ;
    }

    Future<dynamic> fetchCurrentLocationWeather() async
    {
        final ipv4 = await Ipify.ipv4();
        print(ipv4);
        var url = Uri.parse('http://api.ipstack.com/$ipv4?access_key=$kIpApiKey');
        var response = await http.get(url);
       // print('Response status: ${response.statusCode}');
       // print('Response body: ${response.body}');
        var city = jsonDecode(response.body)['city'];

        var currentWeatherUrl = Uri.parse("http://api.weatherapi.com/v1/current.json?key=$kWeatherApiKey&q=$city&aqi=no");
        var currentWeatherResponse = await http.get(currentWeatherUrl);

        print('Response body: ${jsonDecode(currentWeatherResponse.body)}');
        return jsonDecode(currentWeatherResponse.body);
    }
}