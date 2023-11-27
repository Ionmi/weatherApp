import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app_v2_proj/modules/Dashborad/cubit/bottom_nav_bar_cubit.dart';

class BottomBar extends StatelessWidget {
  const BottomBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BottomNavBarCubit, BottomNavBarState>(
      builder: (context, state) {
        return BottomNavigationBar(
          selectedItemColor: Colors.white,
          elevation: 0,
          backgroundColor: Colors.transparent,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.schedule),
              label: "Currently",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.today),
              label: "Today",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.date_range),
              label: "Weekly",
            ),
          ],
          currentIndex: state.currentIndex,
          onTap: (index) {
            context.read<BottomNavBarCubit>().updateIndex(index);
          },
        );
      },
    );
  }
}
