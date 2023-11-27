import 'dart:convert';

import 'package:flutter/material.dart';

import '../models/models.dart';
import '../provider/provider.dart';

class WeatherRepository {
  final WeatherProvider _provider = WeatherProvider();

  Future<Weather> query({required double lat, required double lon}) async {
    try {
      final todaysResponse = await _provider.todaysWeather(lat: lat, lon: lon);
      final weekResponse = await _provider.weekWeather(lat: lat, lon: lon);

      if (todaysResponse.statusCode == 200 && weekResponse.statusCode == 200) {
        final todaysJson = jsonDecode(todaysResponse.body);

        final currentJson = todaysJson['current'] as Map<String, dynamic>;
        final hourlyJson = todaysJson['hourly'] as Map<String, dynamic>;
        final current = Day.fromJson(currentJson);
        var hourly = <Day>[];

        for (var i = 0; i < 48; i++) {
          final day = Day.fromJson({
            'time': hourlyJson['time'][i],
            'temperature_2m': hourlyJson['temperature_2m'][i],
            'weathercode': hourlyJson['weathercode'][i],
            'windspeed_10m': hourlyJson['windspeed_10m'][i],
          });
          hourly.add(day);
        }

        final weekJson = jsonDecode(weekResponse.body);
        final daily = weekJson['daily'] as Map<String, dynamic>;

        final times = daily['time'];
        final maxTemps = daily['temperature_2m_max'];
        final minTemps = daily['temperature_2m_min'];
        final weathercodes = daily['weathercode'];
        var week = <Daily>[];
        for (var i = 0; i < 7; i++) {
          final day = Daily.fromJson({
            'time': times[i],
            'temperature_2m_max': maxTemps[i],
            'temperature_2m_min': minTemps[i],
            'weathercode': weathercodes[i],
          });
          week.add(day);
        }

        return Weather(
          current: current,
          hourly: hourly,
          latitude: lat,
          longitude: lon,
          daily: week,
        );
      } else {
        throw Exception('Failed to load location');
      }
    } catch (e) {
      debugPrint(e.toString());
      return Future.error(e.toString());
    }
  }
}
