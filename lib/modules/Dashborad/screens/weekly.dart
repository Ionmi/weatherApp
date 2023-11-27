import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:weather_app_v2_proj/constants/weather_map_constants.dart';

import '../bloc/weather_bloc.dart';
import '../models/weather.dart';
import 'currently.dart';

class Weekly extends StatelessWidget {
  const Weekly({
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
                final days = weather.daily;
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
                        SplineSeries<Daily, String>(
                          dataSource: days,
                          color: Colors.red,
                          markerSettings: const MarkerSettings(
                            isVisible: true,
                            color: Colors.red,
                          ),
                          xValueMapper: (Daily data, _) =>
                              "${data.time.day.toString()}/${data.time.month.toString()}",
                          yValueMapper: (Daily data, _) => data.temperature2MMax,
                        ),
                        SplineSeries<Daily, String>(
                          color: Colors.blueAccent,
                          dataSource: days,
                          markerSettings: const MarkerSettings(
                            isVisible: true,
                            color: Colors.blueAccent
                          ),
                          xValueMapper: (Daily data, _) =>
                              "${data.time.day.toString()}/${data.time.month.toString()}",
                          yValueMapper: (Daily data, _) => data.temperature2MMin,
                        )
                      ],
                    ),
                    // const SizedBox(height: 30),
                    SizedBox(
                      height: 200,
                      // width: MediaQuery.of(context).size.width,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: days.length,
                        itemBuilder: (context, index) {
                          final day = days[index];
                          final info = weatherCodeToInfo[day.weathercode];
                          return Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              children: [
                                Text(
                                  "${day.time.day.toString()}/${day.time.month.toString()}",
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
                                  "${day.temperature2MMax}°C",
                                  style: const TextStyle(
                                    fontSize: 20,
                                    color: Colors.red,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Text(
                                  "${day.temperature2MMin}°C",
                                  style: const TextStyle(
                                    fontSize: 20,
                                    color: Colors.blueAccent,
                                    fontWeight: FontWeight.w500,
                                  ),
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
