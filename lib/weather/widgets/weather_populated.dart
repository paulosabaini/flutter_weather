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
        const SizedBox(height: 16),
        Image.asset(
          weather.condition.toAssetName,
          width: 200,
          height: 200,
        ),
        const SizedBox(height: 32),
        Text(
          weather.formattedTemperature(units),
          style: Theme.of(context).textTheme.displayMedium,
        ),
        Text(
          weather.conditionDescription,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        const SizedBox(
          height: 32,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _WeatherHumidity(humidity: weather.humidity),
            _WeatherWindSpeed(
              windSpeed: weather.formattedWindSpeed(units),
            ),
          ],
        ),
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
          width: 8,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
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
        ),
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
          width: 8,
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
        ),
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
    return '''${speed.toStringAsPrecision(2)}${units.isCelsius ? 'Km/h' : 'mph'}''';
  }
}

extension on WeatherConditionEnum {
  String get toAssetName {
    switch (this) {
      case WeatherConditionEnum.thunderstorm:
        return 'assets/images/thunderstorm.png';
      case WeatherConditionEnum.drizzle:
        return 'assets/images/raindrop.png';
      case WeatherConditionEnum.rain:
        return 'assets/images/rain.png';
      case WeatherConditionEnum.snow:
        return 'assets/images/snow.png';
      case WeatherConditionEnum.mist:
        return 'assets/images/wind.png';
      case WeatherConditionEnum.smoke:
        return 'assets/images/wind.png';
      case WeatherConditionEnum.haze:
        return 'assets/images/wind.png';
      case WeatherConditionEnum.dust:
        return 'assets/images/wind.png';
      case WeatherConditionEnum.fog:
        return 'assets/images/wind.png';
      case WeatherConditionEnum.sand:
        return 'assets/images/wind.png';
      case WeatherConditionEnum.ash:
        return 'assets/images/wind.png';
      case WeatherConditionEnum.squall:
        return 'assets/images/wind.png';
      case WeatherConditionEnum.tornado:
        return 'assets/images/tornado.png';
      case WeatherConditionEnum.clear:
        return 'assets/images/clear.png';
      case WeatherConditionEnum.clouds:
        return 'assets/images/cloudy.png';
      case WeatherConditionEnum.unknown:
        return 'assets/images/rainbow.png';
    }
  }
}
