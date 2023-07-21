import 'package:mocktail/mocktail.dart';
import 'package:open_weather_api/open_weather_api.dart' as open_weather_api;
import 'package:test/test.dart';
import 'package:weather_repository/weather_repository.dart';

class MockOpenWeatherApiClient extends Mock
    implements open_weather_api.OpenWeatherApiClient {}

class MockLocation extends Mock implements open_weather_api.Location {}

class MockWeather extends Mock implements open_weather_api.Weather {}

void main() {
  group('WeatherRepository', () {
    late open_weather_api.OpenWeatherApiClient weatherApiClient;
    late WeatherRepository weatherRepository;

    setUp(() {
      weatherApiClient = MockOpenWeatherApiClient();
      weatherRepository = WeatherRepository(weatherApiClient: weatherApiClient);
    });

    group('constructor', () {
      test('instantiates internal weather api client when not injected', () {
        expect(WeatherRepository(), isNotNull);
      });
    });

    group('getWeather', () {
      const city = 'london';
      const latitude = 51.5073219;
      const longitude = -0.1276474;
    });
  });
}
