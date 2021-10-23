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
  late double width;
  late double height;
  late dynamic currentCityWeather;

  late int temp;
  late int humidity;
  late int realFeel;
  late int wind;
  late String city;
  late String country;
  late String condition;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    init();
  }

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    DetailedWeatherView(cityWeather: currentCityWeather)));
      },
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Container(
            height: 150,
            width: width,
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
                            '$city, ',
                            style: TextStyle(color: Colors.white, fontSize: 14),
                          ),
                          Text(
                            '$country',
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
                        tag: '$city',
                        child: SvgPicture.asset(
                          "assets/svgs/${WeatherHelper.getWeatherAsset(condition)}.svg",
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
                              alignment: temperatureAlignment(temp, "circle"),
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
                                '$temp',
                                style: TextStyle(
                                    fontSize: 46,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w400),
                              ),
                            ),
                            Align(
                              alignment: temperatureAlignment(temp, "unit"),
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
                                '$humidity%',
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
                                '$realFeel',
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
                                '$wind km/h',
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

  init() {
    currentCityWeather = widget.currentCityWeather;
    temp = currentCityWeather['current']['temp_c'].toInt();
    wind = currentCityWeather['current']['wind_kph'].toInt();
    realFeel = currentCityWeather['current']['feelslike_c'].toInt();
    humidity = currentCityWeather['current']['humidity'].toInt();
    city = currentCityWeather['location']['name'];
    country = currentCityWeather['location']['country'];
    condition = currentCityWeather['current']['condition']['text'];
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
