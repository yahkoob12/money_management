import 'package:flutter/material.dart';
import 'package:money_management/db/category/category_db.dart';
import 'package:money_management/screens/category/widget/expence_lisview.dart';
import 'package:money_management/screens/category/widget/income_listview.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController = TabController(length: 2, vsync: this);

  @override
  void iniState() {
    _tabController = TabController(length: 2, vsync: this);
    CategoryDb().getCategories().then((value) {
      print('categories get');
      print(value.toString());
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TabBar(
          controller: _tabController,
          tabs: const [
            Tab(
              icon: Icon(Icons.monetization_on_outlined),
              text: 'Income',
            ),
            Tab(
              icon: Icon(Icons.money_off),
              text: 'Expence',
            ),
          ],
        ),
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: const [
              IncomeListview(),
              ExpenceListview(),
            ],
          ),
        ),
      ],
    );
  }
}
