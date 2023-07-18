import 'package:open_weather_api/open_weather_api.dart';
import 'package:test/test.dart';

void main() {
  group('Weather', () {
    group('fromJson', () {
      test('returns correct Weather object', () {
        expect(
          Weather.fromJson(
            <String, dynamic>{
              'weather': [
                <String, dynamic>{
                  'description': 'clear sky',
                  'icon': '01d',
                }
              ],
              'main': <String, dynamic>{
                'temp': 302.54,
                'humidity': 55,
              },
              'wind': <String, dynamic>{'speed': 0.82}
            },
          ),
          isA<Weather>()
              .having((w) => w.conditions.first.description,
                  'weather description', 'clear sky')
              .having((w) => w.conditions.first.icon, 'weather icon', '01d')
              .having((w) => w.main.temp, 'temp', 302.54)
              .having((w) => w.main.humidity, 'humidity', 55)
              .having((w) => w.wind.speed, 'wind speed', 0.82),
        );
      });
    });
  });
}
