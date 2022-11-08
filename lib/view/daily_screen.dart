import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather/model/daily.dart';

class DailyScreen extends StatefulWidget {
  final WeatherDataDaily weatherDataDaily;
  const DailyScreen(this.weatherDataDaily,{Key? key}) : super(key: key);

  @override
  State<DailyScreen> createState() => _DailyScreenState();
}

class _DailyScreenState extends State<DailyScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.only(top: 5.0,left: 10.0),
          alignment: Alignment.topLeft,
          child: const Text(
            "Upcoming days",
            style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.w500),
          ),
        ),
        const Divider(
          height: 5.0,
          indent: 10,
          endIndent: 250,
          thickness: 1.5,
          color: Colors.black12,
        ),
        Container(
          height: 400,
          margin: const EdgeInsets.all(15),
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.grey,
            borderRadius: BorderRadius.circular(20.0),
            gradient: const LinearGradient(
                colors: [Colors.blueGrey, Colors.black26]),
          ),
          child: ListView.builder(
            scrollDirection: Axis.vertical,
            itemCount: widget.weatherDataDaily.daily.length>7 ? 7:widget.weatherDataDaily.daily.length,
            itemBuilder: (context,index){
              return Column(
                children: [
                  Container(
                    height: 60,
                    padding: const EdgeInsets.only(left: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          DateFormat('EEE').format(
                            DateTime.fromMillisecondsSinceEpoch(
                              widget.weatherDataDaily.daily[index].dt!
                                  .toInt() * 1000,
                            ),
                          ),style: const TextStyle(
                          color: Colors.white,
                          fontSize: 15.0
                        ),
                        ),
                        Image.asset("images/weather/${widget.weatherDataDaily.daily[index].weather![0].icon}.png",height: 35,),
                        Text("${widget.weatherDataDaily.daily[index].temp!.max!.round()}°C",style: const TextStyle(
                            color: Colors.white,
                            fontSize: 15.0
                        ),
                        ),
                      ],
                    )
                  ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}
