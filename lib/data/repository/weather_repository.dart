import 'dart:math';

import 'package:simple_bloc/data/model/weather.dart';

abstract class WeatherRepository{
  ///Throws[NetworkException].
  Future<Weather> fetchWeather(String cityName);
}

class FakeWeatherRepository implements WeatherRepository{

  @override
  Future<Weather> fetchWeather(String cityName) {
    
    return Future.delayed(
      Duration(seconds: 1),
        (){
          final random= Random();

          // Simulate some network exception
          if(random.nextBool()){
            throw NetworkException();
          }

          //return fetched weather
          return Weather(
            cityName: cityName,
            temperature: 20+random.nextInt(15)+random.nextDouble(),
          );
        }
    );
  }
}

class NetworkException implements Exception{}
