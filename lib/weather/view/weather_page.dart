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
  final TextEditingController _textController = TextEditingController();

  String get _text => _textController.text;

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

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
                TextField(
                  controller: _textController,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.place),
                    suffixIcon: IconButton.filled(
                      onPressed: () async {
                        await context.read<WeatherCubit>().fetchWeather(_text);
                      },
                      icon: const Icon(Icons.search),
                      color: Colors.black,
                      splashColor: const Color.fromARGB(255, 199, 220, 234),
                    ),
                    hintText: 'Enter your location',
                    border: InputBorder.none,
                  ),
                  onSubmitted: (value) async {
                    await context.read<WeatherCubit>().fetchWeather(_text);
                  },
                ),
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
