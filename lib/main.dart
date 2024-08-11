import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:money_management/models/transaction/transaction_model.dart';
import 'package:money_management/screens/add_transaction/add_transaction.dart';
import 'package:money_management/db/category/category_db.dart';
import 'package:money_management/models/category/category_model.dart';
import 'package:money_management/screens/home/home_screen.dart';

Future<void> main() async {
  final obj1 = CategoryDb();
  final obj2 = CategoryDb();
  // print('Object comparing');
  // print(obj1 == obj2);

  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  if (!Hive.isAdapterRegistered(CategoryTypeAdapter().typeId)) {
    Hive.registerAdapter(CategoryTypeAdapter());
  }
  if (!Hive.isAdapterRegistered(CategoryModelAdapter().typeId)) {
    Hive.registerAdapter(CategoryModelAdapter());
  }
  if (!Hive.isAdapterRegistered(TransactionModelAdapter().typeId)) {
    Hive.registerAdapter(TransactionModelAdapter());
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Money',
      theme: ThemeData(primaryColor: Colors.yellow),
      home: HomeScreen(),
      routes: {AddTransaction.routeName: (ctx) => const AddTransaction()},
    );
  }
}
