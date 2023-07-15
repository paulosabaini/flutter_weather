import 'package:json_annotation/json_annotation.dart';

part 'weather.g.dart';

@JsonSerializable(explicitToJson: true)
class Weather {
  @JsonKey(name: 'weather')
  final List<WeatherCondition> conditions;
  final WeatherMain main;
  final WeatherWind wind;

  const Weather({
    required this.conditions,
    required this.main,
    required this.wind,
  });

  factory Weather.fromJson(Map<String, dynamic> json) =>
      _$WeatherFromJson(json);
}

@JsonSerializable(explicitToJson: true)
class WeatherCondition {
  final String description;
  final String icon;

  const WeatherCondition({
    required this.description,
    required this.icon,
  });

  factory WeatherCondition.fromJson(Map<String, dynamic> json) =>
      _$WeatherConditionFromJson(json);
}

@JsonSerializable(explicitToJson: true)
class WeatherMain {
  final double temp;
  final int humidity;

  const WeatherMain({required this.temp, required this.humidity});

  factory WeatherMain.fromJson(Map<String, dynamic> json) =>
      _$WeatherMainFromJson(json);
}

@JsonSerializable(explicitToJson: true)
class WeatherWind {
  final double speed;

  const WeatherWind({required this.speed});

  factory WeatherWind.fromJson(Map<String, dynamic> json) =>
      _$WeatherWindFromJson(json);
}
