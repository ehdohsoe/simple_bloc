import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_bloc/bloc/weather_bloc.dart';
import 'package:simple_bloc/bloc/weather_event.dart';
import 'bloc/weather_bloc.dart';
import 'model/weather.dart';

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
      home: WeatherPage(),
    );
  }
}
class WeatherPage extends StatefulWidget {
  @override
  _WeatherPageState createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {

  final  weatherBloc = WeatherBloc();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:Text('Fake Weather App'),
      ),
      body: BlocProvider(
        create: (BuildContext context) => weatherBloc,
        child: Container(
          child:BlocListener<WeatherBloc,WeatherState>(
            listener: (context,state){
              if(state is WeatherLoaded)
              print('loaded${state.weather.cityName}');
            },
            child: BlocBuilder<WeatherBloc,WeatherState>(
              cubit: weatherBloc,
              builder: (context, state) {
                if(state is WeatherInitial){
                  return buildInitialInput();
                }else if(state is WeatherLoading){
                  return buildLoading();
                }else if(state is WeatherLoaded){
                  return buildColumnWithData(state.weather);
                }
                return Text('Invalid State');
              },
            ),
          ),
        ),
      ),
    );
  }

  Column buildColumnWithData(Weather weather) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Text(
            weather.cityName,
          ),
          Text(
            "${weather.temperature.toStringAsFixed(1)}\u2103",
          ),
          CityInputField(),
        ],
      );
  }

  @override
  void dispose() {
    super.dispose();
    weatherBloc.close();
  }
}

Widget buildLoading() {
  return Center(
    child: CircularProgressIndicator(),
  );
}

Widget buildInitialInput() {
  return Center(
    child: CityInputField(),
  );
}

class CityInputField extends StatefulWidget {
  @override
  _CityInputFieldState createState() => _CityInputFieldState();
}

class _CityInputFieldState extends State<CityInputField> {
  final weatherInputController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50),
      child: TextField(
        controller: weatherInputController,
        onSubmitted: submitCityName,
        textInputAction: TextInputAction.search,
        decoration: InputDecoration(
          hintText: "Enter City",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          suffixIcon: IconButton(
            onPressed:()=>submitCityName(weatherInputController.text),
            icon: Icon(Icons.search),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    weatherInputController.dispose();
    super.dispose();
  }
  void submitCityName(String cityName){
    final weatherBloc = BlocProvider.of<WeatherBloc>(context);
    weatherBloc.add(GetWeather(cityName));
  }
}







