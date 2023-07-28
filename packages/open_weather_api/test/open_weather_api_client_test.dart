import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';
import 'package:open_weather_api/api_key.dart';
import 'package:open_weather_api/open_weather_api.dart';
import 'package:test/test.dart';

class MockHttpClient extends Mock implements http.Client {}

class MockResponse extends Mock implements http.Response {}

class FakeUri extends Fake implements Uri {}

void main() {
  group('OpenWeatherApiClient', () {
    late http.Client httpClient;
    late OpenWeatherApiClient apiClient;

    setUpAll(() => registerFallbackValue(FakeUri()));

    setUp(() {
      httpClient = MockHttpClient();
      apiClient = OpenWeatherApiClient(httpClient: httpClient);
    });

    group('constructor', () {
      test('does not require a httpClient', () {
        expect(OpenWeatherApiClient(), isNotNull);
      });
    });

    group('locationSearch', () {
      const query = 'mock-query';
      test('makes correct http request', () async {
        final response = MockResponse();
        when(() => response.statusCode).thenReturn(200);
        when(() => response.body).thenReturn('{}');
        when(() => httpClient.get(any())).thenAnswer((_) async => response);
        try {
          await apiClient.locationSearch(query);
        } catch (_) {}
        verify(
          () => httpClient.get(
            Uri.https(
              'api.openweathermap.org',
              '/geo/1.0/direct',
              {
                'q': query,
                'limit': '1',
                'appid': openWeatherApiKey,
              },
            ),
          ),
        ).called(1);
      });

      test('throws LocationRequestFailure on non-200 response', () {
        final response = MockResponse();
        when(() => response.statusCode).thenReturn(400);
        when(() => httpClient.get(any())).thenAnswer((_) async => response);
        expect(
          () async => apiClient.locationSearch(query),
          throwsA(isA<LocationRequestFailure>()),
        );
      });

      test('throws LocationNotFoundFailure on empty response', () async {
        final response = MockResponse();
        when(() => response.statusCode).thenReturn(200);
        when(() => response.body).thenReturn('[]');
        when(() => httpClient.get(any())).thenAnswer((_) async => response);
        await expectLater(
          apiClient.locationSearch(query),
          throwsA(isA<LocationNotFoundFailure>()),
        );
      });

      test('returns Location on valid response', () async {
        final response = MockResponse();
        when(() => response.statusCode).thenReturn(200);
        when(() => response.body).thenReturn(
          '''
            [
              {
                "name": "London",
                "local_names": {
                  "en": "London"
                },
                "lat": 51.5073219,
                "lon": -0.1276474,
                "country": "GB",
                "state": "England"
              }
            ]
          ''',
        );
        when(() => httpClient.get(any())).thenAnswer((_) async => response);
        final actual = await apiClient.locationSearch(query);
        expect(
          actual,
          isA<Location>()
              .having((l) => l.name, 'name', 'London')
              .having((l) => l.lat, 'lat', 51.5073219)
              .having((l) => l.lon, 'lon', -0.1276474),
        );
      });
    });

    group('getWeather', () {
      const latitude = 51.5073219;
      const longitude = -0.1276474;

      test('makes correct http request', () async {
        final response = MockResponse();
        when(() => response.statusCode).thenReturn(200);
        when(() => response.body).thenReturn('{}');
        when(() => httpClient.get(any())).thenAnswer((_) async => response);
        try {
          await apiClient.getWeather(latitude: latitude, longitude: longitude);
        } catch (_) {}
        verify(
          () => httpClient.get(
            Uri.https(
              'api.openweathermap.org',
              '/data/2.5/weather',
              {
                'lat': '$latitude',
                'lon': '$longitude',
                'appid': openWeatherApiKey,
              },
            ),
          ),
        ).called(1);
      });

      test('throws WeatherRequestFailure on non-200 response', () {
        final response = MockResponse();
        when(() => response.statusCode).thenReturn(400);
        when(() => httpClient.get(any())).thenAnswer((_) async => response);
        expect(
          () async => apiClient.getWeather(
            latitude: latitude,
            longitude: longitude,
          ),
          throwsA(isA<WeatherRequestFailure>()),
        );
      });

      test('throws WeatherNotFoundFailure on empty response', () async {
        final response = MockResponse();
        when(() => response.statusCode).thenReturn(200);
        when(() => response.body).thenReturn('{}');
        when(() => httpClient.get(any())).thenAnswer((_) async => response);
        expect(
          () async => apiClient.getWeather(
            latitude: latitude,
            longitude: longitude,
          ),
          throwsA(isA<WeatherNotFoundFailure>()),
        );
      });

      test('returns Weather on valid response', () async {
        final response = MockResponse();
        when(() => response.statusCode).thenReturn(200);
        when(() => response.body).thenReturn(
          '''
            {
              "coord": {
                "lon": 10.99,
                "lat": 44.34
              },
              "weather": [
                {
                  "id": 800,
                  "main": "Clear",
                  "description": "clear sky",
                  "icon": "01d"
                }
              ],
              "base": "stations",
              "main": {
                "temp": 302.54,
                "feels_like": 304.05,
                "temp_min": 300.75,
                "temp_max": 303.7,
                "pressure": 1015,
                "humidity": 55,
                "sea_level": 1015,
                "grnd_level": 934
              },
              "visibility": 10000,
              "wind": {
                "speed": 0.82,
                "deg": 69,
                "gust": 2.67
              },
              "clouds": {
                "all": 0
              },
              "dt": 1689424523,
              "sys": {
                "type": 2,
                "id": 2004688,
                "country": "IT",
                "sunrise": 1689392722,
                "sunset": 1689447488
              },
              "timezone": 7200,
              "id": 3163858,
              "name": "Zocca",
              "cod": 200
            }
          ''',
        );
        when(() => httpClient.get(any())).thenAnswer((_) async => response);
        final actual = await apiClient.getWeather(
          latitude: latitude,
          longitude: longitude,
        );
        expect(
          actual,
          isA<Weather>()
              .having(
                (w) => w.conditions.first.description,
                'weather description',
                'clear sky',
              )
              .having((w) => w.conditions.first.icon, 'weather icon', '01d')
              .having((w) => w.main.temp, 'temp', 302.54)
              .having((w) => w.main.humidity, 'humidity', 55)
              .having((w) => w.wind.speed, 'wind speed', 0.82),
        );
      });
    });
  });
}
