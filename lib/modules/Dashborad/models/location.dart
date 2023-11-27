import 'package:json_annotation/json_annotation.dart';

part 'location.g.dart';

@JsonSerializable()
class Location {
  const Location({
    required this.name,
    required this.country,
    this.region,
    required this.lat,
    required this.lon,
  });

  factory Location.fromJson(Map<String, dynamic> json) =>
      _$LocationFromJson(json);

  factory Location.fromOpenMeteoJson(Map<String, dynamic> json) =>
      _$LocationFromOpenMeteoJson(json);

  Map<String, dynamic> toJson() => _$LocationToJson(this);

  Map<String, dynamic> toOpenMeteoJson() => _$LocationToOpenMeteoJson(this);

  final String name;
  final String? country;
  final String? region;
  final double lat;
  final double lon;
}
