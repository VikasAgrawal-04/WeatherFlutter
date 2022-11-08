import 'dart:convert';

import 'package:weather/model/current.dart';
import 'package:weather/model/daily.dart';
import 'package:weather/model/hourly.dart';
import 'package:weather/model/weather_data.dart';
import 'package:http/http.dart' as http;

import 'api_key.dart';


class FetchWeatherAPI{
  WeatherData? weatherData;

  Future<WeatherData> processData(lat, lon) async {
    var response = await http.get(Uri.parse(""
        "https://api.openweathermap.org/data/3.0/onecall?lat=$lat&lon=$lon&appid=$apiKey&units=metric&exclude=minutely"));
    var jsonString = jsonDecode(response.body);
    weatherData = WeatherData(WeatherDataCurrent.fromJson(jsonString),(WeatherDataHourly.fromJson(jsonString)),WeatherDataDaily.fromJson(jsonString));

    return weatherData!;
  }

}