import 'package:epic_weather/screens/city-weather-details.dart';
import 'package:epic_weather/util/constants.dart';
import 'package:epic_weather/util/weather-helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class WeatherBox extends StatefulWidget {
  final dynamic currentWeather;

  const WeatherBox({Key? key, this.currentWeather}) : super(key: key);

  @override
  _WeatherBoxState createState() => _WeatherBoxState();
}

class _WeatherBoxState extends State<WeatherBox> {
  late double width;
  late double height;
  late dynamic currentWeather;
  late String city;
  late String country;
  late int temp;
  late int humidity;
  late int wind;
  late String asset;
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
                builder: (context) => CityWeatherDetails(
                      cityWeather: currentWeather,
                    )));
      },
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Container(
            height: 150,
            width: width / 2.45,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 1.0, top: 8),
                            child: Container(
                              width: 50,
                              child: Stack(
                                children: [
                                  Align(
                                    alignment:
                                        temperatureAlignment(temp, 'circle'),
                                    child: Container(
                                      width: 10,
                                      height: 10,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(60),
                                          border: Border.all(
                                              color: klightTextColor,
                                              width: 3)),
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                      '$temp',
                                      style: TextStyle(
                                          fontSize: 42,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ),
                                  Align(
                                    alignment:
                                        temperatureAlignment(temp, 'unit'),
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
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '$city, ',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 14),
                                ),
                                countryWidget(country)
                              ],
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: SvgPicture.asset(
                              "assets/svgs/${WeatherHelper.getWeatherAsset(condition)}.svg",
                              width: 50,
                              color: kAccentColor,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            "assets/svgs/water_drop.svg",
                            width: 17,
                            color: kAccentColor,
                          ),
                          Text(
                            '$humidity%',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 12),
                          )
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 4.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 4.0),
                              child: SvgPicture.asset(
                                "assets/svgs/wind.svg",
                                width: 15,
                                color: kAccentColor,
                              ),
                            ),
                            Text(
                              '$wind km/h',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            decoration: BoxDecoration(
                color: kSecondaryColor,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: kAccentColor, width: 1))),
      ),
    );
  }

  init() {
    currentWeather = widget.currentWeather;
    temp = currentWeather['current']['temp_c'].toInt();
    wind = currentWeather['current']['wind_kph'].toInt();
    humidity = currentWeather['current']['humidity'].toInt();
    city = currentWeather['location']['name'];
    country = currentWeather['location']['country'];
    condition = currentWeather['current']['condition']['text'];
  }

  Widget countryWidget(String name) {
    var nameArray = name.split(" ");
    if (nameArray.length == 2) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${nameArray[0]}',
            style: TextStyle(color: kfadeTextColor, fontSize: 14),
          ),
          Text(
            '${nameArray[1]}',
            style: TextStyle(color: kfadeTextColor, fontSize: 14),
          )
        ],
      );
    }
    return Text(
      '$name',
      style: TextStyle(color: kfadeTextColor, fontSize: 14),
    );
  }

  Alignment temperatureAlignment(int temp, String mode) {
    if (mode == "circle") {
      if (temp < 10) {
        return Alignment(0.4, 0);
      }
      return Alignment(1.5, -0.7);
    } else if (mode == 'value') {
      if (temp < 10) {
        return Alignment(0, 0);
      }
      return Alignment(0, -0.7);
    } else {
      if (temp < 10) {
        return Alignment(1.3, 0);
      }
      return Alignment(2.6, -0.5);
    }
  }
}
