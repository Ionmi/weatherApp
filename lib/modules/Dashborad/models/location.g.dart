// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'location.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Location _$LocationFromJson(Map<String, dynamic> json) => Location(
      name: json['name'] as String,
      country: json['country'] as String,
      region: json['region'] as String?,
      lat: (json['lat'] as num).toDouble(),
      lon: (json['lon'] as num).toDouble(),
    );

Location _$LocationFromOpenMeteoJson(Map<String, dynamic> json) => Location(
      name: json['name'] as String,
      country: json['country'] as String?,
      region: json['admin1'] as String?,
      lat: (json['latitude'] as num).toDouble(),
      lon: (json['longitude'] as num).toDouble(),
    );

Map<String, dynamic> _$LocationToJson(Location instance) => <String, dynamic>{
      'name': instance.name,
      'country': instance.country,
      'region': instance.region,
      'lat': instance.lat,
      'lon': instance.lon,
    };

Map<String, dynamic> _$LocationToOpenMeteoJson(Location instance) =>
    <String, dynamic>{
      'name': instance.name,
      'country': instance.country,
      'admin1': instance.region,
      'latitude': instance.lat,
      'longitude': instance.lon,
    };
