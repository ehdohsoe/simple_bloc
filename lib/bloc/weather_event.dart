import 'package:equatable/equatable.dart';
abstract class WeatherEvent extends Equatable {
  final String cityName;
  const WeatherEvent(this.cityName);
  @override
  List<Object> get props => [cityName];
}

class GetWeather extends WeatherEvent{
  final String cityName;
  GetWeather(this.cityName) : super(cityName);

  @override
  List<Object> get props => [cityName];
}