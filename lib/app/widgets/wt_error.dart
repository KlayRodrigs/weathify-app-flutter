import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:weathify/app/theme/app_colors.dart';

class WTError extends StatelessWidget {
  const WTError({super.key, required this.onErrorTap});
  final void Function() onErrorTap;

  @override
  Widget build(BuildContext context) => Center(
        child: Scaffold(
          body: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(colors: AppColors.blackoutGradient, begin: Alignment.topCenter),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 60),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 30.0),
                    child: Image.asset(
                      "assets/icons/cloud-error-2.png",
                      height: 140,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 50.0),
                    child: Text(
                      S.of(context)!.wtErrorDescription,
                      style: const TextStyle(fontSize: 20, color: AppColors.whiteBlackout),
                      textAlign: TextAlign.justify,
                    ),
                  ),
                  TextButton(
                    onPressed: onErrorTap,
                    style: ButtonStyle(
                        shape: WidgetStatePropertyAll(ContinuousRectangleBorder(borderRadius: BorderRadius.circular(12))),
                        backgroundColor: const WidgetStatePropertyAll(AppColors.solidRock)),
                    child: Text(
                      S.of(context)!.wtRefreshButtonLabel,
                      style: const TextStyle(color: AppColors.whiteBlackout),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      );
}
