import 'package:weather_app_v2_proj/constants/secret_constants.dart';

class WeatherApiPaths {
  static Uri weekWeather({required double lat, required double lon}) {
    final queryParameters = {
      'latitude': lat.toString(),
      'longitude': lon.toString(),
      'daily': 'weathercode,temperature_2m_max,temperature_2m_min',
      'timezone': 'auto',
    };

    return Uri.https('api.open-meteo.com', '/v1/forecast', queryParameters);
  }

  static Uri todaysWeather({required double lat, required double lon}) {
    final queryParameters = {
      'latitude': lat.toString(),
      'longitude': lon.toString(),
      'hourly': 'temperature_2m,weathercode,windspeed_10m',
      'current': 'temperature_2m,weathercode,windspeed_10m',
      'timezone': 'auto',
      'forecast_days': '2',
    };

    return Uri.https('api.open-meteo.com', '/v1/forecast', queryParameters);
  }
}

class GeolocationApiPaths {
  static Uri coordinates({required double lat, required double lon}) {
    final queryParameters = {
      'lon': lon.toString(),
      'lat': lat.toString(),
      'limit': '1',
      'appid': Secrets.geoApiKey,
    };

    return Uri.http(
        'api.openweathermap.org', '/geo/1.0/reverse', queryParameters);
  }

  static Uri name(String name) {
    final queryParameters = {
      'name': name,
      'count': '5',
    };

    return Uri.https(
        'geocoding-api.open-meteo.com', '/v1/search', queryParameters);
  }
}
