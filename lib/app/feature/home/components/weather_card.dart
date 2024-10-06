import 'package:flutter/material.dart';
import 'package:weathify/app/theme/app_colors.dart';

class WeatherCard extends StatelessWidget {
  const WeatherCard({super.key, required this.tooltipText, required this.imagePath, required this.value, required this.isUncommon});
  final String tooltipText;
  final String imagePath;
  final String value;
  final bool isUncommon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: Tooltip(
        message: tooltipText,
        showDuration: const Duration(seconds: 2),
        textStyle: const TextStyle(color: AppColors.whiteBlackout),
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.greyBox),
          color: AppColors.blackBox,
          borderRadius: BorderRadius.circular(6),
        ),
        child: Container(
          width: 300,
          height: 80,
          decoration: BoxDecoration(color: AppColors.solidMotherRock, borderRadius: BorderRadius.circular(20)),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset(imagePath, width: 50),
                Text(
                  value,
                  style: TextStyle(
                    color: isUncommon ? AppColors.bloody : AppColors.whiteBlackout,
                    fontSize: 20,
                    fontWeight: isUncommon ? FontWeight.w500 : null,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
