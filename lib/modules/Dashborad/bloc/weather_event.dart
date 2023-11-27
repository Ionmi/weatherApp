part of 'weather_bloc.dart';

sealed class WeatherEvent extends Equatable {
  const WeatherEvent();

  @override
  List<Object> get props => [];
}

final class WeatherGeoLocationEvent extends WeatherEvent {}

final class WeatherSearchEvent extends WeatherEvent {
  const WeatherSearchEvent({required this.searchText});

  final String searchText;

  @override
  List<Object> get props => [searchText];
}

final class WeatherLocationSelectedEvent extends WeatherEvent {
  const WeatherLocationSelectedEvent({required this.location});

  final Location location;

  @override
  List<Object> get props => [location];
}

final class WeatherLocationSubmitedEvent extends WeatherEvent {
  const WeatherLocationSubmitedEvent({required this.searchText});

  final String searchText;

  @override
  List<Object> get props => [searchText];
}
