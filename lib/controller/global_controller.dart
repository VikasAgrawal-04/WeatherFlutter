import 'package:geolocator/geolocator.dart' as geo;
import 'package:get/get.dart';
import 'package:location/location.dart' as loc;
import 'package:weather/api/fetch_weather_api.dart';
import '../model/weather_data.dart';

class GlobalController extends GetxController {
  final RxBool _isLoading = true.obs;
  final RxDouble _lat = 0.0.obs;
  final RxDouble _long = 0.0.obs;
  final weatherData = WeatherData().obs;


  RxBool checkLoading() => _isLoading;
  RxDouble getLatitude() => _lat;
  RxDouble getLongitude() => _long;
  WeatherData getWeatherData() {
    return weatherData.value;
  }


  @override
  void onInit() {
    if (_isLoading.isTrue) {
      getLocation();
    }
    super.onInit();
  }

  getLocation() async {
    bool serviceEnabled;
    geo.LocationPermission permission;
    // Test if location services are enabled.
    serviceEnabled = await geo.Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      loc.Location location = loc.Location();
      bool isOn = await location.serviceEnabled();
      if (!isOn) {
        //if device is off
        bool isTurnedOn = await location.requestService();
        if (isTurnedOn) {
        } else {
          await location.requestService();
        }
      }
    }
    permission = await geo.Geolocator.checkPermission();
    if (permission == geo.LocationPermission.denied) {
      permission = await geo.Geolocator.requestPermission();
      if (permission == geo.LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == geo.LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await geo.Geolocator.getCurrentPosition(
            desiredAccuracy: geo.LocationAccuracy.high)
        .then((value) {
      _lat.value = value.latitude;
      _long.value = value.longitude;
      return FetchWeatherAPI().processData(value.latitude, value.longitude).then((value) {
        weatherData.value = value;
        _isLoading.value = false;
      })
      ;
    });
  }
}
