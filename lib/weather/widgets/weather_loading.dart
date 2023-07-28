import 'package:flutter/material.dart';

class WeatherLoading extends StatelessWidget {
  const WeatherLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text('Loading Weather'),
        Padding(
          padding: EdgeInsets.all(16),
          child: CircularProgressIndicator(),
        )
      ],
    );
  }
}
