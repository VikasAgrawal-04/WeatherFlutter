import 'package:flutter/material.dart';
import 'package:weather/model/current.dart';

class CurrentWeatherScreen extends StatefulWidget {
  final WeatherDataCurrent weatherDataCurrent;

  const CurrentWeatherScreen(this.weatherDataCurrent, {Key? key})
      : super(key: key);

  @override
  State<CurrentWeatherScreen> createState() => _CurrentWeatherScreenState();
}

class _CurrentWeatherScreenState extends State<CurrentWeatherScreen> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Image.asset(
          "images/weather/${widget.weatherDataCurrent.current.weather![0].icon}.png",
          height: 70,
          width: 80,
        ),
        Container(
          width: 1.0,
          height: 50,
          color: Colors.white54,
        ),
        RichText(
          text: TextSpan(children: [
            TextSpan(
                text:
                    "${widget.weatherDataCurrent.current.temp!.toInt()}°",
                style: const TextStyle(
                    fontSize: 45,
                    fontWeight: FontWeight.bold,
                    color: Colors.black)),
            TextSpan(
              text:
                  "${widget.weatherDataCurrent.current.weather![0].description}",
              style: const TextStyle(
                  fontSize: 15,
                  color: Colors.grey),
            ),
          ]),
        ),
      ],
    );
  }
}
