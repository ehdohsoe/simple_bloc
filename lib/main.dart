import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_bloc/bloc/weather_bloc.dart';
import 'package:simple_bloc/pages/weather_search_page.dart';
import 'bloc/weather_bloc.dart';
import 'data/repository/weather_repository.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: BlocProvider(
          create: (context)=>WeatherBloc(FakeWeatherRepository()),
          child: WeatherSearchPage()),
    );
  }
}








