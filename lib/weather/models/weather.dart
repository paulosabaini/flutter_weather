import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:weather_repository/weather_repository.dart'
    as weather_repository;

part 'weather.g.dart';

enum TemperatureUnits { fahrenheit, celsius }

extension TemperatureUnitsX on TemperatureUnits {
  bool get isFahrenheit => this == TemperatureUnits.fahrenheit;
  bool get isCelsius => this == TemperatureUnits.celsius;
}

@JsonSerializable()
class Weather extends Equatable {
  const Weather({
    required this.location,
    required this.conditionDescription,
    required this.conditionIconURL,
    required this.temperature,
    required this.humidity,
    required this.windSpeed,
    required this.lastUpdated,
  });

  factory Weather.fromJson(Map<String, dynamic> json) =>
      _$WeatherFromJson(json);

  factory Weather.fromRepository(weather_repository.Weather weather) {
    return Weather(
      location: weather.location,
      conditionDescription: weather.conditionDescription,
      conditionIconURL:
          'https://openweathermap.org/img/wn/${weather.conditionIcon}@2x.png',
      temperature: weather.temperature,
      humidity: weather.humidity,
      windSpeed: weather.windSpeed,
      lastUpdated: DateTime.now(),
    );
  }

  static final empty = Weather(
    location: '',
    conditionDescription: '',
    conditionIconURL: '',
    temperature: 0,
    humidity: 0,
    windSpeed: 0,
    lastUpdated: DateTime(0),
  );

  final String location;
  final String conditionDescription;
  final String conditionIconURL;
  final double temperature;
  final int humidity;
  final double windSpeed;
  final DateTime lastUpdated;

  @override
  List<Object?> get props => [
        location,
        conditionDescription,
        conditionIconURL,
        temperature,
        humidity,
        windSpeed,
        lastUpdated,
      ];

  Map<String, dynamic> toJson() => _$WeatherToJson(this);

  Weather copyWith({
    String? location,
    String? conditionDescription,
    String? conditionIconURL,
    double? temperature,
    int? humidity,
    double? windSpeed,
    DateTime? lastUpdated,
  }) {
    return Weather(
      location: location ?? this.location,
      conditionDescription: conditionDescription ?? this.conditionDescription,
      conditionIconURL: conditionIconURL ?? this.conditionIconURL,
      temperature: temperature ?? this.temperature,
      humidity: humidity ?? this.humidity,
      windSpeed: windSpeed ?? this.windSpeed,
      lastUpdated: lastUpdated ?? this.lastUpdated,
    );
  }
}
