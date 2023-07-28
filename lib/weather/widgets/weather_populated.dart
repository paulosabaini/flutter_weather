import 'package:flutter/material.dart';
import 'package:flutter_weather/weather/weather.dart';

class WeatherPopulated extends StatelessWidget {
  const WeatherPopulated({
    required this.weather,
    required this.units,
    required this.onRefresh,
    super.key,
  });

  final Weather weather;
  final TemperatureUnits units;
  final ValueGetter<Future<void>> onRefresh;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        RefreshIndicator(
          onRefresh: onRefresh,
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            clipBehavior: Clip.none,
            child: Center(
              child: Column(
                children: [
                  const SizedBox(
                    height: 48,
                  ),
                  Image.network(weather.conditionIconURL),
                  Text(weather.formattedTemperature(units)),
                  Text(weather.conditionDescription),
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}

extension on Weather {
  String formattedTemperature(TemperatureUnits units) {
    return '''${temperature.toStringAsPrecision(2)}°${units.isCelsius ? 'C' : 'F'}''';
  }
}
