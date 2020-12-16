import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_bloc2/models/weather_model.dart';
import 'package:weather_bloc2/services/weather_services.dart';

import 'blocs/exports.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.grey,
      ),
      home: BlocProvider(
        create: (context) => WeatherBloc(),
        child: SearchPage(),
      ),
    );
  }
}

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController _controller = TextEditingController();

  final weatherBloc = WeatherBloc();
  WeatherService weatherService = WeatherService();

  // @override
  // void initState() {
  //   weatherService.getWeatherData;
  //   setState(() {});
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    // @override
    // void dispose() {
    //   _controller.dispose();
    // }
    final weatherBloc = BlocProvider.of<WeatherBloc>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[900],
        elevation: 0.0,
        title: Text(
          'The Weather App',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Center(
        child: BlocBuilder<WeatherBloc, WeatherState>(
          builder: (context, state) {
            if (state is NotSearching) {
              return Container(
                color: Colors.grey[900],
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Weather',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 40.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: TextFormField(
                        style: TextStyle(color: Colors.white),
                        cursorColor: Colors.white,
                        keyboardType: TextInputType.text,
                        controller: _controller,
                        decoration: InputDecoration(
                          hintMaxLines: 2,
                          hintText: 'Please enter city name in lowercase',
                          hintStyle: TextStyle(color: Colors.grey[600]),
                          labelText: 'Enter City Name',
                          labelStyle: TextStyle(color: Colors.white),
                          prefixIcon: Icon(Icons.search, color: Colors.white),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(20.0),
                            ),
                            borderSide: BorderSide(
                              color: Colors.white,
                              style: BorderStyle.solid,
                              width: 2.0,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(20.0),
                            ),
                            borderSide: BorderSide(
                              color: Colors.white,
                              style: BorderStyle.solid,
                              width: 2.0,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 30.0),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 20.0),
                      width: double.infinity,
                      height: 50.0,
                      child: FlatButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        color: Colors.blue[300],
                        child: Text('Search'),
                        onPressed: () {
                          weatherBloc
                              .add(GetWeatherData(city: _controller.text));
                        },
                      ),
                    ),
                  ],
                ),
              );
            } else if (state is Searching) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is Searched) {
              return WeatherPage(
                city: _controller.text,
                weatherModel: state.weatherModel,
              );
            }
          },
        ),
      ),
    );
  }
}

class WeatherPage extends StatelessWidget {
  final String city;
  final WeatherModel weatherModel;
  WeatherPage({@required this.city, @required this.weatherModel});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.grey[900],
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Temperature of $city is' +
                    ' ' +
                    weatherModel.tempImperrial.round().toString(),
                style: TextStyle(color: Colors.white),
              ),
              SizedBox(height: 30.0),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                width: double.infinity,
                height: 50.0,
                child: FlatButton(
                  child: Text('Reset'),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  color: Colors.blue[300],
                  onPressed: () {
                    BlocProvider.of<WeatherBloc>(context)
                        .add(ResetWeatherData());
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
