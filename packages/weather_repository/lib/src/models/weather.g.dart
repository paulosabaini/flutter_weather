// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weather.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Weather _$WeatherFromJson(Map<String, dynamic> json) => $checkedCreate(
      'Weather',
      json,
      ($checkedConvert) {
        final val = Weather(
          location: $checkedConvert('location', (v) => v as String),
          conditionDescription:
              $checkedConvert('condition_description', (v) => v as String),
          conditionIcon: $checkedConvert('condition_icon', (v) => v as String),
          temperature:
              $checkedConvert('temperature', (v) => (v as num).toDouble()),
          humidity: $checkedConvert('humidity', (v) => v as int),
          windSpeed:
              $checkedConvert('wind_speed', (v) => (v as num).toDouble()),
        );
        return val;
      },
      fieldKeyMap: const {
        'conditionDescription': 'condition_description',
        'conditionIcon': 'condition_icon',
        'windSpeed': 'wind_speed'
      },
    );

Map<String, dynamic> _$WeatherToJson(Weather instance) => <String, dynamic>{
      'location': instance.location,
      'condition_description': instance.conditionDescription,
      'condition_icon': instance.conditionIcon,
      'temperature': instance.temperature,
      'humidity': instance.humidity,
      'wind_speed': instance.windSpeed,
    };
