import 'dart:async';
import 'dart:math';
import 'package:simple_bloc/bloc/weather_event.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:simple_bloc/data/model/weather.dart';
import 'package:simple_bloc/data/repository/weather_repository.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final WeatherRepository _weatherRepository;
    WeatherBloc(this._weatherRepository) : super(WeatherInitial());

  @override
  Stream<WeatherState> mapEventToState(
    WeatherEvent event,
  ) async* {
    if(event is GetWeather)
    try {
      yield WeatherLoading();
      final weather = await _weatherRepository.fetchWeather(event.cityName);
      yield WeatherLoaded(weather);
    } on NetworkException{
      yield WeatherError("Couldn't fetch weather. Is the device online?");
    }
  }
}




