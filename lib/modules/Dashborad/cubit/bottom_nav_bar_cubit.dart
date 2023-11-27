import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'bottom_nav_bar_state.dart';

class BottomNavBarCubit extends Cubit<BottomNavBarState> {
  PageController pageController;
  PageStorageKey pageStorageKey;

  BottomNavBarCubit()
      : pageController = PageController(keepPage: true),
        pageStorageKey = const PageStorageKey('pageStorageKey'),
        super(BottomNavBarInitial()) {
    pageController.addListener(_pageControllerListener);
  }

  void _pageControllerListener() {
    final currentIndex = pageController.page?.round() ?? 0;
    emit(BottomNavBarPage(currentIndex));
  }

  void updateIndex(int currentIndex) {
    pageController.animateToPage(
      currentIndex,
      duration: const Duration(milliseconds: 300),
      curve: Curves.ease,
    );
    emit(BottomNavBarPage(currentIndex));
  }

  void updateIndexToCurrent() {
    pageController.animateToPage(
      state.currentIndex,
      duration: const Duration(milliseconds: 300),
      curve: Curves.ease,
    );
    emit(BottomNavBarPage(0));
  }

  @override
  Future<void> close() {
    pageController.removeListener(_pageControllerListener);
    pageController.dispose();
    return super.close();
  }
}
