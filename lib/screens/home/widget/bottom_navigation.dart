import 'package:flutter/material.dart';
import 'package:money_management/screens/home/home_screen.dart';

class BottomNavigation extends StatelessWidget {
  const BottomNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: HomeScreen.selectedIndexNotfier,
      builder: (BuildContext ctx, int updatedIndex, Widget? _) {
        return BottomNavigationBar(
            currentIndex: updatedIndex,
            onTap: (newIndex) {
              HomeScreen.selectedIndexNotfier.value = newIndex;
            },
            items: const [
              // BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),

              BottomNavigationBarItem(
                  icon: Icon(Icons.currency_exchange), label: 'Transaction'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.category), label: 'Category'),
            ]);
      },
    );
  }
}
