import 'dart:async';
import 'package:open_weather_api/open_weather_api.dart' hide Weather;
import 'package:weather_repository/extensions/string.dart';
import 'package:weather_repository/weather_repository.dart';

class WeatherRepository {
  WeatherRepository({OpenWeatherApiClient? weatherApiClient})
      : _weatherApiClient = weatherApiClient ?? OpenWeatherApiClient();

  final OpenWeatherApiClient _weatherApiClient;

  Future<Weather> getWeather(String city) async {
    final location = await _weatherApiClient.locationSearch(city);
    final weather = await _weatherApiClient.getWeather(
      latitude: location.lat,
      longitude: location.lon,
    );
    return Weather(
      location: location.name,
      condition: weather.conditions.first.main.toCondition,
      conditionDescription:
          weather.conditions.first.description.capitalizeByWord(),
      temperature: weather.main.temp,
      humidity: weather.main.humidity,
      windSpeed: weather.wind.speed,
    );
  }
}

extension on String {
  WeatherConditionEnum get toCondition {
    switch (this) {
      case 'Thunderstorm':
        return WeatherConditionEnum.thunderstorm;
      case 'Drizzle':
        return WeatherConditionEnum.drizzle;
      case 'Rain':
        return WeatherConditionEnum.rain;
      case 'Snow':
        return WeatherConditionEnum.snow;
      case 'Mist':
        return WeatherConditionEnum.mist;
      case 'Smoke':
        return WeatherConditionEnum.smoke;
      case 'Haze':
        return WeatherConditionEnum.haze;
      case 'Dust':
        return WeatherConditionEnum.dust;
      case 'Fog':
        return WeatherConditionEnum.fog;
      case 'Sand':
        return WeatherConditionEnum.sand;
      case 'Ash':
        return WeatherConditionEnum.ash;
      case 'Squall':
        return WeatherConditionEnum.squall;
      case 'Tornado':
        return WeatherConditionEnum.tornado;
      case 'Clear':
        return WeatherConditionEnum.clear;
      case 'Clouds':
        return WeatherConditionEnum.clouds;
      default:
        return WeatherConditionEnum.unknown;
    }
  }
}
