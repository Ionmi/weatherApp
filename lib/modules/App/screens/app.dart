// ignore_for_file: file_names

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app_v2_proj/constants/app_constants.dart';
import 'package:weather_app_v2_proj/modules/Dashborad/dashboard.dart';

import '../../Dashborad/repos/repos.dart';
import '../cubit/internet_cubit.dart';

class App extends StatelessWidget {
  const App({
    super.key,
    required this.connectivity,
    required this.locationRepository,
    required this.weatherRepository,
  });

  final Connectivity connectivity;
  final LocationRepository locationRepository;
  final WeatherRepository weatherRepository;

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (context) => locationRepository,
        ),
        RepositoryProvider(
          create: (context) => weatherRepository,
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => InternetCubit(connectivity),
            lazy: false,
          ),
        ],
        child: const AppView(),
      ),
    );
  }
}

class AppView extends StatelessWidget {
  const AppView({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: Strings.appTitle,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: const DashboardScreen(),
    );
  }
}
