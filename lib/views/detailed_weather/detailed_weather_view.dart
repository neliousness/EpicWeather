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
  late double _width;
  late double _height;
  late dynamic _cityWeather;
  late String _city;
  late String _country;
  late int _temp;
  late int _humidity;
  late int _wind;
  late String _asset;
  late String _condition;
  late int _pressure;
  late int _realFeel;
  late int _visibility;
  late int _uv;
  late String _sunrise;
  late String _sunset;
  late int _maxDayTemp;
  late int _minDayTemp;
  late List<HourForecast> _hourForecasts = [];
  bool _loading = false;
  late Animation<double> _animation;
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _cityWeather = widget.cityWeather;
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
    _width = MediaQuery.of(context).size.width;
    _height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: ScrollConfiguration(
        behavior: NoGlowScroll(),
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
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
                      height: _height / 4.0,
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
                                    '$_city',
                                    style: TextStyle(
                                        color: kLightTextColor, fontSize: 18),
                                  ),
                                  Text(
                                    '$_country',
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
                                            _temp, "circle"),
                                        child: Container(
                                          width: 10,
                                          height: 10,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(60),
                                              border: Border.all(
                                                  color: kLightTextColor,
                                                  width: 3)),
                                        ),
                                      ),
                                      Align(
                                        alignment: temperatureAlignment(
                                            _temp, "value"),
                                        child: Text(
                                          '$_temp',
                                          style: TextStyle(
                                              fontSize: 56,
                                              color: Colors.white,
                                              fontWeight: FontWeight.w400),
                                        ),
                                      ),
                                      Align(
                                        alignment:
                                            temperatureAlignment(_temp, "unit"),
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
                                    '$_condition',
                                    style: TextStyle(
                                        color: kLightTextColor, fontSize: 16),
                                  ),
                                ),
                                decoration: BoxDecoration(
                                    color: kSecondaryColor,
                                    borderRadius: BorderRadius.circular(30)),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  'Min $_minDayTemp - $_maxDayTemp Max',
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
                              Hero(
                                tag: '$_city',
                                child: SvgPicture.asset(
                                  "assets/svgs/${WeatherHelper.getWeatherAsset(_condition)}.svg",
                                  width: 160,
                                  color: kAccentColor,
                                ),
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
                      width: _width,
                      height: _height / 5.5,
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
                                    '$_sunrise',
                                    style: TextStyle(color: kLightTextColor),
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
                                    '$_sunset',
                                    style: TextStyle(color: kLightTextColor),
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
                              value: '$_pressure psi',
                              description: "Pressure",
                            ),
                            ConditionBox(
                              asset: "rf",
                              value: "$_realFeel",
                              description: "Real Feel",
                            ),
                            ConditionBox(
                              asset: "water_drop",
                              value: "$_humidity%",
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
                              value: "$_visibility km",
                              description: "Visibility",
                            ),
                            ConditionBox(
                              asset: "sun",
                              value: "$_uv",
                              description: "UV",
                            ),
                            ConditionBox(
                              asset: "wind",
                              value: "$_wind km/h",
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
                                TextStyle(color: kLightTextColor, fontSize: 14),
                          ),
                        ),
                        SizedBox(
                          width: _width,
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
            ),
            Visibility(
              visible: _loading,
              child: Align(
                alignment: Alignment.center,
                child: Container(
                  width: _width,
                  height: _height,
                  color: kPrimaryColor.withOpacity(0.7),
                  child: Icon(
                    Icons.cloud_outlined,
                    color: kTextAccentColor.withOpacity(_animation.value),
                    size: 60,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    WidgetsBinding.instance!.removeObserver(this);
    _controller.dispose();
    super.dispose();
  }

  void populateUI() {
    _temp = _cityWeather['current']['temp_c'].toInt();
    _wind = _cityWeather['current']['wind_kph'].toInt();
    _humidity = _cityWeather['current']['humidity'].toInt();
    _city = _cityWeather['location']['name'];
    _country = _cityWeather['location']['country'];
    _condition = _cityWeather['current']['condition']['text'];
    _uv = _cityWeather['current']['uv'].toInt();
    _pressure = _cityWeather['current']['pressure_in'].toInt();
    _visibility = _cityWeather['current']['vis_km'].toInt();
    _realFeel = _cityWeather['current']['feelslike_c'].toInt();
    _sunrise = _cityWeather['forecast']['forecastday'][0]['astro']['sunrise'];
    _sunset = _cityWeather['forecast']['forecastday'][0]['astro']['sunset'];
    _maxDayTemp =
        _cityWeather['forecast']['forecastday'][0]['day']['maxtemp_c'].toInt();
    _minDayTemp =
        _cityWeather['forecast']['forecastday'][0]['day']['mintemp_c'].toInt();

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

  void populateHourForCasts() {
    dynamic hourForecastArray =
        _cityWeather['forecast']['forecastday'][0]['hour'];
    hourForecastArray.forEach((element) {
      _hourForecasts.add(HourForecast(
          key: UniqueKey(),
          asset: WeatherHelper.getWeatherAsset(element['condition']['text']),
          time: element['time'],
          temp: '${element['temp_c'].toInt()}'));
    });
  }

  void updateData() async {
    setState(() {
      _loading = true;
    });
    WeatherService service = WeatherService();
    _cityWeather = await service.fetchCityLocationWeather(_city);
    setState(() {
      _hourForecasts.clear();
      populateUI();
      _loading = false;
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
    _controller =
        AnimationController(duration: const Duration(seconds: 1), vsync: this);
    _animation = Tween<double>(begin: 0.1, end: 0.9).animate(_controller);
    _controller.repeat(reverse: true);
    _animation.addListener(() {
      setState(() {});
    });
  }
}
