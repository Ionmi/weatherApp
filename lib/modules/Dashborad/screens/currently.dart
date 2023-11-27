import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app_v2_proj/constants/weather_map_constants.dart';
import 'package:weather_app_v2_proj/modules/Dashborad/bloc/weather_bloc.dart';
import 'package:weather_app_v2_proj/modules/Dashborad/models/weather.dart';

class Currently extends StatelessWidget {
  const Currently({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              BlocBuilder<WeatherBloc, WeatherState>(
                builder: (context, state) {
                  if (state is WeatherLoading) {
                    return const CircularProgressIndicator(color: Colors.white);
                  } else if (state is WeatherError) {
                    return Text(state.message);
                  } else if (state is WeatherLoaded) {
                    final weather = state.weather;
                    final location = state.location;
                    final current = weather.current;
                    return Column(
                      children: [
                        Text(
                          location.name,
                          style: const TextStyle(
                              fontSize: 30, color: Colors.white),
                        ),
                        Text(
                          subheadline(location.region, location.country),
                          style: const TextStyle(
                              fontSize: 20, color: Colors.black),
                        ),
                        const SizedBox(height: 30),
                        Text(
                          "${current.temperature}°C",
                          style: TextStyle(
                            fontSize: 45,
                            color: Colors.blueGrey[800],
                          ),
                        ),
                        const SizedBox(height: 30),
                        WeatherInterpretation(current: current),
                        const SizedBox(height: 30),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.air,
                              color: Colors.blueAccent,
                              size: 30,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              "${current.windspeed} km/h",
                              style: const TextStyle(fontSize: 20),
                            ),
                          ],
                        ),
                      ],
                    );
                  } else {
                    return const Text("Search for a city");
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

String subheadline(String? region, String? country) {
  if (region != null && country != null) {
    return "$region, $country";
  } else if (region != null) {
    return region;
  } else if (country != null) {
    return country;
  } else {
    return "";
  }
}

class WeatherInterpretation extends StatelessWidget {
  const WeatherInterpretation({
    super.key,
    required this.current,
  });

  final Day current;

  @override
  Widget build(BuildContext context) {
    final info = weatherCodeToInfo[current.weathercode];
    return Column(
      children: [
        Icon(info!.icon, size: 50, color: Colors.blueAccent),
        const SizedBox(height: 10),
        Text(
          info.text,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Colors.blueGrey[800],
          ),
        ),
      ],
    );
  }
}
