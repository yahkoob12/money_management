import 'package:flutter/material.dart';
import 'package:money_management/db/category/category_db.dart';
import 'package:money_management/db/transaction/transaction_db.dart';
import 'package:money_management/models/category/category_model.dart';
import 'package:money_management/models/transaction/transaction_model.dart';

class AddTransaction extends StatefulWidget {
  static const routeName = 'add transaction';
  const AddTransaction({super.key});

  @override
  State<AddTransaction> createState() => _AddTransactionState();
}

class _AddTransactionState extends State<AddTransaction> {
  DateTime? _selectedDate;
  CategoryType? _selectedCategorytype;
  CategoryModel? _selectedCategorymodel;

  String? _categoryID;

  final _purposeTextEditingController = TextEditingController();
  final _amountTextEditingController = TextEditingController();

  @override
  void initstate() {
    _selectedCategorytype = CategoryType.income;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _purposeTextEditingController,
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                    hintText: 'Purpose', border: OutlineInputBorder()),
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: _amountTextEditingController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                    hintText: 'Amount', border: OutlineInputBorder()),
              ),
              TextButton.icon(
                onPressed: () async {
                  final _selectedDateTemp = await showDatePicker(
                    context: context,
                    firstDate: DateTime(2001),
                    lastDate: DateTime.now(),
                    initialDate: DateTime.now(),
                  );
                  if (_selectedDate == null) {
                    return;
                  } else {
                    print(_selectedDateTemp.toString());
                    setState(() {
                      _selectedDate = _selectedDateTemp;
                    });
                  }
                },
                label: Text(_selectedDate == null
                    ? "Select Date"
                    : _selectedDate.toString()),
                icon: const Icon(Icons.calendar_today),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    children: [
                      Radio(
                        value: false,
                        groupValue: _selectedCategorytype,
                        onChanged: (newValue) {
                          setState(() {
                            _selectedCategorytype = CategoryType.income;
                            _categoryID = null;
                          });
                        },
                      ),
                      const Text('income'),
                    ],
                  ),
                  Row(
                    children: [
                      Radio(
                        value: false,
                        groupValue: _selectedCategorytype,
                        onChanged: (newValue) {
                          setState(() {
                            _selectedCategorytype = CategoryType.expence;
                            _categoryID = null;
                          });
                        },
                      ),
                      const Text('expence'),
                    ],
                  ),
                ],
              ),
              DropdownButton<String>(
                hint: const Text('Select Category'),
                value: _categoryID,
                items: (_selectedCategorytype == CategoryType.income
                        ? CategoryDb().incomeCategoryList
                        : CategoryDb().expenceCategoryList)
                    .value
                    .map((e) {
                  return DropdownMenuItem(
                    value: e.id,
                    child: Text(e.name),
                    onTap: () {
                      _selectedCategorymodel = e;
                    },
                  );
                }).toList(),
                onChanged: (selectedValue) {
                  print(selectedValue);
                  setState(() {
                    _categoryID = selectedValue;
                  });
                },
              ),
              ElevatedButton.icon(
                onPressed: () {
                  addTrnsaction();
                },
                label: const Text('Submit'),
                icon: const Icon(Icons.fingerprint),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> addTrnsaction() async {
    final _purposeText = _purposeTextEditingController.text;
    final _amountText = _amountTextEditingController.text;
    if (_purposeText.isEmpty) {
      return;
    }
    if (_amountText.isEmpty) {
      return;
    }
    if (_categoryID == null) {
      return;
    }
    if (_selectedDate == null) {
      return;
    }
    if (_selectedCategorymodel == null) {
      return;
    }
    final _parseAmount = double.tryParse(_amountText);
    if (_parseAmount == null) {
      return;
    }
    final _model = TransactionModel(
        purpose: _purposeText,
        amount: _parseAmount,
        date: _selectedDate!,
        type: _selectedCategorytype!,
        category: _selectedCategorymodel!);
    await TransactionDb.instance.addTransaction(_model);
    Navigator.of(context).pop();
    TransactionDb.instance.refresh();
  }
}
