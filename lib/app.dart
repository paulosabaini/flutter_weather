import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_weather/weather/view/weather_page.dart';
import 'package:weather_repository/weather_repository.dart';

class WeatherApp extends StatelessWidget {
  const WeatherApp({required WeatherRepository weatherRepository, super.key})
      : _weatherRepository = weatherRepository;

  final WeatherRepository _weatherRepository;

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: _weatherRepository,
      child: const WeatherAppView(),
    );
  }
}

class WeatherAppView extends StatelessWidget {
  const WeatherAppView({super.key});

  @override
  Widget build(BuildContext context) {
    const primaryColor = Color.fromARGB(255, 6, 40, 61);

    return MaterialApp(
      theme: ThemeData(
        primaryColor: primaryColor,
        iconTheme: const IconThemeData(color: primaryColor),
        fontFamily: 'Roboto',
        textTheme: const TextTheme(
          bodySmall: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: primaryColor,
          ),
          bodyMedium: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: primaryColor,
          ),
          displayMedium: TextStyle(
            fontSize: 42,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        appBarTheme: const AppBarTheme(
          color: Color.fromARGB(255, 7, 40, 61),
          foregroundColor: Colors.white,
        ),
        useMaterial3: true,
      ),
      home: const WeatherPage(),
    );
  }
}
