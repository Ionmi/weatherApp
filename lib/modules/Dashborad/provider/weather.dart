import 'package:http/http.dart' as http;
import 'package:weather_app_v2_proj/constants/api_path.dart';

class WeatherProvider {
  Future<http.Response> todaysWeather(
      {required double lat, required double lon}) async {
    return await http.get(WeatherApiPaths.todaysWeather(lat: lat, lon: lon));
  }

  Future<http.Response> weekWeather(
      {required double lat, required double lon}) async {
    return await http.get(WeatherApiPaths.weekWeather(lat: lat, lon: lon));
  }
}
