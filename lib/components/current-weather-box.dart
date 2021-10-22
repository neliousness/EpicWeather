import 'package:epic_weather/util/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CurrentWeatherBox extends StatefulWidget {
  final dynamic currentWeather;

  const CurrentWeatherBox({Key? key, this.currentWeather}) : super(key: key);

  @override
  _CurrentWeatherBoxState createState() => _CurrentWeatherBoxState();
}

class _CurrentWeatherBoxState extends State<CurrentWeatherBox> {
  late double width;
  late double height;
  late dynamic currentWeather;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    currentWeather = widget.currentWeather;
  }

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.all(18.0),
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
                    padding: const EdgeInsets.only(top: 16.0, left: 16.0),
                    child: Row(
                      children: [
                        Icon(
                          Icons.location_on,
                          color: Colors.white,
                          size: 20,
                        ),
                        Text(
                          'Maputo, ',
                          style: TextStyle(color: Colors.white),
                        ),
                        Text(
                          'Mozambique',
                          style: TextStyle(color: kfadeTextColor),
                        )
                      ],
                    ),
                  ),
                  SvgPicture.asset(
                    "assets/svgs/cloud.svg",
                    width: 110,
                    color: kAccentColor,
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
                            alignment: Alignment.topRight,
                            child: Container(
                              width: 15,
                              height: 15,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(60),
                                  border: Border.all(
                                      color: klightTextColor, width: 3)),
                            ),
                          ),
                          Align(
                            alignment: Alignment.center,
                            child: Text(
                              '18',
                              style: TextStyle(
                                  fontSize: 56,
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
                              '27%',
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
                              '17',
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
                              '30km/h',
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
    );
  }
}
