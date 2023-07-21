import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'weather.g.dart';

@JsonSerializable()
class Weather extends Equatable {
  const Weather({
    required this.location,
    required this.conditionDescription,
    required this.conditionIcon,
    required this.temperature,
    required this.humidity,
    required this.windSpeed,
  });

  factory Weather.fromJson(Map<String, dynamic> json) =>
      _$WeatherFromJson(json);

  Map<String, dynamic> toJson() => _$WeatherToJson(this);

  final String location;
  final String conditionDescription;
  final String conditionIcon;
  final double temperature;
  final int humidity;
  final double windSpeed;

  @override
  List<Object?> get props => [
        location,
        conditionDescription,
        conditionIcon,
        temperature,
        humidity,
        windSpeed
      ];
}
