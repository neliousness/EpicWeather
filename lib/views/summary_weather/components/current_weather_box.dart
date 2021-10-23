import 'package:epic_weather/util/constants.dart';
import 'package:epic_weather/util/weather-helper.dart';
import 'package:epic_weather/views/detailed_weather/detailed_weather_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

/// Author Nelio Lucas
/// Date 10/22/2021

class CurrentWeatherBox extends StatefulWidget {
  final dynamic currentCityWeather;

  CurrentWeatherBox({Key? key, this.currentCityWeather}) : super(key: key);

  @override
  _CurrentWeatherBoxState createState() => _CurrentWeatherBoxState();
}

class _CurrentWeatherBoxState extends State<CurrentWeatherBox> {
  late double _width;
  late dynamic _currentCityWeather;
  late int _temp;
  late int _humidity;
  late int _realFeel;
  late int _wind;
  late String _city;
  late String _country;
  late String _condition;

  @override
  void initState() {
    super.initState();
    populateUI();
  }

  @override
  Widget build(BuildContext context) {
    _width = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    DetailedWeatherView(cityWeather: _currentCityWeather)));
      },
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Container(
            height: 150,
            width: _width,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 16.0, left: 14.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.location_on,
                            color: Colors.white,
                            size: 16,
                          ),
                          Text(
                            '$_city, ',
                            style: TextStyle(color: Colors.white, fontSize: 14),
                          ),
                          Text(
                            '$_country',
                            style: TextStyle(
                                color: kTextAccentColor.withOpacity(0.7),
                                fontSize: 14),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Hero(
                        tag: '$_city',
                        child: SvgPicture.asset(
                          "assets/svgs/${WeatherHelper.getWeatherAsset(_condition)}.svg",
                          width: 90,
                          color: kAccentColor,
                        ),
                      ),
                    )
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 10.0, top: 8),
                      child: Container(
                        width: 100,
                        height: 100,
                        child: Stack(
                          children: [
                            Align(
                              alignment: temperatureAlignment(_temp, "circle"),
                              child: Container(
                                width: 10,
                                height: 10,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(60),
                                    border: Border.all(
                                        color: kLightTextColor, width: 3)),
                              ),
                            ),
                            Align(
                              alignment: Alignment.center,
                              child: Text(
                                '$_temp',
                                style: TextStyle(
                                    fontSize: 46,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w400),
                              ),
                            ),
                            Align(
                              alignment: temperatureAlignment(_temp, "unit"),
                              child: Text(
                                'C',
                                style: TextStyle(
                                    fontSize: 22,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w400),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 12.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          //chance of rain
                          Row(
                            children: [
                              SvgPicture.asset(
                                "assets/svgs/water_drop.svg",
                                width: 25,
                                color: kAccentColor,
                              ),
                              Text(
                                '$_humidity%',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14),
                              )
                            ],
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(right: 4.0),
                                child: Text(
                                  'RF',
                                  style: TextStyle(
                                      color: kAccentColor,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14),
                                ),
                              ),
                              Text(
                                '$_realFeel',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14),
                              )
                            ],
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(right: 4.0),
                                child: SvgPicture.asset(
                                  "assets/svgs/wind.svg",
                                  width: 20,
                                  color: kAccentColor,
                                ),
                              ),
                              Text(
                                '$_wind km/h',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14),
                              )
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                )
              ],
            ),
            decoration: BoxDecoration(
                color: kSecondaryColor,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: kAccentColor, width: 1))),
      ),
    );
  }

  void populateUI() {
    _currentCityWeather = widget.currentCityWeather;
    _temp = _currentCityWeather['current']['temp_c'].toInt();
    _wind = _currentCityWeather['current']['wind_kph'].toInt();
    _realFeel = _currentCityWeather['current']['feelslike_c'].toInt();
    _humidity = _currentCityWeather['current']['humidity'].toInt();
    _city = _currentCityWeather['location']['name'];
    _country = _currentCityWeather['location']['country'];
    _condition = _currentCityWeather['current']['condition']['text'];
  }

  Alignment temperatureAlignment(int temp, String mode) {
    if (mode == "circle") {
      if (temp < 10) {
        return Alignment(0.5, -0.5);
      }
      return Alignment(0.6, -0.55);
    } else if (mode == 'value') {
      if (temp < 10) {
        return Alignment(0, 0);
      }
      return Alignment(0, -0.7);
    } else {
      if (temp < 10) {
        return Alignment(1.0, -0.3);
      }
      return Alignment(1.1, -0.5);
    }
  }
}
