import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'weather.g.dart';

enum WeatherConditionEnum {
  thunderstorm,
  drizzle,
  rain,
  snow,
  mist,
  smoke,
  haze,
  dust,
  fog,
  sand,
  ash,
  squall,
  tornado,
  clear,
  clouds,
  unknown
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
  });

  factory Weather.fromJson(Map<String, dynamic> json) =>
      _$WeatherFromJson(json);

  Map<String, dynamic> toJson() => _$WeatherToJson(this);

  final String location;
  final WeatherConditionEnum condition;
  final String conditionDescription;
  final double temperature;
  final int humidity;
  final double windSpeed;

  @override
  List<Object?> get props => [
        location,
        condition,
        conditionDescription,
        temperature,
        humidity,
        windSpeed
      ];
}
