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

      test('calls locationSearch with correct city', () async {
        try {
          await weatherRepository.getWeather(city);
        } catch (_) {}
        verify(() => weatherApiClient.locationSearch(city)).called(1);
      });

      test('throws when locationSearch fails', () async {
        final exception = Exception('oops');
        when(() => weatherApiClient.locationSearch(any())).thenThrow(exception);
        expect(
          () async => weatherRepository.getWeather(city),
          throwsA(exception),
        );
      });

      test('calls getWeather with correct latitude/longitude', () async {
        final location = MockLocation();
        when(() => location.lat).thenReturn(latitude);
        when(() => location.lon).thenReturn(longitude);
        when(() => weatherApiClient.locationSearch(any())).thenAnswer(
          (_) async => location,
        );
        try {
          await weatherRepository.getWeather(city);
        } catch (_) {}
        verify(
          () => weatherApiClient.getWeather(
            latitude: latitude,
            longitude: longitude,
          ),
        ).called(1);
      });

      test('throws when getWeather fails', () async {
        final exception = Exception('oops');
        final location = MockLocation();
        when(() => location.lat).thenReturn(latitude);
        when(() => location.lon).thenReturn(longitude);
        when(() => weatherApiClient.locationSearch(any())).thenAnswer(
          (_) async => location,
        );
        when(
          () => weatherApiClient.getWeather(
            latitude: latitude,
            longitude: longitude,
          ),
        ).thenThrow(exception);
        expect(
          () async => weatherRepository.getWeather(city),
          throwsA(exception),
        );
      });

      test('returns correct weather os success', () async {
        final location = MockLocation();
        final weather = MockWeather();
        when(() => location.name).thenReturn(city);
        when(() => location.lat).thenReturn(latitude);
        when(() => location.lon).thenReturn(longitude);
        when(() => weather.main).thenReturn(
          const open_weather_api.WeatherMain(
            temp: 30,
            humidity: 70,
          ),
        );
        when(() => weather.conditions).thenReturn([
          const open_weather_api.WeatherCondition(
            description: 'clear sky',
            icon: '01',
          )
        ]);
        when(() => weather.wind).thenReturn(
          const open_weather_api.WeatherWind(speed: 20),
        );
        when(() => weatherApiClient.locationSearch(any())).thenAnswer(
          (_) async => location,
        );
        when(
          () => weatherApiClient.getWeather(
            latitude: any(named: 'latitude'),
            longitude: any(named: 'longitude'),
          ),
        ).thenAnswer((_) async => weather);
        final actual = await weatherRepository.getWeather(city);
        expect(
          actual,
          const Weather(
            location: city,
            conditionDescription: 'Clear Sky',
            conditionIcon: '01',
            temperature: 30,
            humidity: 70,
            windSpeed: 20,
          ),
        );
      });
    });
  });
}
