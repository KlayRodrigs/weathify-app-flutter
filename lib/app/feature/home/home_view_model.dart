import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:weathify/app/core/safe_notifier.dart';
import 'package:weathify/app/data/weather_repository.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:weathify/app/theme/app_colors.dart';

enum HomeStatus {
  LOADING,
  CONTENT,
  ERROR;

  bool get isLoading => this == HomeStatus.LOADING;
  bool get isContent => this == HomeStatus.CONTENT;
  bool get isError => this == HomeStatus.ERROR;
}

class HomeViewModel with ChangeNotifier, SafeNotifierMixin {
  HomeViewModel(this.weatherRepository);

  WeatherRepository? weatherRepository;
  Response? airQualityResponse;
  Response? weatherResponse;
  HomeStatus status = HomeStatus.LOADING;

  DateTime afterTime = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day, 5, 0, 0);
  DateTime beforeTime = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day, 18, 0, 0);
  bool isDay = true;
  String? airRate;
  String? weatherCondition;
  String? dayMoment;
  String? formatedTime;
  String? cityName;
  int airQualityIndex = 0;
  int? humidity;
  double? windSpeed;
  double temperatureKelvinToCelsius = 0;
  double? feelsLike;
  double? lat;
  double? lon;

  void checkIfDay() => isDay = DateTime.now().isBefore(beforeTime) && DateTime.now().isAfter(afterTime);

  Future<void> init() async {
    try {
      emitLoading();
      checkIfDay();
      await setLocation();
      await fetchAllWeatherInfo();
      showAllWeatherInfo();
      fetchData();
      emitContent();
    } catch (e) {
      emitError();
      throw Exception("Error to fetch the weather info.");
    }
  }

  Future<void> showAllWeatherInfo() async {
    while (true) {
      fetchAirQuality();
      fetchImage();
      await Future.delayed(const Duration(minutes: 1));
      fetchAllWeatherInfo();
    }
  }

  void fetchData() async {
    while (true) {
      cityName = weatherResponse!.data["name"];
      temperatureKelvinToCelsius = weatherResponse!.data["main"]["temp"] - 273.15;
      feelsLike = weatherResponse!.data["main"]["feels_like"] - 273.15;
      humidity = weatherResponse!.data["main"]["humidity"];
      windSpeed = weatherResponse!.data["wind"]["speed"] * 3.6;
      await Future.delayed(const Duration(minutes: 1));
    }
  }

  Future<void> fetchAllWeatherInfo() async {
    try {
      weatherResponse = await weatherRepository!.getWeatherInfo(lat: lat, lon: lon);
      airQualityResponse = await weatherRepository!.getAirQualityInfo(lat: lat, lon: lon);
    } catch (e) {
      emitError();
      throw Exception("Error to fetch the weather info");
    }
  }

  Future<void> fetchAirQuality() async {
    try {
      var tempIqi = airQualityResponse!.data["list"][0]["main"]["aqi"];
      switch (tempIqi) {
        case 1:
          airRate = "Good";
          break;
        case 2:
          airRate = "Fair";
          break;
        case 3:
          airRate = "Moderate";
          break;
        case 4:
          airRate = "Poor";
          break;
        case 5:
          airRate = "Very Poor";
          break;
      }
      airQualityIndex = tempIqi;
    } catch (e) {
      throw Exception("Error to fetch the air quality info");
    }
  }

  Future<void> fetchImage() async {
    try {
      var weatherCode = weatherResponse!.data["weather"][0]["id"];
      dayMoment = isDay ? "day" : "night";
      switch (weatherCode) {
        case == 200 || == 201 || == 202 || == 210 || == 211 || == 221 || == 230 || == 231 || == 232:
          weatherCondition = "storm";
          break;
        case == 500 || == 501 || == 502 || == 503 || == 504 || == 511 || == 520 || == 521 || == 522 || == 531:
          weatherCondition = "rain";
          break;
        case == 800 || == 801 || == 802:
          weatherCondition = "clear_$dayMoment";
          break;
        case == 803 || == 804:
          weatherCondition = "cloudly_$dayMoment";
          break;
        default:
          weatherCondition = "clear_$dayMoment";
      }
    } catch (e) {
      throw Exception("Error to fetch the day phase info");
    }
  }

  Future<void> getLocationPermission(BuildContext context) async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }
    if (permission == LocationPermission.denied || permission == LocationPermission.deniedForever) {
      if (context.mounted) {
        await showDialog(
          barrierDismissible: false,
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text(S.of(context)!.errorPermissionDialogTitle),
              content: Text(
                S.of(context)!.errorPermissionDialogDescription,
              ),
              actions: [
                TextButton(
                  onPressed: () async {
                    permission = await Geolocator.checkPermission();
                    if (permission == LocationPermission.whileInUse) {
                      if (context.mounted) Navigator.of(context).pop();
                    }
                  },
                  child: Text(
                    S.of(context)!.errorPermissionDialogContinueButtonLabel,
                    style: const TextStyle(color: AppColors.oldBlood),
                  ),
                ),
                TextButton(
                  onPressed: () async {
                    await openAppSettings().then(
                      (_) async => permission = await Geolocator.checkPermission(),
                    );
                  },
                  child: Text(S.of(context)!.errorPermissionDialogSettingsButtonLabel),
                ),
              ],
            );
          },
        );
      }
    } else {
      setLocation();
    }
  }

  Future<void> setLocation() async {
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.best);
    lat = position.latitude;
    lon = position.longitude;
  }

  emitLoading() {
    status = HomeStatus.LOADING;
    notify();
  }

  emitContent() {
    status = HomeStatus.CONTENT;
    notify();
  }

  emitError() {
    status = HomeStatus.ERROR;
    notify();
  }
}
