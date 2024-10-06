import 'package:flutter/material.dart';
import 'package:weathify/app/theme/app_colors.dart';

class MoonPhase extends StatelessWidget {
  const MoonPhase({super.key, required this.thisPhase, required this.name, required this.image});
  final bool thisPhase;
  final String name;
  final String image;

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: name,
      showDuration: const Duration(seconds: 2),
      textStyle: const TextStyle(color: AppColors.whiteBlackout),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.greyBox),
        color: AppColors.blackBox,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Opacity(
        opacity: thisPhase ? 1 : 0.29,
        child: Image.asset(image, height: thisPhase ? 50 : 40),
      ),
    );
  }
}
