import 'dart:convert';

import 'package:flutter/material.dart';

import '../models/models.dart';
import '../provider/provider.dart';

class LocationRepository {
  final LocationProvider _provider = LocationProvider();

  Future<Location> coordinates(
      {required double lat, required double lon}) async {
    try {
      final response = await _provider.coordinates(lat: lat, lon: lon);

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        return Location.fromJson(json[0]);
      } else {
        throw Exception('Failed to load location');
      }
    } catch (e) {
      debugPrint(e.toString());
      return Future.error(e.toString());
    }
  }

  Future<List<Location>> name(String name) async {
    try {
      final response = await _provider.name(name);

      if (response.statusCode == 200) {
        final json = await jsonDecode(response.body) as Map<String, dynamic>;

        final locations = <Location>[];
        if (json.containsKey('results') == false) {
          return locations;
        }
        final results = json['results'] as List<dynamic>;
        for (final locationJson in results) {
          final location = Location.fromOpenMeteoJson(locationJson);
          locations.add(location);
        }
        return locations;
      } else {
        throw Exception('Failed to load location');
      }
    } catch (e) {
      debugPrint(e.toString());
      return Future.error(e.toString());
    }
  }
}
