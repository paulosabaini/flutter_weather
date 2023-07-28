import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_weather/weather/cubit/weather_cubit.dart';

class WeatherSearchBar extends StatefulWidget {
  const WeatherSearchBar({super.key});

  @override
  State<WeatherSearchBar> createState() => _WeatherSearchBarState();
}

class _WeatherSearchBarState extends State<WeatherSearchBar> {
  final TextEditingController _textController = TextEditingController();

  String get _text => _textController.text;

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 16, right: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
      ),
      child: TextField(
        controller: _textController,
        decoration: InputDecoration(
          prefixIcon: const Icon(
            Icons.place,
            size: 30,
          ),
          suffixIcon: CircleAvatar(
            radius: 25,
            backgroundColor: const Color.fromARGB(255, 199, 220, 234),
            child: IconButton(
              onPressed: () async {
                await context.read<WeatherCubit>().fetchWeather(_text);
              },
              icon: const Icon(
                Icons.search,
                color: Colors.black,
              ),
              iconSize: 30,
            ),
          ),
          hintText: 'Enter your location',
          border: InputBorder.none,
          contentPadding: const EdgeInsets.all(36),
        ),
        onSubmitted: (value) async {
          await context.read<WeatherCubit>().fetchWeather(_text);
        },
      ),
    );
  }
}
