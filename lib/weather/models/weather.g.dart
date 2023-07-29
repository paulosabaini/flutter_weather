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
          condition: $checkedConvert('condition',
              (v) => $enumDecode(_$WeatherConditionEnumEnumMap, v)),
          conditionDescription:
              $checkedConvert('condition_description', (v) => v as String),
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
        'windSpeed': 'wind_speed',
        'lastUpdated': 'last_updated'
      },
    );

Map<String, dynamic> _$WeatherToJson(Weather instance) => <String, dynamic>{
      'location': instance.location,
      'condition': _$WeatherConditionEnumEnumMap[instance.condition]!,
      'condition_description': instance.conditionDescription,
      'temperature': instance.temperature,
      'humidity': instance.humidity,
      'wind_speed': instance.windSpeed,
      'last_updated': instance.lastUpdated.toIso8601String(),
    };

const _$WeatherConditionEnumEnumMap = {
  WeatherConditionEnum.clear: 'clear',
  WeatherConditionEnum.clouds: 'clouds',
  WeatherConditionEnum.haze: 'haze',
  WeatherConditionEnum.rain: 'rain',
  WeatherConditionEnum.snow: 'snow',
  WeatherConditionEnum.unknown: 'unknown',
};
