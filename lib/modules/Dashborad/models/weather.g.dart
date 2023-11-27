// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weather.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Map<String, dynamic> _$WeatherToJson(Weather instance) => <String, dynamic>{
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'daily': instance.daily,
      'current': instance.current,
      'hourly': instance.hourly,
    };

Daily _$DailyFromJson(Map<String, dynamic> json) => Daily(
      time: DateTime.parse(json['time'] as String),
      weathercode: json['weathercode'] as int,
      temperature2MMax: (json['temperature_2m_max'] as num).toDouble(),
      temperature2MMin: (json['temperature_2m_min'] as num).toDouble(),
    );

Map<String, dynamic> _$DailyToJson(Daily instance) => <String, dynamic>{
      'time': instance.time.toIso8601String(),
      'weathercode': instance.weathercode,
      'temperature2MMax': instance.temperature2MMax,
      'temperature2MMin': instance.temperature2MMin,
    };

Day _$DayFromJson(Map<String, dynamic> json) => Day(
      time: DateTime.parse(json['time'] as String),
      temperature: (json['temperature_2m'] as num).toDouble(),
      weathercode: json['weathercode'] as int,
      windspeed: (json['windspeed_10m'] as num).toDouble(),
    );

Map<String, dynamic> _$DayToJson(Day instance) => <String, dynamic>{
      'time': instance.time.toIso8601String(),
      'temperature_2m': instance.temperature,
      'weathercode': instance.weathercode,
      'windspeed': instance.windspeed,
    };
