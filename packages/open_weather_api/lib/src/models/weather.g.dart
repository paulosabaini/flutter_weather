// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: implicit_dynamic_parameter

part of 'weather.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Weather _$WeatherFromJson(Map<String, dynamic> json) => $checkedCreate(
      'Weather',
      json,
      ($checkedConvert) {
        final val = Weather(
          conditions: $checkedConvert(
              'weather',
              (v) => (v as List<dynamic>)
                  .map((e) =>
                      WeatherCondition.fromJson(e as Map<String, dynamic>))
                  .toList()),
          main: $checkedConvert(
              'main', (v) => WeatherMain.fromJson(v as Map<String, dynamic>)),
          wind: $checkedConvert(
              'wind', (v) => WeatherWind.fromJson(v as Map<String, dynamic>)),
        );
        return val;
      },
      fieldKeyMap: const {'conditions': 'weather'},
    );

WeatherCondition _$WeatherConditionFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      'WeatherCondition',
      json,
      ($checkedConvert) {
        final val = WeatherCondition(
          main: $checkedConvert('main', (v) => v as String),
          description: $checkedConvert('description', (v) => v as String),
          icon: $checkedConvert('icon', (v) => v as String),
        );
        return val;
      },
    );

WeatherMain _$WeatherMainFromJson(Map<String, dynamic> json) => $checkedCreate(
      'WeatherMain',
      json,
      ($checkedConvert) {
        final val = WeatherMain(
          temp: $checkedConvert('temp', (v) => (v as num).toDouble()),
          humidity: $checkedConvert('humidity', (v) => v as int),
        );
        return val;
      },
    );

WeatherWind _$WeatherWindFromJson(Map<String, dynamic> json) => $checkedCreate(
      'WeatherWind',
      json,
      ($checkedConvert) {
        final val = WeatherWind(
          speed: $checkedConvert('speed', (v) => (v as num).toDouble()),
        );
        return val;
      },
    );
