import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

class WeatherEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class ScreenLoadData extends WeatherEvent {}

class GetWeatherData extends WeatherEvent {
  final String city;

  GetWeatherData({@required this.city});
  @override
  List<Object> get props => [city];
}

class ResetWeatherData extends WeatherEvent {}
