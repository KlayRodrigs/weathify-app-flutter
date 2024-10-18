import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';
import 'package:weathify/app/core/amplitude_analytics.dart';
import 'package:weathify/app/core/inject.dart';
import 'package:weathify/app/data/weather_repository.dart';
import 'package:weathify/app/feature/home/components/display_info.dart';
import 'package:weathify/app/feature/home/components/weather_cards_section.dart';
import 'package:weathify/app/feature/home/home_view_model.dart';
import 'package:weathify/app/theme/app_colors.dart';
import 'package:weathify/app/widgets/wt_error.dart';
import 'package:weathify/app/widgets/wt_loading.dart';
import 'package:weathify/app/feature/home/components/all_moon_phases.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  static Widget create() {
    return ChangeNotifierProvider(
        create: (context) => HomeViewModel(
              weatherRepository: inject<WeatherRepository>(),
              amplitudeAnalytics: inject<AmplitudeAnalytics>(),
            ),
        child: const HomeScreen());
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
      await init();
    });
  }

  Future<void> init() async {
    await model!.init(context);
  }

  @override
  Widget build(BuildContext context) {
    model = context.watch<HomeViewModel>();

    if (model!.status.isLoading) return const WTLoading();
    if (model!.status.isError) return WTError(onErrorTap: () async => await init());

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
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
                  : const AllMoonPhases(),
              const DisplayInfo(),
              const SizedBox(height: 40),
              const WeatherCardsSection(),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
