import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:weather_app_v2_proj/utils/debug/app_bloc_observer.dart';

import 'modules/App/app.dart';
import 'modules/Dashborad/repos/repos.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = AppBlocObserver();
  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: kIsWeb
        ? HydratedStorage.webStorageDirectory
        : await getTemporaryDirectory(),
  );

  runApp(
    App(
      connectivity: Connectivity(),
      locationRepository: LocationRepository(),
      weatherRepository: WeatherRepository(),
    ),
  );
}
