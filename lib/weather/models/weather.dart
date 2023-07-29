import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:weather_repository/weather_repository.dart' hide Weather;
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
    required this.condition,
    required this.conditionDescription,
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
      condition: weather.condition,
      conditionDescription: weather.conditionDescription,
      temperature: weather.temperature,
      humidity: weather.humidity,
      windSpeed: weather.windSpeed,
      lastUpdated: DateTime.now(),
    );
  }

  static final empty = Weather(
    location: '',
    condition: WeatherConditionEnum.unknown,
    conditionDescription: '',
    temperature: 0,
    humidity: 0,
    windSpeed: 0,
    lastUpdated: DateTime(0),
  );

  final String location;
  final WeatherConditionEnum condition;
  final String conditionDescription;
  final double temperature;
  final int humidity;
  final double windSpeed;
  final DateTime lastUpdated;

  @override
  List<Object?> get props => [
        location,
        condition,
        conditionDescription,
        temperature,
        humidity,
        windSpeed,
        lastUpdated,
      ];

  Map<String, dynamic> toJson() => _$WeatherToJson(this);

  Weather copyWith({
    String? location,
    WeatherConditionEnum? condition,
    String? conditionDescription,
    double? temperature,
    int? humidity,
    double? windSpeed,
    DateTime? lastUpdated,
  }) {
    return Weather(
      location: location ?? this.location,
      condition: condition ?? this.condition,
      conditionDescription: conditionDescription ?? this.conditionDescription,
      temperature: temperature ?? this.temperature,
      humidity: humidity ?? this.humidity,
      windSpeed: windSpeed ?? this.windSpeed,
      lastUpdated: lastUpdated ?? this.lastUpdated,
    );
  }
}
