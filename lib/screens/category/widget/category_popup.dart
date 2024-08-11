import 'package:flutter/material.dart';
import 'package:money_management/db/category/category_db.dart';
import 'package:money_management/models/category/category_model.dart';

ValueNotifier<CategoryType> selectedCategoryNotifier =
    ValueNotifier(CategoryType.income);
Future<void> showCategoryAddPopup(BuildContext context) async {
  final nameEditingController = TextEditingController();
  showDialog(
    context: context,
    builder: (ctx) {
      return SimpleDialog(
        title: const Text('Add Category'),
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: nameEditingController,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(), hintText: 'Category Name'),
            ),
          ),
          const Padding(
              padding: EdgeInsets.all(0.8),
              child: Row(
                children: [
                  RadioButton(title: 'Income', type: CategoryType.income),
                  RadioButton(title: 'Expence', type: CategoryType.expence),
                ],
              )),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () {
                final name = nameEditingController.text.trim();
                if (name.isEmpty) {
                  return;
                }
                final type = selectedCategoryNotifier.value;
                final category = CategoryModel(
                  id: DateTime.now().microsecondsSinceEpoch.toString(),
                  name: name,
                  type: type,
                );
                CategoryDb.instance.insertCategory(category);
                Navigator.of(ctx).pop();
              },
              child: const Text('Add'),
            ),
          )
        ],
      );
    },
  );
}

class RadioButton extends StatelessWidget {
  final String title;
  final CategoryType type;
  const RadioButton({
    super.key,
    required this.title,
    required this.type,
  });

  //CategoryType? _type;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ValueListenableBuilder(
          valueListenable: selectedCategoryNotifier,
          builder: (BuildContext ctx, CategoryType newCategory, Widget? _) {
            return Radio<CategoryType>(
              value: type,
              groupValue: selectedCategoryNotifier.value,
              onChanged: (value) {
                if (value == null) {
                  return;
                }
                selectedCategoryNotifier.value = value;
                selectedCategoryNotifier.notifyListeners();
                // setState(
                //   () {
                //     _type = value;
                //   },
                // );
              },
            );
          },
        ),
        Text(title),
      ],
    );
  }
}
