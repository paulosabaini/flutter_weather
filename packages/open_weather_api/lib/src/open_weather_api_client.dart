import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:open_weather_api/api_key.dart';
import 'package:open_weather_api/open_weather_api.dart';

/// Exception thrown when locationSearch fails.
class LocationRequestFailure implements Exception {}

/// Exception thrown when the provided location is not found.
class LocationNotFoundFailure implements Exception {}

/// Exception thrown when getWeather fails.
class WeatherRequestFailure implements Exception {}

/// Exception thrown when weather for provided location is not found.
class WeatherNotFoundFailure implements Exception {}

class OpenWeatherApiClient {
  OpenWeatherApiClient({http.Client? httpClient})
      : _httpClient = httpClient ?? http.Client();

  static const _baseUrl = 'api.openweathermap.org';

  final http.Client _httpClient;

  /// Finds a [Location] `/geo/1.0/direct?q=(query)&limit=1&appid=(apiKey)`
  Future<Location> locationSearch(String query) async {
    final locationRequest = Uri.https(
      _baseUrl,
      '/geo/1.0/direct',
      {
        'q': query,
        'limit': '1',
        'appid': openWeatherApiKey,
      },
    );

    final locationResponse = await _httpClient.get(locationRequest);

    if (locationResponse.statusCode != 200) {
      throw LocationRequestFailure();
    }

    final locationJson = jsonDecode(locationResponse.body) as List;

    if (locationJson.isEmpty) throw LocationNotFoundFailure();

    final result = locationJson.first;

    return Location.fromJson(result as Map<String, dynamic>);
  }

  /// Fetches [Weather] for a given [latitude] and [longitude].
  Future<Weather> getWeather({
    required double latitude,
    required double longitude,
    required bool isCelsius,
  }) async {
    final weatherRequest = Uri.https(
      _baseUrl,
      '/data/2.5/weather',
      {
        'lat': '$latitude',
        'lon': '$longitude',
        'appid': openWeatherApiKey,
        'units': isCelsius ? 'metric' : 'imperial',
      },
    );

    final weatherResponse = await _httpClient.get(weatherRequest);

    if (weatherResponse.statusCode != 200) {
      throw WeatherRequestFailure();
    }

    final bodyJson = jsonDecode(weatherResponse.body) as Map<String, dynamic>;

    if (bodyJson.isEmpty) {
      throw WeatherNotFoundFailure();
    }

    return Weather.fromJson(bodyJson);
  }
}
