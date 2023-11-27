import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../modules/Dashborad/models/models.dart';

final weatherCodeToInfo = {
  0: WeatherInfo('Clear sky', Icons.wb_sunny_rounded),
  1: WeatherInfo('Mainly clear', Icons.wb_sunny_rounded),
  2: WeatherInfo('Partly cloudy', MdiIcons.weatherPartlyCloudy),
  3: WeatherInfo('Overcast', Icons.cloud),
  45: WeatherInfo('Fog', Icons.cloud),
  48: WeatherInfo('Depositing rime fog', Icons.foggy),
  51: WeatherInfo('Light Drizzle', MdiIcons.weatherPartlyRainy),
  53: WeatherInfo('Moderate Drizzle', MdiIcons.weatherRainy),
  55: WeatherInfo('Dense Drizzle', MdiIcons.weatherRainy),
  56: WeatherInfo('Light Freezing Drizzle', MdiIcons.weatherRainy),
  57: WeatherInfo('Dense Freezing Drizzle', MdiIcons.weatherRainy),
  61: WeatherInfo('Slight Rain', MdiIcons.weatherPartlyRainy),
  63: WeatherInfo('Moderate Rain', MdiIcons.weatherPartlyRainy),
  65: WeatherInfo('Heavy Rain', MdiIcons.weatherPouring),
  66: WeatherInfo('Light Freezing Rain', MdiIcons.weatherPouring),
  67: WeatherInfo('Heavy Freezing Rain', MdiIcons.weatherPouring),
  71: WeatherInfo('Slight Snow fall', Icons.ac_unit),
  73: WeatherInfo('Moderate Snow fall', Icons.ac_unit),
  75: WeatherInfo('Heavy Snow fall', Icons.ac_unit),
  77: WeatherInfo('Snow grains', Icons.ac_unit),
  80: WeatherInfo('Slight Rain showers', MdiIcons.weatherRainy),
  81: WeatherInfo('Moderate Rain showers', MdiIcons.weatherRainy),
  82: WeatherInfo('Violent Rain showers', MdiIcons.weatherRainy),
  85: WeatherInfo('Snow showers slight', Icons.ac_unit),
  86: WeatherInfo('Snow showers heavy', Icons.ac_unit),
  95: WeatherInfo('Slight Thunderstorm', Icons.thunderstorm),
  96: WeatherInfo('Heavy Thunderstorm', Icons.thunderstorm),
  99: WeatherInfo('Heavy Thunderstorm', Icons.thunderstorm),
};
