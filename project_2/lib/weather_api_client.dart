import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:project_2/weather.dart';

class WeatherApiClient {
  Future<Weather>? getCurrentWeather(String? location) async {
    //api used
    var endpoint = Uri.parse("https://api.openweathermap.org/data/2.5/weather?q=$location&appid=fb102e70b87a29477962ad422d50f29e");

    //used to request a resource from the server.
    var response = await http.get(endpoint);
    var body = jsonDecode(response.body);

    return Weather.fromJson(body);
  }
}