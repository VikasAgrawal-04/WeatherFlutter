import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather/model/hourly.dart';

class HourlyScreen extends StatefulWidget {
  final WeatherDataHourly weatherDataHourly;
  const HourlyScreen(this.weatherDataHourly, {Key? key}) : super(key: key);
  @override
  State<HourlyScreen> createState() => _HourlyScreenState();
}

class _HourlyScreenState extends State<HourlyScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.only(top: 10.0),
          alignment: Alignment.topCenter,
          child: const Text(
            "Today",
            style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.w500),
          ),
        ),
        const Divider(
          height: 5.0,
          indent: 145,
          endIndent: 145,
          thickness: 1.5,
          color: Colors.black12,
        ),
        Container(
          height: 170,
          padding: const EdgeInsets.only(top: 10, bottom: 10),
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: widget.weatherDataHourly.hourly.length> 24 ?28:widget.weatherDataHourly.hourly.length,
            itemBuilder: (context, index) {
              return Container(
                width: 90,
                margin: const EdgeInsets.only(left: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  gradient: const LinearGradient(
                      colors: [Colors.blueGrey, Colors.black26]),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 10),
                      alignment: Alignment.topCenter,
                      child: Text(
                        DateFormat('jm').format(
                          DateTime.fromMillisecondsSinceEpoch(
                            widget.weatherDataHourly.hourly[index].dt!
                                .toInt() * 1000,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.all(5),
                      alignment: Alignment.topCenter,height: 50,width: 50,
                      child: Image.asset("images/weather/${widget.weatherDataHourly.hourly[index].weather![0].icon}.png"),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 5,bottom: 10),
                      alignment: Alignment.topCenter,
                      child: Text("${widget.weatherDataHourly.hourly[index].temp!.toInt()}°C"
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
