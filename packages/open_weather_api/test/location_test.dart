import 'package:open_weather_api/open_weather_api.dart';
import 'package:test/test.dart';

void main() {
  group('Location', () {
    group('fromJson', () {
      test('returns correct Location object', () {
        expect(
          Location.fromJson(
            <String, dynamic>{
              'name': 'London',
              'lat': 51.5073219,
              'lon': -0.1276474,
            },
          ),
          isA<Location>()
              .having((w) => w.name, 'name', 'London')
              .having((w) => w.lat, 'lat', 51.5073219)
              .having((w) => w.lon, 'lon', -0.1276474),
        );
      });
    });
  });
}
