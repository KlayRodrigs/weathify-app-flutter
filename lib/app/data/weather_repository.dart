import 'package:dio/dio.dart';
import 'package:weathify/app/key/api_key.dart';

class WeatherRepository {
  WeatherRepository({required this.dio});
  final Dio dio;
  Options options = Options(receiveTimeout: const Duration(seconds: 10));

  Future<Response> getWeatherInfo({required double? lat, required double? lon}) async {
    Response response = await dio.get(
      "https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lon&appid=$API_KEY",
      options: options,
    );
    return response;
  }

  Future<Response> getAirQualityInfo({required double? lat, required double? lon}) async {
    Response response = await dio.get(
      "http://api.openweathermap.org/data/2.5/air_pollution?lat=$lat&lon=$lon&appid=$API_KEY",
      options: options,
    );
    return response;
  }
}
