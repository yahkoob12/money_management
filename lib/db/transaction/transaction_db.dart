import 'package:flutter/widgets.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:money_management/models/transaction/transaction_model.dart';

const TRANSACTION_DB_NAME = 'transaction-db';

abstract class TransactionDbFunction {
  Future<List<TransactionModel>> getAllTransaction();
  Future<void> addTransaction(TransactionModel obj);
  Future<void> deleteTransaction(String id);
}

class TransactionDb implements TransactionDbFunction {
  TransactionDb._internal();

  static TransactionDb instance = TransactionDb._internal();
  factory TransactionDb() {
    return instance;
  }

  ValueNotifier<List<TransactionModel>> transactionListNotfier =
      ValueNotifier([]);

  @override
  Future<void> addTransaction(TransactionModel obj) async {
    final _db = await Hive.openBox<TransactionModel>(TRANSACTION_DB_NAME);
    await _db.put(obj.id, obj);
  }

  Future<void> refresh() async {
    final list = await getAllTransaction();
    list.sort((first, second) => second.date.compareTo(first.date));
    transactionListNotfier.value.clear();
    transactionListNotfier.value.addAll(list);
    transactionListNotfier.notifyListeners();
  }

  @override
  Future<List<TransactionModel>> getAllTransaction() async {
    final _db = await Hive.openBox<TransactionModel>(TRANSACTION_DB_NAME);
    return _db.values.toList();
  }

  @override
  Future<void> deleteTransaction(String id) async {
    final _db = await Hive.openBox<TransactionModel>(TRANSACTION_DB_NAME);
    await _db.delete(id);
    refresh();
  }
}
