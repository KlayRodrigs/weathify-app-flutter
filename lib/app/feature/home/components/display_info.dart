import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:weathify/app/feature/home/home_view_model.dart';
import 'package:weathify/app/theme/app_colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class DisplayInfo extends StatefulWidget {
  const DisplayInfo({super.key});

  @override
  State<DisplayInfo> createState() => _DisplayInfoState();
}

class _DisplayInfoState extends State<DisplayInfo> {
  HomeViewModel? model;
  String? formatedTime;

  @override
  void initState() {
    super.initState();
    model = context.read();
    WidgetsBinding.instance.addPostFrameCallback((_) async => await updateHours());
  }

  Future<void> updateHours() async {
    while (true) {
      setState(() {
        model!.checkIfDay();
        formatedTime = DateFormat("HH:mm:ss").format(DateTime.now());
      });
      await Future.delayed(const Duration(seconds: 1));
    }
  }

  @override
  Widget build(BuildContext context) {
    model = context.watch();

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 30.0),
          child: SvgPicture.asset("assets/icons/${model!.weatherCondition}.svg", height: 60),
        ).animate().fadeIn(duration: const Duration(seconds: 1)),
        const SizedBox(height: 10),
        Center(
          child: Text(
            S.of(context)!.weatherCardTemperatureText(model!.temperatureKelvinToCelsius.toStringAsFixed(0)),
            style: const TextStyle(
              color: AppColors.whiteBlackout,
              fontSize: 60,
            ),
          ),
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              model!.cityName.toString(),
              style: const TextStyle(color: AppColors.whiteBlackout, fontSize: 16, fontWeight: FontWeight.w800),
            ),
            const SizedBox(width: 20),
            Text(
              DateFormat("dd/MM/yyyy").format(DateTime.now()),
              style: const TextStyle(color: AppColors.whiteBlackout, fontSize: 16),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Center(
          child: Text(formatedTime ?? "", style: const TextStyle(color: AppColors.whiteBlackout, fontSize: 16)).animate().fadeIn(
                delay: const Duration(milliseconds: 500),
              ),
        ),
      ],
    );
  }
}
