import 'dart:core';

enum MoonPhaseStatus {
  NEW,
  WAXING_CRESCENT,
  FIRST_QUARTER,
  WAXING_GIBBOUS,
  FULL,
  WANING_GIBBOUS,
  LAST_QUARTER,
  WANING_CRESCENT;

  bool get isNew => this == MoonPhaseStatus.NEW;
  bool get isWaxingCrescent => this == MoonPhaseStatus.WAXING_CRESCENT;
  bool get isFirstQuarter => this == MoonPhaseStatus.FIRST_QUARTER;
  bool get isWaxingGibbous => this == MoonPhaseStatus.WAXING_GIBBOUS;
  bool get isFull => this == MoonPhaseStatus.FULL;
  bool get isWaningGibbous => this == MoonPhaseStatus.WANING_GIBBOUS;
  bool get isLastQuarter => this == MoonPhaseStatus.LAST_QUARTER;
  bool get isWaningCrescent => this == MoonPhaseStatus.WANING_CRESCENT;
}

MoonPhaseStatus getLunarPhase() {
  DateTime baseDate = DateTime(2023, 10, 14);
  int daysSinceBase = DateTime.now().difference(baseDate).inDays;

  double lunarCycle = 29.53;
  double phaseIndex = (daysSinceBase % lunarCycle) % lunarCycle;
  int phaseIndexInt = (phaseIndex * 100 / lunarCycle).toInt();

  switch (phaseIndexInt) {
    case var value when value < 10:
      return MoonPhaseStatus.NEW;
    case var value when value < 40:
      return MoonPhaseStatus.WAXING_CRESCENT;
    case var value when value < 70:
      return MoonPhaseStatus.FIRST_QUARTER;
    case var value when value < 90:
      return MoonPhaseStatus.WAXING_GIBBOUS;
    case var value when value < 100:
      return MoonPhaseStatus.FULL;
    case var value when value < 130:
      return MoonPhaseStatus.WANING_GIBBOUS;
    case var value when value < 160:
      return MoonPhaseStatus.LAST_QUARTER;
    case var value when value < 190:
      return MoonPhaseStatus.WANING_CRESCENT;
    default:
      return MoonPhaseStatus.NEW;
  }
}
