import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:weather_app_v2_proj/modules/Dashborad/models/weather.dart';

import '../../../constants/weather_map_constants.dart';
import '../bloc/weather_bloc.dart';
import 'currently.dart';

class Today extends StatelessWidget {
  const Today({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: SingleChildScrollView(
          child: BlocBuilder<WeatherBloc, WeatherState>(
            builder: (context, state) {
              if (state is WeatherLoading) {
                return const CircularProgressIndicator(color: Colors.white);
              } else if (state is WeatherError) {
                return Text(state.message);
              } else if (state is WeatherLoaded) {
                final weather = state.weather;
                final location = state.location;
                DateTime now = DateTime.now();
                final hours = weather.hourly.where((day) {
                  return day.time.isAfter(now) &&
                      day.time.isBefore(now.add(const Duration(hours: 12)));
                }).toList();
                return Column(
                  children: [
                    Text(
                      location.name,
                      style: const TextStyle(fontSize: 30, color: Colors.white),
                    ),
                    Text(
                      subheadline(location.region, location.country),
                      style: const TextStyle(fontSize: 20, color: Colors.black),
                    ),
                    const SizedBox(height: 30),
                    SfCartesianChart(
                      primaryXAxis: CategoryAxis(
                        labelRotation: 45,
                        majorGridLines: const MajorGridLines(width: 0),
                        labelStyle: const TextStyle(color: Colors.black),
                      ),
                      primaryYAxis: NumericAxis(
                        labelStyle: const TextStyle(color: Colors.black),
                        labelFormat: '{value}°C',
                      ),
                      series: <ChartSeries>[
                        SplineSeries<Day, String>(
                          dataSource: hours,
                          markerSettings: const MarkerSettings(
                              isVisible: true, color: Colors.blueAccent),
                          xValueMapper: (Day data, _) =>
                              "${data.time.hour.toString().padLeft(2, '0')}:00",
                          yValueMapper: (Day data, _) => data.temperature,
                        )
                      ],
                    ),
                    // const SizedBox(height: 30),
                    SizedBox(
                      height: 200,
                      // width: MediaQuery.of(context).size.width,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: hours.length,
                        itemBuilder: (context, index) {
                          final hour = hours[index];
                          final info = weatherCodeToInfo[hour.weathercode];
                          return Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              children: [
                                Text(
                                  "${hour.time.hour.toString().padLeft(2, '0')}:00",
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.blueGrey[800]),
                                ),
                                Icon(
                                  info!.icon,
                                  size: 30,
                                  color: Colors.blueAccent,
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  "${hour.temperature}°C",
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.blueGrey[800]),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Icon(
                                      Icons.air,
                                      color: Colors.blueAccent,
                                      size: 20,
                                    ),
                                    const SizedBox(width: 4),
                                    Text(
                                      "${hours[index].windspeed} km/h",
                                      style: TextStyle(
                                        fontSize: 15,
                                        color: Colors.blueGrey[800],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                );
              } else {
                return const Text("Search for a city");
              }
            },
          ),
        ),
      ),
    );
  }
}
