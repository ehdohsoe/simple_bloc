import 'dart:async';
import 'dart:math';
import 'package:simple_bloc/bloc/weather_event.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:simple_bloc/model/weather.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
    WeatherBloc() : super(WeatherInitial());

  @override
  Stream<WeatherState> mapEventToState(
    WeatherEvent event,
  ) async* {
    if(event is GetWeather)
      {
        yield WeatherLoading();
        final weather = await _fetchWeatherFromFakeApi(event.cityName);
        yield WeatherLoaded(weather);
      }
  }
}

Future<Weather> _fetchWeatherFromFakeApi(String cityName) {
  return Future.delayed(
    Duration(seconds: 1),(){
      return Weather(
        cityName: cityName,
        temperature: 20+Random().nextInt(15)+Random().nextDouble(),
      );
  });
}


