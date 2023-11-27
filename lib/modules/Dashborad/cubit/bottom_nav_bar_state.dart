// Estados del Cubit
part of 'bottom_nav_bar_cubit.dart';

abstract class BottomNavBarState {
  const BottomNavBarState({required this.currentIndex});

  final int currentIndex;
}

class BottomNavBarInitial extends BottomNavBarState {
  BottomNavBarInitial() : super(currentIndex: 0);
}

class BottomNavBarPage extends BottomNavBarState {
  BottomNavBarPage(index) : super(currentIndex: index);
}

// abstract class BottomNavBarState {}

// class BottomNavBarPage extends BottomNavBarState {
//   final int currentIndex;

//   BottomNavBarPage(this.currentIndex);
// }