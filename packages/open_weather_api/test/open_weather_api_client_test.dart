import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';
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
  });
}
