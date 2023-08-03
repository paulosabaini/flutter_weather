// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_weather/weather/weather.dart';

void main() {
  group('WeatherPopulated', () {
    final weather = Weather(
      location: 'London',
      condition: WeatherConditionEnum.clear,
      conditionDescription: 'Clear Sky',
      temperature: 30,
      humidity: 70,
      windSpeed: 20,
      lastUpdated: DateTime(2023),
    );

    testWidgets('renders correct image (clear)', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: WeatherPopulated(
              weather: weather,
              units: TemperatureUnits.celsius,
            ),
          ),
        ),
      );
      expect(
        find.image(const AssetImage('assets/images/clear.png')),
        findsOneWidget,
      );
    });
  });
}
