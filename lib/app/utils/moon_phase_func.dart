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

int lunarPhaseCalculator(DateTime date) {
  DateTime dateRef = DateTime(2000, 1, 6);
  int days = date.difference(dateRef).inDays;
  int lunarPhase = ((days % 29.53) / 29.53 * 8).floor() % 8;
  return lunarPhase;
}

MoonPhaseStatus getLunarPhase() {
  DateTime date = DateTime.now();
  int lunarPhase = lunarPhaseCalculator(date);

  switch (lunarPhase) {
    case 0:
      return MoonPhaseStatus.NEW;
    case 1:
      return MoonPhaseStatus.WAXING_CRESCENT;
    case 2:
      return MoonPhaseStatus.FIRST_QUARTER;
    case 3:
      return MoonPhaseStatus.WAXING_GIBBOUS;
    case 4:
      return MoonPhaseStatus.FULL;
    case 5:
      return MoonPhaseStatus.WANING_GIBBOUS;
    case 6:
      return MoonPhaseStatus.LAST_QUARTER;
    case 7:
      return MoonPhaseStatus.WANING_CRESCENT;
    default:
      return MoonPhaseStatus.NEW;
  }
}
