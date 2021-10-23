import 'package:epic_weather/views/summary_weather/components/current_weather_box.dart';
import 'package:epic_weather/views/summary_weather/components/search_field.dart';
import 'package:epic_weather/views/summary_weather/components/weather_box.dart';
import 'package:epic_weather/configs/scroll-behaviour.dart';
import 'package:epic_weather/services/weather-service.dart';
import 'package:epic_weather/util/constants.dart';
import 'package:epic_weather/util/weather-helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// Author Nelio Lucas
/// Date 10/22/2021

class SummaryWeatherView extends StatefulWidget {
  static String id = "weather";
  final dynamic weatherData;

  SummaryWeatherView({Key? key, this.weatherData}) : super(key: key);

  @override
  _SummaryWeatherViewState createState() => _SummaryWeatherViewState();
}

class _SummaryWeatherViewState extends State<SummaryWeatherView>
    with WidgetsBindingObserver, SingleTickerProviderStateMixin {
  late Map weatherData;
  late List<WeatherBox> weatherBoxes = [];
  late CurrentWeatherBox _currentWeatherBox;
  late double width;
  late double height;
  late Animation<double> animation;
  late AnimationController controller;
  bool loading = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addObserver(this);
    weatherData = widget.weatherData;
    populateMultipleCityWeather();
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
                          color: kLightTextColor,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  _currentWeatherBox,
                  Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 20.0,
                          top: 10,
                        ),
                        child: Text(
                          "Other cities",
                          style:
                              TextStyle(color: kLightTextColor, fontSize: 18),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: SizedBox(
                          height: MediaQuery.of(context).size.height,
                          child: GridView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: weatherBoxes.length,
                            gridDelegate:
                                new SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2),
                            itemBuilder: (BuildContext context, int index) {
                              return weatherBoxes[index];
                            },
                          ),
                        ),
                      ),
                    ],
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
    super.dispose();
  }

  void populateMultipleCityWeather() {
    weatherData.forEach((key, value) {
      if (key != kCurrentCityMapKey) {
        setState(() {
          weatherBoxes.add(WeatherBox(
            key: UniqueKey(),
            currentWeather: value,
          ));
        });
      } else {
        setState(() {
          _currentWeatherBox = CurrentWeatherBox(
            key: UniqueKey(),
            currentCityWeather: weatherData[kCurrentCityMapKey],
          );
        });
      }
    });
  }

  void filterCityList(String filter) {
    setState(() {
      weatherBoxes.clear();
      weatherData.forEach((key, value) {
        if (key != kCurrentCityMapKey &&
            key.toLowerCase().contains(filter.toLowerCase()) &&
            filter.length > 0) {
          weatherBoxes.add(WeatherBox(
            key: UniqueKey(),
            currentWeather: value,
          ));
        } else if (key != kCurrentCityMapKey && filter.length == 0) {
          weatherBoxes.add(WeatherBox(
            key: UniqueKey(),
            currentWeather: value,
          ));
        }
      });
    });
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

  void checkNetwork() async {
    bool isDeviceConnected = await WeatherHelper.hasNetwork();
    if (isDeviceConnected) {
      print('Connected here $isDeviceConnected');
      updateData();
    }
  }

  void updateData() async {
    setState(() {
      loading = true;
    });
    WeatherService service = WeatherService();
    weatherData = await service.fetchMultipleLocationWeather();
    setState(() {
      weatherBoxes.clear();
      populateMultipleCityWeather();
      loading = false;
    });
  }
}
