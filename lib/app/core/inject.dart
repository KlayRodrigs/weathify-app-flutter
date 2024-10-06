import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:weathify/app/core/wt_router_config.dart';
import 'package:weathify/app/data/weather_repository.dart';

GetIt inject = GetIt.instance;

Future<void> setupInjection() async {
  await inject.reset();

  inject.registerSingleton(GlobalKey<NavigatorState>(), instanceName: "global");
  inject.registerFactory<WTRouterConfig>(
    () => WTRouterConfig(rootNavigatorKey: inject<GlobalKey<NavigatorState>>(instanceName: "global")),
  );
  inject.registerFactory<Dio>(() => Dio());
  inject.registerFactory<WeatherRepository>(() => WeatherRepository(dio: inject<Dio>()));

  return inject.allReady();
}
