part of 'weather_bloc.dart';

sealed class WeatherState extends Equatable {
  const WeatherState({required this.isSearching});

  final bool isSearching;
  @override
  List<Object> get props => [isSearching];
}

final class WeatherInitial extends WeatherState {
  const WeatherInitial() : super(isSearching: false);
}

final class WeatherLoaded extends WeatherState {
  const WeatherLoaded({required this.location, required this.weather})
      : super(isSearching: false);

  final Location location;
  final Weather weather;

  @override
  List<Object> get props => [location, weather];
}

final class WeatherLoading extends WeatherState {
  const WeatherLoading() : super(isSearching: false);
}

final class SearchLoading extends WeatherState {
  const SearchLoading() : super(isSearching: true);
}

final class WeatherSearch extends WeatherState {
  const WeatherSearch({required this.searchText}) : super(isSearching: true);

  final String searchText;

  @override
  List<Object> get props => [searchText];
}

final class WeatherLocations extends WeatherState {
  const WeatherLocations({required this.locations}) : super(isSearching: true);

  final List<Location> locations;

  @override
  List<Object> get props => [locations];
}

final class WeatherError extends WeatherState {
  const WeatherError({required this.message}) : super(isSearching: false);

  final String message;

  @override
  List<Object> get props => [message];
}

final class SearchError extends WeatherState {
  const SearchError({required this.message}) : super(isSearching: true);

  final String message;

  @override
  List<Object> get props => [message];
}
