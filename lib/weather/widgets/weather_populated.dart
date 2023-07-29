import 'package:flutter/material.dart';
import 'package:flutter_weather/weather/weather.dart';

class WeatherPopulated extends StatelessWidget {
  const WeatherPopulated({
    required this.weather,
    required this.units,
    super.key,
  });

  final Weather weather;
  final TemperatureUnits units;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 16,
        ),
        Image.network(
          weather.conditionIconURL,
          scale: 0.5,
        ),
        Text(
          weather.formattedTemperature(units),
          style: Theme.of(context).textTheme.displayMedium,
        ),
        Text(
          weather.conditionDescription,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        const SizedBox(
          height: 16,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _WeatherHumidity(humidity: weather.humidity),
            _WeatherWindSpeed(
              windSpeed: weather.formattedWindSpeed(units),
            )
          ],
        )
      ],
    );
  }
}

class _WeatherHumidity extends StatelessWidget {
  const _WeatherHumidity({required this.humidity});

  final int humidity;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(Icons.water),
        const SizedBox(
          width: 16,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '$humidity%',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            Text(
              'Humidity',
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        )
      ],
    );
  }
}

class _WeatherWindSpeed extends StatelessWidget {
  const _WeatherWindSpeed({required this.windSpeed});

  final String windSpeed;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(Icons.north_east),
        const SizedBox(
          width: 16,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              windSpeed,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            Text(
              'Wind Speed',
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        )
      ],
    );
  }
}

extension on Weather {
  String formattedTemperature(TemperatureUnits units) {
    return '''${temperature.toStringAsPrecision(2)}°${units.isCelsius ? 'C' : 'F'}''';
  }

  String formattedWindSpeed(TemperatureUnits units) {
    final speed = units.isCelsius ? windSpeed * 3.6 : windSpeed;
    return '''${speed.toStringAsPrecision(2)}${units.isCelsius ? 'KM/h' : 'mph'}''';
  }
}
