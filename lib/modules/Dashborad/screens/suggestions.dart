import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/weather_bloc.dart';

class Suggestions extends StatelessWidget {
  const Suggestions({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WeatherBloc, WeatherState>(
      builder: (context, state) {
        if (state is SearchLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is WeatherLocations) {
          final weatherLocations = state.locations;
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: ListView.separated(
              physics: const BouncingScrollPhysics(),
              itemCount: weatherLocations.length,
              separatorBuilder: (context, index) => const Divider(height: 0),
              itemBuilder: (context, index) {
                final name = weatherLocations[index].name;
                final region = weatherLocations[index].region;
                final country = weatherLocations[index].country;
                return ListTile(
                  title:
                      ListTileRow(name: name, region: region, country: country),
                  onTap: () {
                    context.read<WeatherBloc>().add(
                          WeatherLocationSelectedEvent(
                              location: weatherLocations[index]),
                        );
                  },
                );
              },
            ),
          );
        } else if (state is SearchError) {
          final searchError = state;
          return Center(child: Text(searchError.message));
        } else {
          return const Center(child: Text("Search"));
        }
      },
    );
  }
}

class ListTileRow extends StatelessWidget {
  const ListTileRow({
    super.key,
    required this.name,
    required this.region,
    required this.country,
  });

  final String name;
  final String? region;
  final String? country;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          country != null ? Icons.location_city : Icons.location_on,
          color: Colors.white,
          size: 25,
          weight: 1.0,
        ),
        const SizedBox(width: 8),
        Text(
          name,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: Color.fromARGB(255, 0, 0, 0),
          ),
        ),
        Flexible(
          child: Text(
            '${region != null ? ' $region' : ''}${country != null ? ', $country' : ''}',
            maxLines: 1,
            style: const TextStyle(
              overflow: TextOverflow.ellipsis,
              fontWeight: FontWeight.w500,
              color: Color.fromARGB(255, 0, 0, 0),
            ),
          ),
        ),
      ],
    );
  }
}
