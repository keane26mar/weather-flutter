import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:project_2/AppDrawer.dart';
import 'package:project_2/weather.dart';
import 'package:project_2/weatherTile.dart';
import 'package:project_2/weather_api_client.dart';
import 'package:http/http.dart' as http;
import 'dart:async';


class WeatherScreen extends StatelessWidget {

  static String routeName = '/weatherscreen';


  WeatherApiClient client = WeatherApiClient();

  Weather? data;
  Future<void> getData() async {
    data = await client.getCurrentWeather("Singapore");
  }

DateTime currentDate = DateTime.now();

  @override
  Widget build(BuildContext context) {

    var isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;

    return Scaffold(
        appBar: AppBar(
          title: Text('Current Weather'),
        ),
      body: FutureBuilder(
        future: getData(),
        builder: (context, snapshot) {
          return isPortrait? Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.height /3,
                width: MediaQuery.of(context).size.width,
                color: Color(0xfff1f1f1),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Weather information', style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w900)
                    ),
                    SizedBox(height: 20,),

                    Text('${data?.cityName}', style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.w900)
                    ),
                    Padding(padding: EdgeInsets.only(top:10.0, bottom: 10.0),
                      child: Text("${data?.temp}", style: TextStyle(color: Colors.purple, fontSize: 40.0, fontWeight:FontWeight.w900 ),),
                    ),
                    Text(DateFormat('E, MMM d, ''yyyy').format(currentDate))
                  ],
                ),
              ),
              Expanded(
                  child: Padding(padding: EdgeInsets.all(20.0),
                    child: ListView(
                      children: [
                        WeatherTile(icon: Icons.thermostat_outlined, title: 'temperature', subTitle: "${data?.temp}"),
                        WeatherTile(icon: Icons.filter_drama_outlined, title: 'weather', subTitle: '${data?.weather}'),
                        WeatherTile(icon: Icons.wb_sunny, title: 'Humidity', subTitle: '${data?.humidity}'),
                        WeatherTile(icon: Icons.waves_outlined, title: 'Windspeed', subTitle: '${data?.wind}'),
                      ],
                    ),
                  )
              )
            ],
          ): Row(
            children: [
              Container(
                width: MediaQuery.of(context).size.width / 2,
                color: Color(0xfff1f1f1),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Weather information', style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w900)
                    ),
                    SizedBox(height: 20,),

                    Text('${data?.cityName}', style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.w900)
                    ),
                    Padding(padding: EdgeInsets.only(top:10.0, bottom: 10.0),
                      child: Text("${data?.temp}", style: TextStyle(color: Colors.purple, fontSize: 40.0, fontWeight:FontWeight.w900 ),),
                    ),
                    Text(DateFormat('E, MMM d, ''yyyy').format(currentDate))
                  ],
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width / 2,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                        child: Padding(padding: EdgeInsets.all(20.0),
                          child: ListView(
                            children: [
                              WeatherTile(icon: Icons.thermostat_outlined, title: 'temperature', subTitle: "${data?.temp}"),
                              WeatherTile(icon: Icons.filter_drama_outlined, title: 'weather', subTitle: '${data?.weather}'),
                              WeatherTile(icon: Icons.wb_sunny, title: 'Humidity', subTitle: '${data?.humidity}'),
                              WeatherTile(icon: Icons.waves_outlined, title: 'Windspeed', subTitle: '${data?.wind}'),
                            ],
                          ),
                        )
                    )
                  ],
                ),
              ),
            ],
          );
        },
      ),
      drawer: AppDrawer(),
    );
  }
}
