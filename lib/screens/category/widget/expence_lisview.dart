import 'package:flutter/material.dart';
import 'package:money_management/db/category/category_db.dart';
import 'package:money_management/models/category/category_model.dart';

class ExpenceListview extends StatelessWidget {
  const ExpenceListview({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: CategoryDb().expenceCategoryList,
      builder: (BuildContext ctx, List<CategoryModel> newList, Widget? _) {
        return ListView.separated(
            itemBuilder: (ct, index) {
              final category = newList[index];
              return Card(
                child: ListTile(
                  title: Text(category.name),
                  trailing: IconButton(
                    onPressed: () {
                      CategoryDb.instance.deleteCategory(category.id);
                    },
                    icon: const Icon(Icons.delete),
                  ),
                ),
              );
            },
            separatorBuilder: (ctx, index) {
              return const SizedBox(
                height: 0,
              );
            },
            itemCount: newList.length);
      },
    );
  }
}
