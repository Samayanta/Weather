import 'dart:isolate';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:weathear/models/weather_models.dart';
import 'package:weathear/services/weather_services.dart';

class Weatherpage extends StatefulWidget {
  const Weatherpage({super.key});

  @override
  State<Weatherpage> createState() => _WeatherpageState();
}

class _WeatherpageState extends State<Weatherpage> {
  final _weatherService = WeatherServices('9f6a6a35f5206148f0cf254eaa487a44');
  Weather? _weather;

  _fetchWeather() async {
    String cityName = await _weatherService.getCurrentCity();

    try {
      final weather = await _weatherService.getWeather(cityName);
      setState(() {
        _weather = weather;
      });
    } catch (e) {
      print(e);
    }
  }

  String getWeatherAnimation(String? mainCondition) {
    if (mainCondition == null) {
      return 'images/Sunny.json';
    }

    switch (mainCondition.toLowerCase()) {
      case 'clouds':
      case 'mists':
      case 'smoke':
      case 'haze':
      case 'dust':
      case 'fog':
        return 'images/Cloud.json';
      case 'rain':
      case 'drizzle':
      case 'shower rain':
        return 'images/Rain.json';
      case 'thunderstorm':
        return 'images/ Thunder.json';
      case 'clear':
        return 'images/Sunny.json';
      default:
        return 'images/Sunny.json';
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _fetchWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(_weather?.cityName ?? "Loading city..."),
            Lottie.asset(getWeatherAnimation(_weather?.mainCondition)),
            Text('${_weather?.temperature.round()}°C'),
            Text(_weather?.mainCondition ?? "")
          ],
        ),
      ),
    );
  }
}
