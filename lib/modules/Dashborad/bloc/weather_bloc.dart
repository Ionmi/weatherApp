import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app_v2_proj/modules/App/cubit/internet_cubit.dart';
import 'package:weather_app_v2_proj/modules/Dashborad/models/location.dart';
import 'package:weather_app_v2_proj/modules/Dashborad/repos/repos.dart';
import 'package:weather_app_v2_proj/utils/services/location_service.dart';

import '../models/weather.dart';

part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final InternetCubit internetCubit;
  final LocationRepository locationRepository;
  final WeatherRepository weatherRepository;
  final TextEditingController textController;
  final FocusNode focusNode;

  WeatherBloc(
      {required this.internetCubit,
      required this.locationRepository,
      required this.weatherRepository})
      : focusNode = FocusNode(),
        textController = TextEditingController(),
        super(const WeatherLoading()) {
    on<WeatherSearchEvent>((event, emit) async {
      await _onSearch(emit, event);
    }, transformer: droppable());
    on<WeatherLocationSubmitedEvent>((event, emit) async {
      await _onSubmit(emit, event);
    });
    on<WeatherGeoLocationEvent>((event, emit) async {
      await _onGeolocation(emit);
    });
    on<WeatherLocationSelectedEvent>((event, emit) async {
      await _onLocationSelected(emit, event);
    });
  }

  Future<void> _onLocationSelected(
      Emitter<WeatherState> emit, WeatherLocationSelectedEvent event) async {
    if (internetCubit.state is InternetDisconnected) {
      emit(const WeatherError(message: "No internet connection"));
      return;
    }
    emit(const WeatherLoading());
    _updateSearchBarValue(event.location.name);
    try {
      final Weather weather = await weatherRepository.query(
          lat: event.location.lat, lon: event.location.lon);

      emit(WeatherLoaded(location: event.location, weather: weather));
    } catch (e) {
      emit(SearchError(message: e.toString()));
      debugPrint(e.toString());
    }
  }

  Future<void> _onSearch(
      Emitter<WeatherState> emit, WeatherSearchEvent event) async {
    if (event.searchText.isEmpty) {
      emit(const WeatherInitial());
      return;
    }
    if (internetCubit.state is InternetDisconnected) {
      emit(const WeatherError(message: "No internet connection"));
      return;
    }
    emit(const SearchLoading());
    try {
      final List<Location> locations =
          await locationRepository.name(event.searchText);
      if (locations.isEmpty) {
        emit(const SearchError(message: "No results found"));
        return;
      }
      emit(WeatherLocations(locations: locations));
    } catch (e) {
      emit(SearchError(message: e.toString()));
      debugPrint(e.toString());
    }
  }

  Future<void> _onSubmit(
      Emitter<WeatherState> emit, WeatherLocationSubmitedEvent event) async {
    if (event.searchText.isEmpty) {
      emit(const WeatherInitial());
      return;
    }
    if (internetCubit.state is InternetDisconnected) {
      emit(const WeatherError(message: "No internet connection"));
      return;
    }
    emit(const SearchLoading());
    try {
      final List<Location> locations =
          await locationRepository.name(event.searchText);
      if (locations.isEmpty) {
        emit(const SearchError(message: "No results found"));
        return;
      }
      final Weather weather = await weatherRepository.query(
          lat: locations[0].lat, lon: locations[0].lon);

      emit(WeatherLoaded(location: locations[0], weather: weather));
    } catch (e) {
      emit(SearchError(message: e.toString()));
      debugPrint(e.toString());
    }
  }

  Future<void> _onGeolocation(Emitter<WeatherState> emit) async {
    if (internetCubit.state is InternetDisconnected) {
      emit(const WeatherError(message: "No internet connection"));
      return;
    }
    emit(const WeatherLoading());
    try {
      _clearSearchText();
      final geoLocation = await GeoLocationService.determinePosition();

      final lon = geoLocation.longitude.toDouble();
      final lat = geoLocation.latitude.toDouble();
      final Location location =
          await locationRepository.coordinates(lat: lat, lon: lon);
      _updateSearchBarValue(location.name);

      final Weather weather = await weatherRepository.query(
        lat: location.lat,
        lon: location.lon,
      );
      emit(WeatherLoaded(location: location, weather: weather));
    } catch (e) {
      emit(WeatherError(message: e.toString()));
      debugPrint(e.toString());
    }
  }

  void _updateSearchBarValue(String value) {
    textController.text = value;
    focusNode.unfocus();
  }

  void _clearSearchText() {
    textController.clear();
  }

  @override
  Future<void> close() {
    focusNode.dispose();

    textController.dispose();
    return super.close();
  }
}
