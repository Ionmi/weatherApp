import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app_v2_proj/modules/Dashborad/bloc/weather_bloc.dart';

class SearchableAppBar extends StatelessWidget {
  const SearchableAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final weatherBloc = context.read<WeatherBloc>();

    return AppBar(
      backgroundColor: Colors.transparent,
      title: SearchBar(
          backgroundColor: const MaterialStatePropertyAll(Colors.transparent),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50),
              side: const BorderSide(color: Colors.white, width: 1),
            ),
          ),
          textStyle: const MaterialStatePropertyAll(
            TextStyle(color: Colors.white),
          ),
          hintStyle: const MaterialStatePropertyAll(
            TextStyle(color: Color.fromARGB(134, 255, 255, 255)),
          ),
          constraints: const BoxConstraints(maxHeight: 150),
          controller: weatherBloc.textController,
          focusNode: weatherBloc.focusNode,
          hintText: "Search",
          elevation: MaterialStateProperty.all(1),
          onSubmitted: (value) {
            weatherBloc.add(WeatherLocationSubmitedEvent(searchText: value));
          },
          onChanged: (value) {
            weatherBloc.add(WeatherSearchEvent(searchText: value));
          },
          trailing: <Widget>[
            Transform.translate(
              offset: const Offset(8, 0),
              child: BlocBuilder<WeatherBloc, WeatherState>(
                builder: (context, state) {
                  if (state.isSearching) {
                    return IconButton(
                      onPressed: () {
                        weatherBloc.textController.clear();
                        weatherBloc.focusNode.unfocus();
                        weatherBloc
                            .add(const WeatherSearchEvent(searchText: ""));
                      },
                      icon: const Icon(Icons.clear, size: 30),
                      color: Colors.white,
                      padding: const EdgeInsets.all(0),
                    );
                  } else {
                    return IconButton(
                      onPressed: () {
                        weatherBloc.add(WeatherGeoLocationEvent());
                      },
                      icon: const Icon(
                        Icons.near_me,
                        size: 25,
                        fill: 1.0,
                      ),
                      color: Colors.white,
                      padding: const EdgeInsets.all(0),
                    );
                  }
                },
              ),
            ),
          ]),
    );
  }
}
