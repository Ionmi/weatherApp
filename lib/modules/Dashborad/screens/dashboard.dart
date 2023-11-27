import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app_v2_proj/modules/Dashborad/screens/suggestions.dart';
import 'package:weather_app_v2_proj/widgets/appbar.dart';
import 'package:weather_app_v2_proj/widgets/bottom_bar.dart';

import '../../App/cubit/internet_cubit.dart';
import '../bloc/weather_bloc.dart';
import '../cubit/bottom_nav_bar_cubit.dart';
import '../repos/repos.dart';
import 'screens.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => BottomNavBarCubit(),
          ),
          BlocProvider(
            create: (context) => WeatherBloc(
              locationRepository: context.read<LocationRepository>(),
              weatherRepository: context.read<WeatherRepository>(),
              internetCubit: context.read<InternetCubit>(),
            ),
          ),
        ],
        child: const Dashborad(),
      ),
      onWillPop: () async => false,
    );
  }
}

class Dashborad extends StatelessWidget {
  const Dashborad({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(milliseconds: 500), () {
      context.read<WeatherBloc>().add(WeatherGeoLocationEvent());
    });

    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(100),
        child: SearchableAppBar(),
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/drawing-background.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Builder(
          builder: (context) {
            if (context.watch<WeatherBloc>().state.isSearching) {
              return const Suggestions();
            } else {
              return PageView(
                key: context.read<BottomNavBarCubit>().pageStorageKey,
                controller: context.read<BottomNavBarCubit>().pageController,
                children: const [
                  Currently(),
                  Today(),
                  Weekly(),
                ],
              );
            }
          },
        ),
      ),
      bottomNavigationBar: Builder(builder: (context) {
        if (context.watch<WeatherBloc>().state.isSearching) {
          return const SizedBox.shrink();
        } else {
          return const BottomBar();
        }
      }),
    );
  }
}
