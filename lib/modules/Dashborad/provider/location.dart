import 'package:http/http.dart' as http;
import 'package:weather_app_v2_proj/constants/api_path.dart';

class LocationProvider {
  Future<http.Response> coordinates(
      {required double lat, required double lon}) async {
    return await http.get(GeolocationApiPaths.coordinates(lat: lat, lon: lon));
  }

  Future<http.Response> name(String name) async {
    return await http.get(GeolocationApiPaths.name(name));
  }
}
