import 'current.dart';
import 'daily.dart';
import 'hourly.dart';

class WeatherData{
  final WeatherDataCurrent? current;
  final WeatherDataHourly? hourly;
  final WeatherDataDaily? daily;

  WeatherData([this.current,this.hourly,this.daily]);

  WeatherDataCurrent getCurrentWeather() => current!;
  WeatherDataHourly getHourlyWeather() => hourly!;
  WeatherDataDaily getDailyWeather() => daily!;

}