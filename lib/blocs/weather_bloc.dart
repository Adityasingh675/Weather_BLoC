import 'package:bloc/bloc.dart';
import 'package:weather_bloc2/models/weather_model.dart';
// import 'package:weather_bloc2/services/weather_services.dart';
import 'exports.dart';

import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  // WeatherService weatherService = WeatherService();

  // WeatherBloc({this.weatherService}) : super(NotSearching());

  WeatherBloc() : super(NotSearching());
  @override
  WeatherState get initialState => NotSearching();
  @override
  Stream<WeatherState> mapEventToState(WeatherEvent event) async* {
    if (event is GetWeatherData) {
      yield Searching();
      try {
        WeatherModel weather = await getWeatherData(event.city);
        yield Searched(weatherModel: weather);
      } catch (_, stackTrace) {
        print('$_$stackTrace');
      }
    } else if (event is ResetWeatherData) {
      yield NotSearching();
    }
  }

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
