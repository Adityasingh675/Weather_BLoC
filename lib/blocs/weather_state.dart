import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:weather_bloc2/models/weather_model.dart';

class WeatherState extends Equatable {
  @override
  List<Object> get props => [];
}

class NotSearching extends WeatherState {}

class Searching extends WeatherState {}

class Searched extends WeatherState {
  final WeatherModel weatherModel;

  Searched({@required this.weatherModel});
  @override
  List<Object> get props => [weatherModel];
}

class Idle extends WeatherState {}
