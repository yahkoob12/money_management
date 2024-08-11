import 'package:flutter/material.dart';
import 'package:money_management/screens/add_transaction/add_transaction.dart';
import 'package:money_management/screens/category/category.dart';
import 'package:money_management/screens/category/widget/category_popup.dart';
import 'package:money_management/screens/home/widget/bottom_navigation.dart';
import 'package:money_management/screens/transaction/transaction.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  static ValueNotifier<int> selectedIndexNotfier = ValueNotifier(0);
  final _pages = [const TransactionScreen(), const CategoryScreen()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Money Manage'),
      ),
      bottomNavigationBar: const BottomNavigation(),
      body: SafeArea(
        child: ValueListenableBuilder(
          valueListenable: selectedIndexNotfier,
          builder: (BuildContext context, int updatedIndex, _) {
            return _pages[updatedIndex];
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (selectedIndexNotfier.value == 0) {
            print('add transaction');
            Navigator.of(context).pushNamed(AddTransaction.routeName);
          } else {
            print('add category');
            showCategoryAddPopup(context);
            // final _sample = CategoryModel(
            //     id: DateTime.now().microsecondsSinceEpoch.toString(),
            //     name: 'Travel',
            //     type: CategoryType.expence);
            // CategoryDb().insertCategory(_sample);
          }
        },
        child: const Icon(Icons.add_to_photos_outlined),
      ),
    );
  }
}
