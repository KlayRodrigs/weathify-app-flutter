import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';
import 'package:weathify/app/feature/home/components/weather_card.dart';
import 'package:weathify/app/feature/home/home_view_model.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class WeatherCardsSection extends StatefulWidget {
  const WeatherCardsSection({super.key});

  @override
  State<WeatherCardsSection> createState() => _WeatherCardsSectionState();
}

class _WeatherCardsSectionState extends State<WeatherCardsSection> {
  HomeViewModel? model;

  @override
  void initState() {
    super.initState();
    model = context.read();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        WeatherCard(
          isUncommon: false,
          tooltipText: S.of(context)!.homeScreenThermalSense,
          imagePath: "assets/icons/hot.png",
          value: S.of(context)!.weatherCardFeelsLikeText(model!.feelsLike!.toStringAsFixed(0)),
        ).animate().fadeIn(delay: const Duration(milliseconds: 600)),
        WeatherCard(
          isUncommon: model!.humidity! < 30,
          tooltipText: S.of(context)!.homeScreenRelativeHumidity,
          imagePath: "assets/icons/humidity1.png",
          value: S.of(context)!.weatherCardHumidityText(model!.humidity!.toStringAsFixed(0)),
        ).animate().fadeIn(delay: const Duration(milliseconds: 900)),
        WeatherCard(
          isUncommon: false,
          tooltipText: S.of(context)!.homeScreenWindSpeedForce,
          imagePath: "assets/icons/wind.png",
          value: S.of(context)!.weatherCardWindSpeedText(model!.windSpeed!.toStringAsFixed(0)),
        ).animate().fadeIn(delay: const Duration(milliseconds: 1200)),
        WeatherCard(
          isUncommon: model!.airQualityIndex == 4 || model!.airQualityIndex == 5,
          tooltipText: S.of(context)!.homeScreenAirQuality,
          imagePath: "assets/icons/air-quality.png",
          value: S.of(context)!.weatherCardAirQualityText(model!.airRate.toString()),
        ).animate().fadeIn(delay: const Duration(milliseconds: 1500)),
      ],
    );
  }
}
