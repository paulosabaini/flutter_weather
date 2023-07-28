import 'package:json_annotation/json_annotation.dart';

part 'weather.g.dart';

@JsonSerializable(explicitToJson: true)
class Weather {
  const Weather({
    required this.conditions,
    required this.main,
    required this.wind,
  });

  factory Weather.fromJson(Map<String, dynamic> json) =>
      _$WeatherFromJson(json);

  @JsonKey(name: 'weather')
  final List<WeatherCondition> conditions;
  final WeatherMain main;
  final WeatherWind wind;
}

@JsonSerializable(explicitToJson: true)
class WeatherCondition {
  const WeatherCondition({
    required this.description,
    required this.icon,
  });

  factory WeatherCondition.fromJson(Map<String, dynamic> json) =>
      _$WeatherConditionFromJson(json);

  final String description;
  final String icon;
}

@JsonSerializable(explicitToJson: true)
class WeatherMain {
  const WeatherMain({required this.temp, required this.humidity});

  factory WeatherMain.fromJson(Map<String, dynamic> json) =>
      _$WeatherMainFromJson(json);

  final double temp;
  final int humidity;
}

@JsonSerializable(explicitToJson: true)
class WeatherWind {
  const WeatherWind({required this.speed});

  factory WeatherWind.fromJson(Map<String, dynamic> json) =>
      _$WeatherWindFromJson(json);

  final double speed;
}
