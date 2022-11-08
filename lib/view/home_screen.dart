import 'package:flutter/material.dart';
import 'package:weather/controller/global_controller.dart';
import 'package:get/get.dart';
import 'package:weather/view/current_weather_screen.dart';
import 'package:weather/view/hourly_screen.dart';
import 'daily_screen.dart';
import 'header.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalController globalController =
      Get.put(GlobalController(), permanent: true);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Flutter Weather"),leading: const Icon(Icons.sunny),backgroundColor: Colors.black38),
      body: SafeArea(
        child: Obx(
          () => globalController.checkLoading().isTrue
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : RefreshIndicator(
                color: Colors.black38,
                strokeWidth: 3,
                onRefresh: _refresh,
                child: ListView(
                    scrollDirection: Axis.vertical,
                    children: [
                      const SizedBox(height: 20),
                      const Header(),
                      const SizedBox(height: 20),
                      CurrentWeatherScreen(globalController.getWeatherData().getCurrentWeather()),
                      const SizedBox(height: 20),
                      HourlyScreen(globalController.getWeatherData().getHourlyWeather()),
                      const SizedBox(height: 20),
                      DailyScreen(globalController.getWeatherData().getDailyWeather()),


                    ],
                  ),
              ),
        ),
      ),
    );
  }

  Future<void> _refresh() async {
    await Future.delayed(const Duration(milliseconds: 1000),);
    GlobalController();
     setState(() {
     });
  }
}
