import 'package:flutter/material.dart';

class WeatherError extends StatelessWidget {
  const WeatherError({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(height: 16),
        Image.asset(
          'assets/images/404.png',
          scale: 1.5,
        ),
        const SizedBox(height: 16),
        Text(
          'Oops! Invalid location :/',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ],
    );
  }
}
