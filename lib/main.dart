import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:weathify/app/core/inject.dart';
import 'package:weathify/app/core/wt_router_config.dart';

void main() async {
  await setupInjection();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final router = inject<WTRouterConfig>().config();

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Weathify',
      localizationsDelegates: const [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en', ''),
        Locale('pt', 'BR'),
      ],
      routerConfig: router,
    );
  }
}
