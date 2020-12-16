import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import 'package:weather_bloc2/models/weather_model.dart';

class WeatherService {
  Future<WeatherModel> getWeatherData(String city) async {
    // String apiKey = 'cedb9d55fd4669c0817013d000a9860c';
    String url =
        'https://api.openweathermap.org/data/2.5/weather?q=$city&APPID=cedb9d55fd4669c0817013d000a9860c';
    http.Response response = await http.get(url);
    if (response.statusCode == 200) {
      var decodedJson = convert.jsonDecode(response.body);
      print(decodedJson);
      var jsonData = decodedJson["main"];
      print(jsonData);
      return WeatherModel.fromJson(jsonData);
    } else {
      throw Exception('Some error has occured');
    }
  }
}
