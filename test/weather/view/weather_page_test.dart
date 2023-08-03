// ignore_for_file: prefer_const_constructors

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_weather/settings/settings.dart';
import 'package:flutter_weather/weather/weather.dart';
import 'package:mocktail/mocktail.dart';
import 'package:weather_repository/weather_repository.dart' hide Weather;

import '../../helpers/hydrated_bloc.dart';

class MockWeatherRepository extends Mock implements WeatherRepository {}

class MockWeatherCubit extends MockCubit<WeatherState>
    implements WeatherCubit {}

void main() {
  initHydratedStorage();

  group('WeatherPage', () {
    late WeatherRepository weatherRepository;

    setUp(() {
      weatherRepository = MockWeatherRepository();
    });

    testWidgets('renders WeatherPage', (tester) async {
      await tester.pumpWidget(
        RepositoryProvider.value(
          value: weatherRepository,
          child: MaterialApp(home: WeatherPage()),
        ),
      );
      expect(find.byType(WeatherView), findsOneWidget);
    });
  });

  group('WeatherPage', () {
    final weather = Weather(
      location: 'London',
      condition: WeatherConditionEnum.clear,
      conditionDescription: 'Clear Sky',
      temperature: 30,
      humidity: 70,
      windSpeed: 20,
      lastUpdated: DateTime(2023),
    );
    late WeatherCubit weatherCubit;

    setUp(() {
      weatherCubit = MockWeatherCubit();
    });

    testWidgets('renders WeatherSearchBar for WeatherStatus.initial',
        (tester) async {
      when(() => weatherCubit.state).thenReturn(WeatherState());
      await tester.pumpWidget(
        BlocProvider.value(
          value: weatherCubit,
          child: MaterialApp(home: WeatherView()),
        ),
      );
      expect(find.byType(WeatherSearchBar), findsOneWidget);
    });

    testWidgets('renders WeatherLoading for WeatherStatus.loading',
        (tester) async {
      when(() => weatherCubit.state).thenReturn(
        WeatherState(
          status: WeatherStatus.loading,
        ),
      );
      await tester.pumpWidget(
        BlocProvider.value(
          value: weatherCubit,
          child: MaterialApp(home: WeatherView()),
        ),
      );
      expect(find.byType(WeatherLoading), findsOneWidget);
    });

    testWidgets('renders WeatherPopulated for WeatherStatus.success',
        (tester) async {
      when(() => weatherCubit.state).thenReturn(
        WeatherState(
          status: WeatherStatus.success,
          weather: weather,
        ),
      );
      await tester.pumpWidget(
        BlocProvider.value(
          value: weatherCubit,
          child: MaterialApp(home: WeatherView()),
        ),
      );
      expect(find.byType(WeatherPopulated), findsOneWidget);
    });

    testWidgets('renders WeatherError for WeatherStatus.failure',
        (tester) async {
      when(() => weatherCubit.state).thenReturn(
        WeatherState(
          status: WeatherStatus.failure,
        ),
      );
      await tester.pumpWidget(
        BlocProvider.value(
          value: weatherCubit,
          child: MaterialApp(home: WeatherView()),
        ),
      );
      expect(find.byType(WeatherError), findsOneWidget);
    });

    testWidgets('state is cached', (tester) async {
      when<dynamic>(() => hydratedStorage.read('$WeatherCubit')).thenReturn(
        WeatherState(
          status: WeatherStatus.success,
          weather: weather,
          temperatureUnits: TemperatureUnits.fahrenheit,
        ).toJson(),
      );
      await tester.pumpWidget(
        BlocProvider.value(
          value: WeatherCubit(MockWeatherRepository()),
          child: MaterialApp(home: WeatherView()),
        ),
      );
      expect(find.byType(WeatherPopulated), findsOneWidget);
    });

    testWidgets('navigates to SettingsPage when settings icon is tapped',
        (tester) async {
      when(() => weatherCubit.state).thenReturn(WeatherState());
      await tester.pumpWidget(
        BlocProvider.value(
          value: weatherCubit,
          child: MaterialApp(home: WeatherView()),
        ),
      );
      await tester.tap(find.byIcon(Icons.settings));
      await tester.pumpAndSettle();
      expect(find.byType(SettingsPage), findsOneWidget);
    });

    testWidgets('triggers refreshWeather on pull to refresh', (tester) async {
      when(() => weatherCubit.state).thenReturn(
        WeatherState(
          status: WeatherStatus.success,
          weather: weather,
        ),
      );
      when(() => weatherCubit.refreshWeather()).thenAnswer((_) async {});
      await tester.pumpWidget(
        BlocProvider.value(
          value: weatherCubit,
          child: MaterialApp(home: WeatherView()),
        ),
      );
      await tester.fling(
        find.text('30°C'),
        const Offset(0, 500),
        1000,
      );
      await tester.pumpAndSettle();
      verify(() => weatherCubit.refreshWeather()).called(1);
    });

    testWidgets('triggers fetch on search bar icon tapped', (tester) async {
      when(() => weatherCubit.state).thenReturn(WeatherState());
      when(() => weatherCubit.fetchWeather(any())).thenAnswer((_) async {});
      await tester.pumpWidget(
        BlocProvider.value(
          value: weatherCubit,
          child: MaterialApp(home: WeatherView()),
        ),
      );
      await tester.enterText(find.byType(TextField), 'Chicago');
      await tester.tap(find.byIcon(Icons.search));
      await tester.pumpAndSettle();
      verify(() => weatherCubit.fetchWeather('Chicago')).called(1);
    });
  });
}
