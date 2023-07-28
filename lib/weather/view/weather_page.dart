import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_weather/settings/settings.dart';
import 'package:flutter_weather/weather/weather.dart';
import 'package:weather_repository/weather_repository.dart';

class WeatherPage extends StatelessWidget {
  const WeatherPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => WeatherCubit(context.read<WeatherRepository>()),
      child: const WeatherView(),
    );
  }
}

class WeatherView extends StatefulWidget {
  const WeatherView({super.key});

  @override
  State<WeatherView> createState() => _WeatherViewState();
}

class _WeatherViewState extends State<WeatherView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Weather'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push<void>(
                SettingsPage.route(context.read<WeatherCubit>()),
              );
            },
            icon: const Icon(Icons.settings),
          )
        ],
      ),
      body: Center(
        child: BlocConsumer<WeatherCubit, WeatherState>(
          listener: (context, state) {},
          builder: (context, state) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const WeatherSearchBar(),
                _WeatherContent(
                  state: state,
                  onRefresh: () async {
                    await context.read<WeatherCubit>().refreshWeather();
                  },
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _WeatherContent extends StatelessWidget {
  const _WeatherContent({required this.state, required this.onRefresh});

  final WeatherState state;
  final ValueGetter<Future<void>> onRefresh;

  @override
  Widget build(BuildContext context) {
    switch (state.status) {
      case WeatherStatus.initial:
        return const Spacer();
      case WeatherStatus.loading:
        return const WeatherLoading();
      case WeatherStatus.failure:
        return const WeatherError();
      case WeatherStatus.success:
        return WeatherPopulated(
          weather: state.weather,
          units: state.temperatureUnits,
          onRefresh: onRefresh,
        );
    }
  }
}
