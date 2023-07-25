import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_weather/weather/cubit/weather_cubit.dart';
import 'package:flutter_weather/weather/models/weather.dart';
import 'package:mocktail/mocktail.dart';
import 'package:weather_repository/weather_repository.dart'
    as weather_repository;
import '../../helpers/hydrated_bloc.dart';

const weatherLocation = 'London';
const weatherConditionDescription = 'Clear Sky';
const weatherConditionIcon = '01';
const weatherTemperature = 30.0;
const weatherHumidity = 70;
const weatherWindSpeed = 20.0;

class MockWeatherRepository extends Mock
    implements weather_repository.WeatherRepository {}

class MockWeather extends Mock implements weather_repository.Weather {}

void main() {
  initHydratedStorage();

  group('WeatherCubit', () {
    late weather_repository.Weather weather;
    late weather_repository.WeatherRepository weatherRepository;
    late WeatherCubit weatherCubit;

    setUp(() async {
      weather = MockWeather();
      weatherRepository = MockWeatherRepository();
      when(() => weather.location).thenReturn(weatherLocation);
      when(() => weather.temperature).thenReturn(weatherTemperature);
      when(() => weather.conditionDescription)
          .thenReturn(weatherConditionDescription);
      when(() => weather.conditionIcon).thenReturn(weatherConditionIcon);
      when(() => weather.humidity).thenReturn(weatherHumidity);
      when(() => weather.windSpeed).thenReturn(weatherWindSpeed);
      when(
        () => weatherRepository.getWeather(any()),
      ).thenAnswer((_) async => weather);
      weatherCubit = WeatherCubit(weatherRepository);
    });

    test('initial state is correct', () {
      final weatherCubit = WeatherCubit(weatherRepository);
      expect(weatherCubit.state, WeatherState());
    });

    group('toJson/fromJson', () {
      test('work properly', () {
        final weatherCubit = WeatherCubit(weatherRepository);
        expect(
          weatherCubit.fromJson(weatherCubit.toJson(weatherCubit.state)),
          weatherCubit.state,
        );
      });
    });

    group('fetchWeather', () {
      blocTest<WeatherCubit, WeatherState>(
        'emits nothing when city is null',
        build: () => weatherCubit,
        act: (cubit) => cubit.fetchWeather(null),
        expect: () => <WeatherState>[],
      );

      blocTest<WeatherCubit, WeatherState>(
        'emits nothing when city is empty',
        build: () => weatherCubit,
        act: (cubit) => cubit.fetchWeather(''),
        expect: () => <WeatherState>[],
      );

      blocTest<WeatherCubit, WeatherState>(
        'calls getWeather with the correct city',
        build: () => weatherCubit,
        act: (cubit) => cubit.fetchWeather(weatherLocation),
        verify: (_) {
          verify(() => weatherRepository.getWeather(weatherLocation)).called(1);
        },
      );

      blocTest<WeatherCubit, WeatherState>(
        'emits [loading, failure] when getWeather throws',
        setUp: () {
          when(
            () => weatherRepository.getWeather(any()),
          ).thenThrow(Exception('oops'));
        },
        build: () => weatherCubit,
        act: (cubit) => cubit.fetchWeather(weatherLocation),
        expect: () => <WeatherState>[
          WeatherState(status: WeatherStatus.loading),
          WeatherState(status: WeatherStatus.failure),
        ],
      );

      blocTest<WeatherCubit, WeatherState>(
        'emits [loading, success] when getWeather returns',
        build: () => weatherCubit,
        act: (cubit) => cubit.fetchWeather(weatherLocation),
        expect: () => <dynamic>[
          WeatherState(status: WeatherStatus.loading),
          isA<WeatherState>()
              .having((w) => w.status, 'status', WeatherStatus.success)
              .having(
                (w) => w.weather,
                'weather',
                isA<Weather>()
                    .having((w) => w.lastUpdated, 'lastUpdated', isNotNull)
                    .having((w) => w.location, 'location', weatherLocation)
                    .having(
                      (w) => w.temperature,
                      'temperature',
                      weatherTemperature,
                    )
                    .having(
                      (w) => w.conditionDescription,
                      'conditionDescription',
                      weatherConditionDescription,
                    )
                    .having(
                      (w) => w.conditionIconURL,
                      'conditionIconURL',
                      'https://openweathermap.org/img/wn/01@2x.png',
                    )
                    .having((w) => w.humidity, 'humidity', weatherHumidity)
                    .having((w) => w.windSpeed, 'windSpeed', weatherWindSpeed),
              )
        ],
      );

      group('refreshWeather', () {
        blocTest<WeatherCubit, WeatherState>(
          'emits nothing when status is not success',
          build: () => weatherCubit,
          act: (cubit) => cubit.refreshWeather(),
          expect: () => <WeatherState>[],
          verify: (_) {
            verifyNever(() => weatherRepository.getWeather(any()));
          },
        );

        blocTest<WeatherCubit, WeatherState>(
          'emits nothing when location is null',
          build: () => weatherCubit,
          seed: () => WeatherState(status: WeatherStatus.success),
          act: (cubit) => cubit.refreshWeather(),
          expect: () => <WeatherState>[],
          verify: (_) {
            verifyNever(() => weatherRepository.getWeather(any()));
          },
        );

        blocTest<WeatherCubit, WeatherState>(
          'invokes getWeather with correct location',
          build: () => weatherCubit,
          seed: () => WeatherState(
            status: WeatherStatus.success,
            weather: Weather(
              location: weatherLocation,
              conditionDescription: weatherConditionDescription,
              conditionIconURL: weatherConditionIcon,
              temperature: weatherTemperature,
              humidity: weatherHumidity,
              windSpeed: weatherWindSpeed,
              lastUpdated: DateTime(2023),
            ),
          ),
          act: (cubit) => cubit.refreshWeather(),
          verify: (_) {
            verify(() => weatherRepository.getWeather(weatherLocation))
                .called(1);
          },
        );

        blocTest<WeatherCubit, WeatherState>(
          'emits nothing when exception is thrown',
          setUp: () {
            when(
              () => weatherRepository.getWeather(any()),
            ).thenThrow(Exception('oops'));
          },
          build: () => weatherCubit,
          seed: () => WeatherState(
            status: WeatherStatus.success,
            weather: Weather(
              location: weatherLocation,
              conditionDescription: weatherConditionDescription,
              conditionIconURL: weatherConditionIcon,
              temperature: weatherTemperature,
              humidity: weatherHumidity,
              windSpeed: weatherWindSpeed,
              lastUpdated: DateTime(2023),
            ),
          ),
          act: (cubit) => cubit.refreshWeather(),
          expect: () => <WeatherState>[],
        );

        blocTest<WeatherCubit, WeatherState>(
          'emits updated weather',
          build: () => weatherCubit,
          seed: () => WeatherState(
            status: WeatherStatus.success,
            weather: Weather(
              location: weatherLocation,
              conditionDescription: weatherConditionDescription,
              conditionIconURL: weatherConditionIcon,
              temperature: 0,
              humidity: weatherHumidity,
              windSpeed: weatherWindSpeed,
              lastUpdated: DateTime(2023),
            ),
          ),
          act: (cubit) => cubit.refreshWeather(),
          expect: () => <Matcher>[
            isA<WeatherState>()
                .having((w) => w.status, 'status', WeatherStatus.success)
                .having(
                  (w) => w.weather,
                  'weather',
                  isA<Weather>()
                      .having((w) => w.lastUpdated, 'lastUpdated', isNotNull)
                      .having(
                        (w) => w.temperature,
                        'temperature',
                        weatherTemperature,
                      ),
                ),
          ],
        );
      });
    });
  });
}
