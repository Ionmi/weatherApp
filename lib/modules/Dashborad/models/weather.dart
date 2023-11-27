import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'weather.g.dart';

class Weather {
  Weather({
    required this.latitude,
    required this.longitude,
    required this.daily,
    required this.current,
    required this.hourly,
  });

  Map<String, dynamic> toJson() => _$WeatherToJson(this);

  double latitude;
  double longitude;
  List<Daily> daily;
  Day current;
  List<Day> hourly;
}

@JsonSerializable()
class Daily {
  Daily({
    required this.time,
    required this.weathercode,
    required this.temperature2MMax,
    required this.temperature2MMin,
  });

  factory Daily.fromJson(Map<String, dynamic> json) => _$DailyFromJson(json);
  Map<String, dynamic> toJson() => _$DailyToJson(this);

  DateTime time;
  int weathercode;
  double temperature2MMax;
  double temperature2MMin;
}

@JsonSerializable()
class Day {
  Day({
    required this.time,
    required this.temperature,
    required this.weathercode,
    required this.windspeed,
  });

  factory Day.fromJson(Map<String, dynamic> json) => _$DayFromJson(json);
  Map<String, dynamic> toJson() => _$DayToJson(this);

  DateTime time;
  double temperature;
  int weathercode;
  double windspeed;
}

class WeatherInfo {
  final String text;
  final IconData icon;

  WeatherInfo(this.text, this.icon);
}
