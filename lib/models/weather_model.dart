class WeatherModel {
  final temp;
  final temp_min;
  final temp_max;
  final feels_like;
  // final humidity;
  // final pressure;

  double get tempImperrial => temp - 272.15;
  double get tempMaximum => temp_max - 272.15;
  double get tempMinimum => temp_min - 272.15;
  double get realFeel => feels_like - 272.15;

  WeatherModel({
    this.feels_like,
    this.temp,
    this.temp_max,
    this.temp_min,
  });
  // this.humidity,
  // this.pressure});

  factory WeatherModel.fromJson(Map<dynamic, dynamic> parsedJson) {
    return WeatherModel(
      temp: parsedJson['temp'],
      temp_max: parsedJson['temp_max'],
      temp_min: parsedJson['temp_min'],
      feels_like: parsedJson['feels_like'],
      // humidity: parsedJson['main']['humidity'],
      // pressure: parsedJson['main']['pressure'],
    );
  }
}
