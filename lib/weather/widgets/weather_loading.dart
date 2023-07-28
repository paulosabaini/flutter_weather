import 'package:flutter/material.dart';

class WeatherLoading extends StatelessWidget {
  const WeatherLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return const CircularProgressIndicator(
      color: Color.fromARGB(255, 6, 40, 61),
    );
  }
}
