import 'package:amplitude_flutter/amplitude.dart';
import 'package:weathify/app/key/api_key.dart';

class AmplitudeAnalytics {
  Future<void> appInitialized() async {
    final Amplitude analytics = Amplitude.getInstance(instanceName: "weathify");
    analytics.init(apiKeyAmplitude.toString());

    analytics.logEvent('App initialized');
  }
}
