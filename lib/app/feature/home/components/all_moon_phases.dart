import 'package:flutter/material.dart';
import 'package:weathify/app/feature/home/components/moon_phase.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:weathify/app/utils/moon_phase_func.dart';

class AllMoonPhases extends StatefulWidget {
  const AllMoonPhases({super.key});

  @override
  State<AllMoonPhases> createState() => _AllMoonPhasesState();
}

class _AllMoonPhasesState extends State<AllMoonPhases> {
  MoonPhaseStatus? phase;
  @override
  void initState() {
    super.initState();
    phase = getLunarPhase();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 50.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          MoonPhase(
            thisPhase: phase!.isNew,
            name: S.of(context)!.homeScreenMoonNewPhase,
            image: "assets/images/new.png",
          ),
          MoonPhase(
            thisPhase: phase!.isWaxingCrescent,
            name: S.of(context)!.homeScreenMoonWaxingCrescentPhase,
            image: "assets/images/waxing_crescent.png",
          ),
          MoonPhase(
            thisPhase: phase!.isFirstQuarter,
            name: S.of(context)!.homeScreenMoonFirstQuarterPhase,
            image: "assets/images/first_quarter.png",
          ),
          MoonPhase(
            thisPhase: phase!.isWaxingGibbous,
            name: S.of(context)!.homeScreenMoonWaxingGibbousPhase,
            image: "assets/images/waxing_gibbous.png",
          ),
          MoonPhase(
            thisPhase: phase!.isFull,
            name: S.of(context)!.homeScreenMoonFullPhase,
            image: "assets/images/full.png",
          ),
          MoonPhase(
            thisPhase: phase!.isWaningGibbous,
            name: S.of(context)!.homeScreenMoonWaningGibbousPhase,
            image: "assets/images/waning_gibbous.png",
          ),
          MoonPhase(
            thisPhase: phase!.isLastQuarter,
            name: S.of(context)!.homeScreenMoonLastQuarterPhase,
            image: "assets/images/last_quarter.png",
          ),
          MoonPhase(
            thisPhase: phase!.isWaningCrescent,
            name: S.of(context)!.homeScreenMoonWaningCrescentPhase,
            image: "assets/images/waning_crescent.png",
          ),
        ],
      ),
    );
  }
}
