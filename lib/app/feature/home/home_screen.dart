import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';
import 'package:weathify/app/core/inject.dart';
import 'package:weathify/app/data/weather_repository.dart';
import 'package:weathify/app/feature/home/components/display_info.dart';
import 'package:weathify/app/feature/home/components/weather_card.dart';
import 'package:weathify/app/feature/home/home_view_model.dart';
import 'package:weathify/app/theme/app_colors.dart';
import 'package:weathify/app/widgets/wt_error.dart';
import 'package:weathify/app/widgets/wt_loading.dart';
import 'package:weathify/app/feature/home/components/all_moon_phases.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  static Widget create() {
    return ChangeNotifierProvider(create: (context) => HomeViewModel(inject<WeatherRepository>()), child: const HomeScreen());
  }

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final WeatherRepository weatherRepository = inject<WeatherRepository>();
  HomeViewModel? model;

  @override
  void initState() {
    super.initState();
    model = context.read<HomeViewModel>();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await model!.getLocationPermission(context);
      await model!.init();
      model!.showAll();
    });
  }

  @override
  Widget build(BuildContext context) {
    model = context.watch<HomeViewModel>();

    if (model!.status.isLoading) return const WTLoading();
    if (model!.status.isError) {
      return WTError(onErrorTap: () async {
        await model!.init();
        model!.showAll();
      });
    }

    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          gradient: LinearGradient(colors: AppColors.blackoutGradient, begin: Alignment.topCenter),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            model!.isDay
                ? Padding(
                    padding: const EdgeInsets.only(top: 50.0),
                    child: const Text("").animate().fadeIn(duration: const Duration(seconds: 1)),
                  )
                : const AllMoonPhases().animate().fadeIn(duration: const Duration(seconds: 1)),
            const DisplayInfo(),
            const SizedBox(height: 40),
            WeatherCard(
              isUncommon: false,
              tooltipText: S.of(context)!.homeScreenThermalSense,
              imagePath: "assets/icons/hot.png",
              value: S.of(context)!.weatherCardFeelsLikeText(model!.feelsLike!.toStringAsFixed(0)),
            ),
            WeatherCard(
              isUncommon: false,
              tooltipText: S.of(context)!.homeScreenRelativeHumidity,
              imagePath: "assets/icons/humidity1.png",
              value: S.of(context)!.weatherCardHumidityText(model!.humidity!.toStringAsFixed(0)),
            ),
            WeatherCard(
              isUncommon: false,
              tooltipText: S.of(context)!.homeScreenWindSpeedForce,
              imagePath: "assets/icons/wind.png",
              value: S.of(context)!.weatherCardWindSpeedText(model!.windSpeed!.toStringAsFixed(0)),
            ),
            WeatherCard(
              isUncommon: model!.aqi == 4 || model!.aqi == 5,
              tooltipText: S.of(context)!.homeScreenAirQuality,
              imagePath: "assets/icons/air-quality.png",
              value: S.of(context)!.weatherCardAirQualityText(model!.airRate.toString()),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
