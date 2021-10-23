import 'package:epic_weather/configs/scroll-behaviour.dart';
import 'package:epic_weather/services/weather-service.dart';
import 'package:epic_weather/util/constants.dart';
import 'package:epic_weather/util/weather-helper.dart';
import 'package:epic_weather/views/detailed_weather/components/condition_box.dart';
import 'package:epic_weather/views/detailed_weather/components/day_night_line.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'components/hour_forecast_box.dart';

/// Author Nelio Lucas
/// Date 10/23/2021

class DetailedWeatherView extends StatefulWidget {
  static String id = "city_weather_details";
  final dynamic cityWeather;

  const DetailedWeatherView({Key? key, this.cityWeather}) : super(key: key);

  @override
  _DetailedWeatherViewState createState() => _DetailedWeatherViewState();
}

class _DetailedWeatherViewState extends State<DetailedWeatherView>
    with WidgetsBindingObserver, SingleTickerProviderStateMixin {
  late double width;
  late double height;
  late dynamic cityWeather;
  late String city;
  late String country;
  late int temp;
  late int humidity;
  late int wind;
  late String asset;
  late String condition;
  late int pressure;
  late int realFeel;
  late int visibility;
  late int uv;
  late String sunrise;
  late String sunset;
  late int maxDayTemp;
  late int minDayTemp;
  late List<HourForecast> _hourForecasts = [];
  bool loading = false;
  late Animation<double> animation;
  late AnimationController controller;

  @override
  void initState() {
    super.initState();
    cityWeather = widget.cityWeather;
    WidgetsBinding.instance!.addObserver(this);
    populateUI();
    initAnimation();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      checkNetwork();
    }
  }

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: ScrollConfiguration(
        behavior: NoGlowScroll(),
        child: SingleChildScrollView(
          child: Stack(
            children: [
              Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  //back navigation
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Padding(
                      padding:
                          const EdgeInsets.only(left: 15.0, top: 25, bottom: 5),
                      child: Row(
                        children: [
                          Icon(
                            Icons.arrow_back,
                            size: 30,
                            color: kAccentColor,
                          )
                        ],
                      ),
                    ),
                  ),
                  //weather degrees
                  Padding(
                    padding: const EdgeInsets.only(top: 5.0),
                    child: SizedBox(
                      height: height / 4.0,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              //city and country
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '$city',
                                    style: TextStyle(
                                        color: klightTextColor, fontSize: 18),
                                  ),
                                  Text(
                                    '$country',
                                    style: TextStyle(
                                        color:
                                            kTextAccentColor.withOpacity(0.7)),
                                  ),
                                ],
                              ),
                              //degrees
                              Padding(
                                padding:
                                    const EdgeInsets.only(right: 1.0, top: 30),
                                child: Container(
                                  width: 70,
                                  child: Stack(
                                    children: [
                                      Align(
                                        alignment: temperatureAlignment(
                                            temp, "circle"),
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
                                        alignment:
                                            temperatureAlignment(temp, "value"),
                                        child: Text(
                                          '$temp',
                                          style: TextStyle(
                                              fontSize: 56,
                                              color: Colors.white,
                                              fontWeight: FontWeight.w400),
                                        ),
                                      ),
                                      Align(
                                        alignment:
                                            temperatureAlignment(temp, "unit"),
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
                              //condition description
                              Container(
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 16.0, right: 16, top: 6, bottom: 6),
                                  child: Text(
                                    '$condition',
                                    style: TextStyle(
                                        color: klightTextColor, fontSize: 16),
                                  ),
                                ),
                                decoration: BoxDecoration(
                                    color: kSecondaryColor,
                                    borderRadius: BorderRadius.circular(30)),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  'Min $minDayTemp - $maxDayTemp Max',
                                  style: TextStyle(
                                      color: Color(0xffADCDFE).withOpacity(0.7),
                                      fontSize: 12),
                                ),
                              )
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              SvgPicture.asset(
                                "assets/svgs/${WeatherHelper.getWeatherAsset(condition)}.svg",
                                width: 160,
                                color: kAccentColor,
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  //day and night
                  Padding(
                    padding: const EdgeInsets.only(top: 50.0),
                    child: SizedBox(
                      width: width,
                      height: height / 5.5,
                      child: Stack(
                        children: [
                          Align(
                            alignment: Alignment(-1, -1.4),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                SvgPicture.asset(
                                  "assets/svgs/sunrise.svg",
                                  width: 25,
                                  color: kAccentColor,
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    '$sunrise',
                                    style: TextStyle(color: klightTextColor),
                                  ),
                                )
                              ],
                            ),
                          ),
                          Align(
                              alignment: Alignment.center,
                              child: DayNightLine()),
                          Align(
                            alignment: Alignment(1, 0.4),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                SvgPicture.asset(
                                  "assets/svgs/sunset.svg",
                                  width: 25,
                                  color: kAccentColor,
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    '$sunset',
                                    style: TextStyle(color: klightTextColor),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  //weather specifics
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 8.0, right: 8.0, top: 0.0, bottom: 8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ConditionBox(
                              asset: "preasure",
                              value: '$pressure psi',
                              description: "Pressure",
                            ),
                            ConditionBox(
                              asset: "rf",
                              value: "$realFeel",
                              description: "Real Feel",
                            ),
                            ConditionBox(
                              asset: "water_drop",
                              value: "$humidity%",
                              description: "Humidity",
                            ),
                          ],
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ConditionBox(
                              asset: "visibility",
                              value: "$visibility km",
                              description: "Visibility",
                            ),
                            ConditionBox(
                              asset: "sun",
                              value: "$uv",
                              description: "UV",
                            ),
                            ConditionBox(
                              asset: "wind",
                              value: "$wind km/h",
                              description: "Wind",
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  //week weather
                  Padding(
                    padding: const EdgeInsets.only(top: 0.0, bottom: 0.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 2, left: 13),
                          child: Text(
                            'Hourly Forecast',
                            style:
                                TextStyle(color: klightTextColor, fontSize: 14),
                          ),
                        ),
                        SizedBox(
                          width: width,
                          height: 120,
                          child: ScrollConfiguration(
                            behavior: NoGlowScroll(),
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: _hourForecasts.length,
                              itemBuilder: (c, index) {
                                return _hourForecasts[index];
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
              Visibility(
                visible: loading,
                child: Align(
                  alignment: Alignment.center,
                  child: Container(
                    width: width,
                    height: height,
                    color: kPrimaryColor.withOpacity(0.7),
                    child: Icon(
                      Icons.cloud_outlined,
                      color: kTextAccentColor.withOpacity(animation.value),
                      size: 60,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    WidgetsBinding.instance!.removeObserver(this);
    controller.dispose();
    super.dispose();
  }

  populateUI() {
    temp = cityWeather['current']['temp_c'].toInt();
    wind = cityWeather['current']['wind_kph'].toInt();
    humidity = cityWeather['current']['humidity'].toInt();
    city = cityWeather['location']['name'];
    country = cityWeather['location']['country'];
    condition = cityWeather['current']['condition']['text'];
    uv = cityWeather['current']['uv'].toInt();
    pressure = cityWeather['current']['pressure_in'].toInt();
    visibility = cityWeather['current']['vis_km'].toInt();
    realFeel = cityWeather['current']['feelslike_c'].toInt();
    sunrise = cityWeather['forecast']['forecastday'][0]['astro']['sunrise'];
    sunset = cityWeather['forecast']['forecastday'][0]['astro']['sunset'];
    maxDayTemp =
        cityWeather['forecast']['forecastday'][0]['day']['maxtemp_c'].toInt();
    minDayTemp =
        cityWeather['forecast']['forecastday'][0]['day']['mintemp_c'].toInt();

    populateHourForCasts();
  }

  Alignment temperatureAlignment(int temp, String mode) {
    if (mode == "circle") {
      if (temp < 10) {
        return Alignment(0.7, 0);
      }
      return Alignment(1.2, -0.7);
    } else if (mode == 'value') {
      if (temp < 10) {
        return Alignment(0, 0);
      }
      return Alignment(0, -0.7);
    } else {
      if (temp < 10) {
        return Alignment(1.3, 0);
      }
      return Alignment(1.9, -0.5);
    }
  }

  populateHourForCasts() {
    dynamic hourForecastArray =
        cityWeather['forecast']['forecastday'][0]['hour'];
    hourForecastArray.forEach((element) {
      _hourForecasts.add(HourForecast(
          key: UniqueKey(),
          asset: WeatherHelper.getWeatherAsset(element['condition']['text']),
          time: element['time'],
          temp: '${element['temp_c'].toInt()}'));
    });
  }

  updateData() async {
    setState(() {
      loading = true;
    });
    WeatherService service = WeatherService();
    cityWeather = await service.fetchCityLocationWeather(city);
    setState(() {
      _hourForecasts.clear();
      populateUI();
      loading = false;
    });
  }

  void checkNetwork() async {
    bool isDeviceConnected = await WeatherHelper.hasNetwork();
    if (isDeviceConnected) {
      print('Connected here $isDeviceConnected');
      updateData();
    }
  }

  void initAnimation() {
    controller =
        AnimationController(duration: const Duration(seconds: 1), vsync: this);
    animation = Tween<double>(begin: 0.1, end: 0.9).animate(controller);
    controller.repeat(reverse: true);
    animation.addListener(() {
      setState(() {});
    });
  }
}
