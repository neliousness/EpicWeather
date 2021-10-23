import 'package:epic_weather/components/current-weather-box.dart';
import 'package:epic_weather/components/search-field.dart';
import 'package:epic_weather/components/weather-box.dart';
import 'package:epic_weather/util/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Weather extends StatefulWidget {
  static String id = "weather";
  final dynamic weatherData;

  Weather({Key? key, this.weatherData}) : super(key: key);

  @override
  _WeatherState createState() => _WeatherState();
}

class _WeatherState extends State<Weather> {
  late Map weatherData;
  late List<WeatherBox> weatherBoxes = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initMultipleCityWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: SearchField(onChanged: (v) {
                filterCityList(v);
              }),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 20.0,
                top: 20,
              ),
              child: Text(
                "Current Location",
                style: TextStyle(
                    color: klightTextColor,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
            ),
            CurrentWeatherBox(
              currentCityWeather: weatherData[kcurrentCityKey],
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 20.0,
                top: 20,
              ),
              child: Text(
                "Other Places",
                style: TextStyle(color: klightTextColor, fontSize: 18),
              ),
            ),
            Wrap(
              children: weatherBoxes,
            )
          ],
        ),
      ),
    );
  }

  initMultipleCityWeather() {
    weatherData = widget.weatherData;
    weatherData.forEach((key, value) {
      if (key != kcurrentCityKey) {
        setState(() {
          weatherBoxes.add(WeatherBox(
            key: UniqueKey(),
            currentWeather: value,
          ));
        });
      } else {
        print('this weather $value');
      }
    });
  }

  void filterCityList(String filter) {
    setState(() {
      weatherBoxes.clear();
      weatherBoxes.retainWhere((WeatherBox element) =>
          '${element.currentWeather['location']['name']}'.contains(filter));
    });
  }
}
