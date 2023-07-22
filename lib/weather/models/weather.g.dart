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
          conditionIconURL:
              $checkedConvert('condition_icon_u_r_l', (v) => v as String),
          temperature:
              $checkedConvert('temperature', (v) => (v as num).toDouble()),
          humidity: $checkedConvert('humidity', (v) => v as int),
          windSpeed:
              $checkedConvert('wind_speed', (v) => (v as num).toDouble()),
          lastUpdated: $checkedConvert(
              'last_updated', (v) => DateTime.parse(v as String)),
        );
        return val;
      },
      fieldKeyMap: const {
        'conditionDescription': 'condition_description',
        'conditionIconURL': 'condition_icon_u_r_l',
        'windSpeed': 'wind_speed',
        'lastUpdated': 'last_updated'
      },
    );

Map<String, dynamic> _$WeatherToJson(Weather instance) => <String, dynamic>{
      'location': instance.location,
      'condition_description': instance.conditionDescription,
      'condition_icon_u_r_l': instance.conditionIconURL,
      'temperature': instance.temperature,
      'humidity': instance.humidity,
      'wind_speed': instance.windSpeed,
      'last_updated': instance.lastUpdated.toIso8601String(),
    };
